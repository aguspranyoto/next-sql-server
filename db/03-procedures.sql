-- 03-procedures.sql
-- Table type + stored procedure pencatat transaksi.
-- SATU-SATUNYA jalur yang boleh mengubah Barang.Stok.
-- Dijalankan SETELAH 01-schema.sql dan SEBELUM 02-seed.sql,
-- supaya data seed pun masuk lewat procedure ini (bukti aturan berlaku umum).

USE InventoryDB;
GO

-- Tipe tabel untuk detail multi-baris dari aplikasi (TVP).
IF TYPE_ID('dbo.TransaksiDetailType') IS NULL
BEGIN
    CREATE TYPE dbo.TransaksiDetailType AS TABLE (
        BarangId INT NOT NULL,
        Qty      INT NOT NULL
    );
END
GO

CREATE OR ALTER PROCEDURE dbo.sp_SimpanTransaksi
    @Tanggal    DATETIME2(0) = NULL,   -- NULL = sekarang (SYSDATETIME)
    @Tipe       CHAR(1),               -- 'I' masuk / 'O' keluar
    @Keterangan NVARCHAR(255) = NULL,
    @Details    dbo.TransaksiDetailType READONLY
AS
BEGIN
    SET NOCOUNT ON;

    -- ---- Validasi input (di luar transaksi: gagal cepat, tanpa lock) ----
    IF (@Tipe NOT IN ('I', 'O'))
        THROW 50001, 'Tipe transaksi harus ''I'' (masuk) atau ''O'' (keluar).', 1;

    IF NOT EXISTS (SELECT 1 FROM @Details)
        THROW 50002, 'Detail transaksi kosong.', 1;

    IF EXISTS (SELECT 1 FROM @Details WHERE Qty IS NULL OR Qty <= 0)
        THROW 50003, 'Qty harus lebih besar dari 0.', 1;

    IF EXISTS (
        SELECT 1 FROM @Details AS d
        LEFT JOIN dbo.Barang AS b ON b.BarangId = d.BarangId
        WHERE b.BarangId IS NULL
    )
        THROW 50004, 'Ada BarangId yang tidak dikenal.', 1;

    -- Satukan baris duplikat per barang supaya cek stok & update atomik.
    DECLARE @Agg TABLE (BarangId INT PRIMARY KEY, Qty INT NOT NULL);
    INSERT INTO @Agg (BarangId, Qty)
    SELECT BarangId, SUM(Qty) FROM @Details GROUP BY BarangId;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO dbo.Transaksi (Tanggal, Tipe, Keterangan)
        VALUES (ISNULL(@Tanggal, SYSDATETIME()), @Tipe, @Keterangan);

        DECLARE @NewId INT = SCOPE_IDENTITY();

        INSERT INTO dbo.TransaksiDetail (TransaksiId, BarangId, Qty)
        SELECT @NewId, BarangId, Qty FROM @Details;

        IF (@Tipe = 'O')
        BEGIN
            -- Kunci baris barang yang disentuh sampai COMMIT (anti race-condition),
            -- lalu tolak bila ada yang stoknya tidak mencukupi.
            IF EXISTS (
                SELECT 1
                FROM @Agg AS a
                JOIN dbo.Barang AS b WITH (UPDLOCK, HOLDLOCK) ON b.BarangId = a.BarangId
                WHERE b.Stok < a.Qty
            )
            BEGIN
                ROLLBACK TRANSACTION;
                THROW 50005, 'Stok tidak mencukupi untuk salah satu barang.', 1;
            END

            UPDATE b SET Stok = b.Stok - a.Qty
            FROM dbo.Barang AS b
            JOIN @Agg AS a ON a.BarangId = b.BarangId;
        END
        ELSE
        BEGIN
            UPDATE b SET Stok = b.Stok + a.Qty
            FROM dbo.Barang AS b
            JOIN @Agg AS a ON a.BarangId = b.BarangId;
        END

        COMMIT TRANSACTION;

        SELECT @NewId AS TransaksiId;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0 ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END
GO
