-- 01-schema.sql
-- Skema inti database InventoryDB.
-- Dijalankan pertama. Idempoten (aman diulang).
-- Aturan inti: kolom Barang.Stok TIDAK PERNAH ditulis langsung oleh aplikasi.
-- Satu-satunya penulis Stok adalah dbo.sp_SimpanTransaksi (lihat 03-procedures.sql),
-- diperkuat lagi oleh DENY UPDATE kolom Stok untuk login aplikasi (lihat 04-viewer-login.sql).

IF DB_ID('InventoryDB') IS NULL
BEGIN
    PRINT 'Database InventoryDB belum ada. Buat dulu via db-setup.sh (CREATE DATABASE).';
END
GO

USE InventoryDB;
GO

-- ============ Tabel master barang ============
IF OBJECT_ID('dbo.Barang', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Barang (
        BarangId INT IDENTITY(1,1) PRIMARY KEY,
        Kode     VARCHAR(20)   NOT NULL UNIQUE,
        Nama     NVARCHAR(200) NOT NULL,
        Satuan   VARCHAR(20)   NOT NULL CONSTRAINT DF_Barang_Satuan DEFAULT ('Pcs'),
        Stok     INT           NOT NULL CONSTRAINT DF_Barang_Stok DEFAULT (0),
        Harga    DECIMAL(18,2) NOT NULL CONSTRAINT DF_Barang_Harga DEFAULT (0),
        CONSTRAINT CK_Barang_Stok  CHECK (Stok >= 0),
        CONSTRAINT CK_Barang_Harga CHECK (Harga >= 0)
    );
END
GO

-- ============ Tabel header transaksi ============
IF OBJECT_ID('dbo.Transaksi', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.Transaksi (
        TransaksiId INT IDENTITY(1,1) PRIMARY KEY,
        Tanggal     DATETIME2(0) NOT NULL CONSTRAINT DF_Transaksi_Tanggal DEFAULT (SYSDATETIME()),
        Tipe        CHAR(1)      NOT NULL,   -- 'I' = masuk (pembelian/saldo awal), 'O' = keluar (penjualan)
        Keterangan  NVARCHAR(255) NULL,
        CONSTRAINT CK_Transaksi_Tipe CHECK (Tipe IN ('I', 'O'))
    );
END
GO

-- ============ Tabel detail transaksi ============
IF OBJECT_ID('dbo.TransaksiDetail', 'U') IS NULL
BEGIN
    CREATE TABLE dbo.TransaksiDetail (
        DetailId    INT IDENTITY(1,1) PRIMARY KEY,
        TransaksiId INT NOT NULL,
        BarangId    INT NOT NULL,
        Qty         INT NOT NULL,
        CONSTRAINT FK_Detail_Transaksi FOREIGN KEY (TransaksiId) REFERENCES dbo.Transaksi (TransaksiId),
        CONSTRAINT FK_Detail_Barang    FOREIGN KEY (BarangId)    REFERENCES dbo.Barang (BarangId),
        CONSTRAINT CK_Detail_Qty CHECK (Qty > 0)
    );
END
GO

-- ============ Index ============
-- Dipakai ORDER BY Tanggal DESC di GET /api/transaksi dan filter rentang tanggal di laporan.
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Transaksi_Tanggal' AND object_id = OBJECT_ID('dbo.Transaksi'))
    CREATE INDEX IX_Transaksi_Tanggal ON dbo.Transaksi (Tanggal DESC);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_TransaksiDetail_TransaksiId' AND object_id = OBJECT_ID('dbo.TransaksiDetail'))
    CREATE INDEX IX_TransaksiDetail_TransaksiId ON dbo.TransaksiDetail (TransaksiId);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_TransaksiDetail_BarangId' AND object_id = OBJECT_ID('dbo.TransaksiDetail'))
    CREATE INDEX IX_TransaksiDetail_BarangId ON dbo.TransaksiDetail (BarangId);
GO

-- Pencarian Kode LIKE 'xxx%' di GET /api/barang.
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_Barang_Kode' AND object_id = OBJECT_ID('dbo.Barang'))
    CREATE INDEX IX_Barang_Kode ON dbo.Barang (Kode);
GO

-- ============ View stok + nilai persediaan ============
CREATE OR ALTER VIEW dbo.vw_StokBarang AS
SELECT
    b.BarangId,
    b.Kode,
    b.Nama,
    b.Satuan,
    b.Stok,
    b.Harga,
    NilaiPersediaan = b.Stok * b.Harga,
    TotalMasuk  = ISNULL(SUM(CASE WHEN t.Tipe = 'I' THEN d.Qty ELSE 0 END), 0),
    TotalKeluar = ISNULL(SUM(CASE WHEN t.Tipe = 'O' THEN d.Qty ELSE 0 END), 0)
FROM dbo.Barang AS b
LEFT JOIN dbo.TransaksiDetail AS d ON d.BarangId = b.BarangId
LEFT JOIN dbo.Transaksi AS t       ON t.TransaksiId = d.TransaksiId
GROUP BY b.BarangId, b.Kode, b.Nama, b.Satuan, b.Stok, b.Harga;
GO
