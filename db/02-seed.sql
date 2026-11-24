-- 02-seed.sql
-- Data master + riwayat transaksi 12 bulan terakhir (dibangkitkan: node scripts/gen-seed.mjs).
-- Isi: 91 barang, 248 transaksi. Idempoten: tidak berbuat apa-apa bila Barang sudah terisi.
-- Seluruh pergerakan stok masuk lewat dbo.sp_SimpanTransaksi (aturan berlaku juga untuk seed).

USE InventoryDB;
GO

SET NOCOUNT ON;
IF (SELECT COUNT(*) FROM dbo.Barang) = 0
BEGIN
    PRINT 'Seeding InventoryDB...';

    INSERT INTO dbo.Barang (Kode, Nama, Satuan, Harga)
    VALUES ('BRG-0001', N'Beras Premium 5Kg', 'Karung', 62500),
           ('BRG-0002', N'Gula Pasir 1Kg', 'Pack', 17500),
           ('BRG-0003', N'Minyak Goreng 2L', 'Pouch', 44500),
           ('BRG-0004', N'Tepung Terigu Protein Sedang 1Kg', 'Pack', 12500),
           ('BRG-0005', N'Mie Instan Goreng Dus 40', 'Dus', 118000),
           ('BRG-0006', N'Mie Instan Ayam Bawang Dus 40', 'Dus', 112000),
           ('BRG-0007', N'Sarden Kaleng 425G', 'Pcs', 21000),
           ('BRG-0008', N'Kecap Manis 550Ml', 'Botol', 26500),
           ('BRG-0009', N'Kopi Bubuk Robusta 250G', 'Pack', 32000),
           ('BRG-0010', N'Teh Celup Box 25', 'Pack', 15000),
           ('BRG-0011', N'Susu Kental Manis Kaleng 490G', 'Pcs', 13500),
           ('BRG-0012', N'Garam Dapur 500G', 'Pack', 6000),
           ('BRG-0013', N'Telur Ayam Negeri 1Kg', 'Kg', 28000),
           ('BRG-0014', N'Gula Merah Sisir 1Kg', 'Pack', 19000),
           ('BRG-0015', N'Saus Sambal 550Ml', 'Botol', 24000),
           ('BRG-0016', N'Penyedap Rasa Ayam 1Kg', 'Pack', 32000),
           ('BRG-0017', N'Santan Instan 200Ml', 'Pcs', 8500),
           ('BRG-0018', N'Biskuit Kaleng 485G', 'Kaleng', 34000),
           ('BRG-0019', N'Wafer Cokelat Dus 24', 'Dus', 85000),
           ('BRG-0020', N'Keripik Singkong Bal 2Kg', 'Ball', 45000),
           ('BRG-0021', N'Air Mineral 600Ml Dus 24', 'Dus', 54000),
           ('BRG-0022', N'Air Mineral Galon 19L', 'Galon', 20000),
           ('BRG-0023', N'Teh Manis Botol 450Ml Dus 24', 'Dus', 88000),
           ('BRG-0024', N'Kopi Sachet Renteng 10', 'Renteng', 15500),
           ('BRG-0025', N'Jus Jeruk 1L', 'Kotak', 18000),
           ('BRG-0026', N'Minuman Soda Kaleng 330Ml Pack 6', 'Pack', 45000),
           ('BRG-0027', N'Sirup Cocopandan 650Ml', 'Botol', 28000),
           ('BRG-0028', N'Susu UHT Cokelat 1L', 'Kotak', 21000),
           ('BRG-0029', N'Susu UHT Full Cream 1L', 'Kotak', 19500),
           ('BRG-0030', N'Minuman Energi Dus 24', 'Dus', 108000),
           ('BRG-0031', N'Kertas HVS A4 80Gsm Rim 500', 'Rim', 58000),
           ('BRG-0032', N'Buku Tulis 58 Lembar Lusin 12', 'Lusin', 48000),
           ('BRG-0033', N'Pulpen Hitam 0.5 Box 12', 'Box', 24000),
           ('BRG-0034', N'Pensil 2B Box 12', 'Box', 18000),
           ('BRG-0035', N'Spidol Whiteboard Hitam', 'Pcs', 12000),
           ('BRG-0036', N'Map Plastik Kancing Lusin 12', 'Lusin', 30000),
           ('BRG-0037', N'Hekter Stapler No.10', 'Set', 35000),
           ('BRG-0038', N'Isi Staples No.10', 'Box', 8000),
           ('BRG-0039', N'Lakban Bening 48Mm', 'Pcs', 12000),
           ('BRG-0040', N'Amplop Coklat Pack 100', 'Pack', 45000),
           ('BRG-0041', N'Penggaris Plastik 30Cm', 'Pcs', 5000),
           ('BRG-0042', N'Sticky Note 3x3', 'Pack', 15000),
           ('BRG-0043', N'Correction Tape', 'Pcs', 14000),
           ('BRG-0044', N'Tinta Isi Ulang Printer 100Ml', 'Botol', 45000),
           ('BRG-0045', N'Baterai AA Pack 4', 'Pack', 28000),
           ('BRG-0046', N'Baterai AAA Pack 4', 'Pack', 26000),
           ('BRG-0047', N'Lampu LED 9W Putih', 'Pcs', 22000),
           ('BRG-0048', N'Stop Kontak Arde', 'Pcs', 18000),
           ('BRG-0049', N'Saklar Engkel', 'Pcs', 15000),
           ('BRG-0050', N'Kabel Data USB-C 1M', 'Pcs', 35000),
           ('BRG-0051', N'Charger HP 25W', 'Pcs', 125000),
           ('BRG-0052', N'Kabel Roll 4 Lubang 10M', 'Pcs', 145000),
           ('BRG-0053', N'Senter LED Tangan', 'Pcs', 65000),
           ('BRG-0054', N'Kipas Angin Meja 12 Inci', 'Pcs', 185000),
           ('BRG-0055', N'Setrika Listrik', 'Pcs', 175000),
           ('BRG-0056', N'Rice Cooker 1.8L', 'Pcs', 325000),
           ('BRG-0057', N'Dispenser Galon Bawah', 'Pcs', 450000),
           ('BRG-0058', N'Lakban Listrik', 'Pcs', 8000),
           ('BRG-0059', N'Palu Cakar Gagang Fiber', 'Pcs', 45000),
           ('BRG-0060', N'Obeng Set 6 Pcs', 'Set', 75000),
           ('BRG-0061', N'Tang Kombinasi 8 Inci', 'Pcs', 55000),
           ('BRG-0062', N'Kunci Pas Set 14 Pcs', 'Set', 185000),
           ('BRG-0063', N'Meteran 5M', 'Pcs', 35000),
           ('BRG-0064', N'Gergaji Kayu 18 Inci', 'Pcs', 65000),
           ('BRG-0065', N'Mesin Bor 13Mm', 'Pcs', 385000),
           ('BRG-0066', N'Kuas Cat 2 Inci', 'Pcs', 12000),
           ('BRG-0067', N'Cat Tembok Interior 5Kg', 'Pail', 165000),
           ('BRG-0068', N'Semen 40Kg', 'Sak', 65000),
           ('BRG-0069', N'Paku Campur 1Kg', 'Kg', 22000),
           ('BRG-0070', N'Sabun Cuci Piring 800Ml', 'Botol', 22000),
           ('BRG-0071', N'Deterjen Bubuk 1Kg', 'Pack', 24000),
           ('BRG-0072', N'Pewangi Pakaian 800Ml', 'Pouch', 21000),
           ('BRG-0073', N'Pembersih Lantai 800Ml', 'Botol', 19000),
           ('BRG-0074', N'Sabun Mandi Batang Pack 4', 'Pack', 18000),
           ('BRG-0075', N'Sampo Anti Ketombe 340Ml', 'Botol', 32000),
           ('BRG-0076', N'Pasta Gigi Mint 190G', 'Pcs', 18000),
           ('BRG-0077', N'Tisu Wajah 250 Lembar', 'Pack', 25000),
           ('BRG-0078', N'Sapu Ijuk Lantai', 'Pcs', 35000),
           ('BRG-0079', N'Alat Pel Lantai', 'Set', 45000),
           ('BRG-0080', N'Keset Kaki', 'Pcs', 25000),
           ('BRG-0081', N'Ember Plastik 15L', 'Pcs', 28000),
           ('BRG-0082', N'Sikat Gigi Dewasa Lusin 12', 'Lusin', 60000),
           ('BRG-0083', N'Masker Medis Box 50', 'Box', 25000),
           ('BRG-0084', N'Hand Sanitizer 500Ml', 'Botol', 35000),
           ('BRG-0085', N'Piring Melamin 9 Inci Lusin 12', 'Lusin', 120000),
           ('BRG-0086', N'Gelas Plastik Lusin 12', 'Lusin', 45000),
           ('BRG-0087', N'Sendok Makan Lusin 12', 'Lusin', 30000),
           ('BRG-0088', N'Pisau Dapur Set 3 Pcs', 'Set', 95000),
           ('BRG-0089', N'Wajan Anti Lengket 28Cm', 'Pcs', 125000),
           ('BRG-0090', N'Toples Plastik Set 3', 'Set', 55000),
           ('BRG-0091', N'Kantong Plastik Kresek 1Kg', 'Pack', 15000);

    DECLARE @D dbo.TransaksiDetailType;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0011', 67), ('BRG-0086', 58), ('BRG-0083', 60), ('BRG-0043', 21)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-02T09:26:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Sinar Abadi Jaya — PO-20250008', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0069', 42), ('BRG-0002', 60), ('BRG-0071', 103), ('BRG-0011', 74), ('BRG-0052', 5)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-04T14:59:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Indo Niaga Pratama — PO-20250003', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0028', 116), ('BRG-0037', 43), ('BRG-0031', 32)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-05T11:54:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Maju Bersama — PO-20250002', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0032', 36), ('BRG-0088', 34), ('BRG-0021', 73), ('BRG-0006', 90), ('BRG-0040', 43)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-05T13:06:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Tunas Bangsa Distribusi — PO-20250006', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0047', 39), ('BRG-0043', 35), ('BRG-0041', 29), ('BRG-0089', 34), ('BRG-0086', 49), ('BRG-0091', 41)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-06T10:45:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Tunas Bangsa Distribusi — PO-20250009', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0052', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-10T08:41:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Serba Ada Berkah — INV-20250010', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0091', 3)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-10T13:04:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Bu Siti — INV-20250007', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0086', 4)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-12T11:42:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Koperasi Karyawan Maju — INV-20250001', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0034', 34), ('BRG-0027', 76), ('BRG-0083', 29), ('BRG-0010', 32), ('BRG-0073', 97), ('BRG-0014', 53)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-12T16:48:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Maju Bersama — PO-20250004', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0050', 49), ('BRG-0061', 44), ('BRG-0042', 42), ('BRG-0070', 75)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-17T14:18:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Barokah Makmur — PO-20250007', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0017', 74), ('BRG-0065', 14), ('BRG-0046', 22), ('BRG-0045', 38), ('BRG-0071', 59)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-19T17:43:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Tunas Bangsa Distribusi — PO-20250005', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0001', 96), ('BRG-0002', 201), ('BRG-0003', 193), ('BRG-0004', 82), ('BRG-0005', 184), ('BRG-0006', 125), ('BRG-0007', 158), ('BRG-0008', 126), ('BRG-0009', 161), ('BRG-0010', 97), ('BRG-0011', 160), ('BRG-0012', 196), ('BRG-0013', 195), ('BRG-0014', 111), ('BRG-0015', 96), ('BRG-0016', 150), ('BRG-0017', 156), ('BRG-0018', 122), ('BRG-0019', 194), ('BRG-0020', 39)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-24T00:00:00', @Tipe = 'I', @Keterangan = N'Saldo awal — stok opname gudang (Sembako)', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0021', 114), ('BRG-0022', 196), ('BRG-0023', 83), ('BRG-0024', 114), ('BRG-0025', 184), ('BRG-0026', 171), ('BRG-0027', 107), ('BRG-0028', 165), ('BRG-0029', 127), ('BRG-0030', 62)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-24T00:00:00', @Tipe = 'I', @Keterangan = N'Saldo awal — stok opname gudang (Minuman)', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0031', 86), ('BRG-0032', 40), ('BRG-0033', 63), ('BRG-0034', 29), ('BRG-0035', 86), ('BRG-0036', 80), ('BRG-0037', 58), ('BRG-0038', 60), ('BRG-0039', 37), ('BRG-0040', 77), ('BRG-0041', 86), ('BRG-0042', 83), ('BRG-0043', 77), ('BRG-0044', 78)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-24T00:00:00', @Tipe = 'I', @Keterangan = N'Saldo awal — stok opname gudang (ATK)', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0045', 28), ('BRG-0046', 84), ('BRG-0047', 55), ('BRG-0048', 81), ('BRG-0049', 71), ('BRG-0050', 81), ('BRG-0051', 48), ('BRG-0052', 21), ('BRG-0053', 48), ('BRG-0054', 8), ('BRG-0055', 22), ('BRG-0056', 20), ('BRG-0057', 18), ('BRG-0058', 89)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-24T00:00:00', @Tipe = 'I', @Keterangan = N'Saldo awal — stok opname gudang (Elektronik)', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0059', 69), ('BRG-0060', 40), ('BRG-0061', 69), ('BRG-0062', 9), ('BRG-0063', 83), ('BRG-0064', 50), ('BRG-0065', 22), ('BRG-0066', 88), ('BRG-0067', 71), ('BRG-0068', 69), ('BRG-0069', 48)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-24T00:00:00', @Tipe = 'I', @Keterangan = N'Saldo awal — stok opname gudang (Perkakas)', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0070', 190), ('BRG-0071', 211), ('BRG-0072', 86), ('BRG-0073', 204), ('BRG-0074', 133), ('BRG-0075', 133), ('BRG-0076', 91), ('BRG-0077', 164), ('BRG-0078', 43), ('BRG-0079', 83), ('BRG-0080', 32), ('BRG-0081', 34), ('BRG-0082', 68), ('BRG-0083', 44), ('BRG-0084', 46)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-24T00:00:00', @Tipe = 'I', @Keterangan = N'Saldo awal — stok opname gudang (Kebersihan)', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0085', 31), ('BRG-0086', 82), ('BRG-0087', 89), ('BRG-0088', 53), ('BRG-0089', 73), ('BRG-0090', 39), ('BRG-0091', 158)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-24T00:00:00', @Tipe = 'I', @Keterangan = N'Saldo awal — stok opname gudang (Dapur)', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0065', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-24T14:37:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Hj. Fatimah — INV-20250004', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0002', 12), ('BRG-0057', 2), ('BRG-0001', 3), ('BRG-0073', 11), ('BRG-0038', 4)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-25T08:15:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Koperasi Karyawan Maju — INV-20250003', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0003', 3)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-25T16:52:00', @Tipe = 'O', @Keterangan = N'Penjualan ke RM Padang Sederhana — INV-20250011', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0049', 25), ('BRG-0027', 84), ('BRG-0058', 25), ('BRG-0001', 31), ('BRG-0021', 84)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-27T09:16:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Sumber Makmur Abadi — PO-20250001', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0040', 1), ('BRG-0039', 5)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-27T10:07:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Serba Ada Berkah — INV-20250008', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0083', 1), ('BRG-0085', 4), ('BRG-0028', 12), ('BRG-0077', 8)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-11-28T08:19:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Pak Dedi — INV-20250009', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0071', 103), ('BRG-0059', 47)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-12-02T15:10:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Tunas Bangsa Distribusi — PO-20250014', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0012', 35), ('BRG-0063', 27)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-12-03T15:13:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Maju Bersama — PO-20250015', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0023', 9), ('BRG-0087', 6), ('BRG-0073', 9)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-12-05T14:29:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Kantin Sekolah Ceria — INV-20250019', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0028', 11), ('BRG-0068', 3)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-12-07T13:42:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Kelontong Hj. Aminah — INV-20250023', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0004', 58), ('BRG-0024', 54)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-12-09T11:48:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Sumber Makmur Abadi — PO-20250011', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0044', 5), ('BRG-0091', 12)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-12-10T09:56:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Koperasi Karyawan Maju — INV-20250016', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0079', 22), ('BRG-0002', 31), ('BRG-0076', 75), ('BRG-0005', 71), ('BRG-0090', 23)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-12-11T14:24:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Sumber Makmur Abadi — PO-20250013', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0025', 43), ('BRG-0008', 81), ('BRG-0001', 111), ('BRG-0014', 26), ('BRG-0037', 33), ('BRG-0053', 16)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-12-11T15:49:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Indo Niaga Pratama — PO-20250010', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0015', 112), ('BRG-0048', 30), ('BRG-0064', 22), ('BRG-0031', 58), ('BRG-0021', 62), ('BRG-0040', 22)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-12-12T08:17:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Berkah Jaya Abadi — PO-20250012', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0072', 11), ('BRG-0008', 2), ('BRG-0073', 7), ('BRG-0071', 7), ('BRG-0082', 1)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-12-14T08:22:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Pak Dedi — INV-20250014', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0033', 2), ('BRG-0079', 4), ('BRG-0017', 6), ('BRG-0037', 1)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-12-15T09:16:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Serba Ada Berkah — INV-20250021', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0003', 2), ('BRG-0029', 6), ('BRG-0040', 3)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-12-20T17:34:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Kantin Sekolah Ceria — INV-20250020', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0053', 3), ('BRG-0010', 9), ('BRG-0019', 3)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-12-21T13:46:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Pak Haji Usman — INV-20250022', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0035', 5)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-12-21T17:45:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Bu Siti — INV-20250017', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0089', 6), ('BRG-0078', 6), ('BRG-0075', 7), ('BRG-0028', 4), ('BRG-0052', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-12-22T08:13:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Serba Ada Berkah — INV-20250015', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0038', 4), ('BRG-0010', 5), ('BRG-0018', 3), ('BRG-0020', 4)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2025-12-22T16:18:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Kantin Sekolah Ceria — INV-20250018', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0058', 45), ('BRG-0054', 10), ('BRG-0084', 30)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-01-01T13:50:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Berkah Jaya Abadi — PO-20260016', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0025', 8), ('BRG-0014', 7)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-01-01T14:40:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Fresh Ibu Dewi — INV-20260027', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0018', 2), ('BRG-0072', 6), ('BRG-0070', 11), ('BRG-0055', 1)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-01-04T10:46:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Bu Siti — INV-20260032', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0085', 54), ('BRG-0028', 56), ('BRG-0023', 43)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-01-07T10:43:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Maju Bersama — PO-20260017', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0050', 6), ('BRG-0054', 2), ('BRG-0047', 4)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-01-08T09:53:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Koperasi Karyawan Maju — INV-20260029', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0029', 7)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-01-08T17:08:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Fresh Ibu Dewi — INV-20260024', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0057', 1), ('BRG-0014', 3), ('BRG-0011', 8), ('BRG-0049', 6)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-01-10T15:50:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Hj. Fatimah — INV-20260028', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0031', 4), ('BRG-0073', 2), ('BRG-0062', 2), ('BRG-0071', 5), ('BRG-0016', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-01-11T09:46:00', @Tipe = 'O', @Keterangan = N'Penjualan ke RM Padang Sederhana — INV-20260030', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0036', 1), ('BRG-0052', 1), ('BRG-0006', 9)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-01-13T16:03:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Hj. Fatimah — INV-20260031', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0058', 52), ('BRG-0063', 25)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-01-14T17:05:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Barokah Makmur — PO-20260019', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0006', 5), ('BRG-0062', 2), ('BRG-0026', 6), ('BRG-0055', 1), ('BRG-0056', 1)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-01-17T09:21:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Kantin Sekolah Ceria — INV-20260026', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0055', 1), ('BRG-0016', 8), ('BRG-0065', 1), ('BRG-0091', 5)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-01-17T12:13:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Barokah — INV-20260033', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0042', 40), ('BRG-0035', 17), ('BRG-0024', 96), ('BRG-0052', 3), ('BRG-0011', 61), ('BRG-0070', 33)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-01-17T13:40:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Indo Niaga Pratama — PO-20260024', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0023', 79), ('BRG-0049', 42)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-01-18T09:18:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Maju Bersama — PO-20260022', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0015', 9), ('BRG-0057', 1), ('BRG-0079', 6), ('BRG-0014', 10), ('BRG-0028', 10)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-01-20T09:23:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Barokah — INV-20260035', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0012', 2), ('BRG-0073', 8), ('BRG-0078', 4), ('BRG-0051', 4)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-01-22T09:58:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Kopi Anak Muda — INV-20260025', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0006', 6), ('BRG-0028', 7), ('BRG-0071', 9)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-01-23T09:06:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Hj. Fatimah — INV-20260034', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0054', 13), ('BRG-0021', 118), ('BRG-0069', 50), ('BRG-0041', 47), ('BRG-0083', 52), ('BRG-0023', 117)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-01-24T08:42:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Sumber Makmur Abadi — PO-20260023', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0025', 104), ('BRG-0064', 36), ('BRG-0024', 28)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-01-24T13:45:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Berkah Jaya Abadi — PO-20260018', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0085', 13), ('BRG-0082', 17)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-01-25T08:25:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Indo Niaga Pratama — PO-20260020', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0037', 60), ('BRG-0031', 39), ('BRG-0032', 26), ('BRG-0009', 110), ('BRG-0017', 57), ('BRG-0007', 48)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-01-28T17:59:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Barokah Makmur — PO-20260021', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0042', 33), ('BRG-0083', 20), ('BRG-0064', 30)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-02-02T08:56:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Barokah Makmur — PO-20260027', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0081', 25), ('BRG-0005', 103), ('BRG-0014', 56), ('BRG-0025', 114), ('BRG-0010', 81)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-02-02T13:51:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Berkah Jaya Abadi — PO-20260025', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0066', 4)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-02-02T17:13:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Hj. Fatimah — INV-20260045', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0071', 97), ('BRG-0030', 51), ('BRG-0069', 26)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-02-03T12:40:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Indo Niaga Pratama — PO-20260026', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0022', 12)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-02-04T08:38:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Katering Bu Ratna — INV-20260044', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0083', 3), ('BRG-0054', 1)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-02-04T12:36:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Nasi Bu Yuni — INV-20260039', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0025', 12), ('BRG-0065', 2), ('BRG-0019', 11), ('BRG-0023', 11)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-02-06T12:44:00', @Tipe = 'O', @Keterangan = N'Penjualan ke RM Padang Sederhana — INV-20260047', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0028', 5), ('BRG-0036', 2), ('BRG-0070', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-02-07T08:09:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Bu Siti — INV-20260041', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0076', 5), ('BRG-0005', 7)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-02-09T11:32:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Fresh Ibu Dewi — INV-20260040', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0056', 2), ('BRG-0032', 5), ('BRG-0019', 4), ('BRG-0052', 1)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-02-12T10:08:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Barokah — INV-20260042', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0024', 28), ('BRG-0030', 34), ('BRG-0082', 26), ('BRG-0091', 117), ('BRG-0047', 39), ('BRG-0059', 15)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-02-15T09:37:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Berkah Jaya Abadi — PO-20260030', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0067', 2), ('BRG-0044', 1), ('BRG-0062', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-02-15T15:56:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Pak Haji Usman — INV-20260043', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0066', 3), ('BRG-0055', 1), ('BRG-0001', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-02-17T17:36:00', @Tipe = 'O', @Keterangan = N'Penjualan ke RM Padang Sederhana — INV-20260046', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0072', 12), ('BRG-0016', 12), ('BRG-0065', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-02-18T11:11:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Bu Siti — INV-20260036', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0002', 48), ('BRG-0005', 105), ('BRG-0044', 15), ('BRG-0057', 6), ('BRG-0045', 17)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-02-19T17:26:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Cahaya Timur Sejahtera — PO-20260029', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0034', 3)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-02-22T09:16:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Koperasi Karyawan Maju — INV-20260048', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0042', 4), ('BRG-0055', 2), ('BRG-0034', 3)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-02-22T16:37:00', @Tipe = 'O', @Keterangan = N'Penjualan ke RM Padang Sederhana — INV-20260049', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0077', 8), ('BRG-0006', 2), ('BRG-0005', 6), ('BRG-0088', 5), ('BRG-0007', 5)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-02-24T12:25:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Kantin Sekolah Ceria — INV-20260037', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0033', 50), ('BRG-0053', 55), ('BRG-0042', 39), ('BRG-0084', 25), ('BRG-0087', 55), ('BRG-0045', 48)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-02-24T13:20:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Tunas Bangsa Distribusi — PO-20260028', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0019', 10), ('BRG-0050', 5), ('BRG-0005', 5), ('BRG-0009', 9)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-02-27T08:07:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Katering Bu Ratna — INV-20260038', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0056', 2), ('BRG-0024', 6), ('BRG-0048', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-03-01T16:16:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Kopi Anak Muda — INV-20260060', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0079', 5), ('BRG-0074', 9), ('BRG-0014', 12)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-03-01T17:11:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Kopi Anak Muda — INV-20260057', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0068', 4), ('BRG-0025', 8), ('BRG-0056', 2), ('BRG-0033', 3), ('BRG-0088', 3)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-03-02T13:12:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Fresh Ibu Dewi — INV-20260056', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0057', 1), ('BRG-0015', 10), ('BRG-0038', 4), ('BRG-0060', 4)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-03-04T09:18:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Koperasi Karyawan Maju — INV-20260053', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0060', 29), ('BRG-0046', 30)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-03-05T15:33:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Sumber Makmur Abadi — PO-20260036', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0077', 9), ('BRG-0075', 7), ('BRG-0005', 3), ('BRG-0058', 4), ('BRG-0062', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-03-06T13:56:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Kantin Sekolah Ceria — INV-20260054', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0085', 54), ('BRG-0053', 35), ('BRG-0041', 58), ('BRG-0001', 118), ('BRG-0015', 38)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-03-06T14:59:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Sumber Makmur Abadi — PO-20260039', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0041', 2), ('BRG-0024', 2), ('BRG-0079', 4)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-03-07T11:16:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Pak Dedi — INV-20260058', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0073', 11), ('BRG-0078', 3), ('BRG-0052', 1), ('BRG-0088', 6), ('BRG-0018', 10)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-03-09T11:01:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Nasi Bu Yuni — INV-20260059', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0080', 15), ('BRG-0047', 50), ('BRG-0044', 58)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-03-10T14:00:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Sumber Makmur Abadi — PO-20260038', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0037', 14), ('BRG-0067', 33), ('BRG-0088', 26), ('BRG-0081', 25)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-03-11T15:27:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Cahaya Timur Sejahtera — PO-20260032', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0035', 19), ('BRG-0083', 39)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-03-12T08:30:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Indo Niaga Pratama — PO-20260033', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0041', 16), ('BRG-0089', 43), ('BRG-0074', 62), ('BRG-0042', 34)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-03-12T09:08:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Berkah Jaya Abadi — PO-20260037', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0015', 3), ('BRG-0057', 1), ('BRG-0072', 11), ('BRG-0008', 11), ('BRG-0055', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-03-14T13:03:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Katering Bu Ratna — INV-20260050', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0002', 9), ('BRG-0051', 5), ('BRG-0006', 12), ('BRG-0039', 6)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-03-15T17:21:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Pak Dedi — INV-20260055', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0004', 12), ('BRG-0043', 4), ('BRG-0070', 11), ('BRG-0073', 10), ('BRG-0089', 1)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-03-18T09:45:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Kelontong Hj. Aminah — INV-20260051', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0076', 40), ('BRG-0087', 39), ('BRG-0055', 6), ('BRG-0006', 53)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-03-19T15:04:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Sinar Abadi Jaya — PO-20260031', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0072', 107), ('BRG-0089', 56), ('BRG-0065', 4), ('BRG-0044', 54)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-03-20T17:39:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Berkah Jaya Abadi — PO-20260034', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0076', 10), ('BRG-0004', 9), ('BRG-0011', 11), ('BRG-0010', 10), ('BRG-0008', 5)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-03-24T15:14:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Kantin Sekolah Ceria — INV-20260052', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0049', 34), ('BRG-0005', 26)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-03-27T15:31:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Sinar Abadi Jaya — PO-20260035', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0022', 2), ('BRG-0035', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-04-03T10:37:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Nasi Bu Yuni — INV-20260072', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0088', 6), ('BRG-0012', 10), ('BRG-0014', 12), ('BRG-0007', 10), ('BRG-0056', 1)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-04-05T12:44:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Nasi Bu Yuni — INV-20260064', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0014', 5), ('BRG-0025', 5), ('BRG-0073', 7)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-04-07T10:51:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Koperasi Karyawan Maju — INV-20260074', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0015', 101), ('BRG-0083', 21)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-04-07T12:49:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Indo Niaga Pratama — PO-20260042', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0070', 7), ('BRG-0062', 1), ('BRG-0061', 2), ('BRG-0009', 10), ('BRG-0052', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-04-07T14:56:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Kopi Anak Muda — INV-20260071', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0012', 12), ('BRG-0001', 5), ('BRG-0023', 2), ('BRG-0029', 10)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-04-08T13:44:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Kopi Anak Muda — INV-20260069', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0054', 2), ('BRG-0076', 10), ('BRG-0074', 4)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-04-10T14:23:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Nasi Bu Yuni — INV-20260063', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0071', 25), ('BRG-0032', 14), ('BRG-0031', 22), ('BRG-0003', 97), ('BRG-0009', 45), ('BRG-0065', 8)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-04-10T15:08:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Tunas Bangsa Distribusi — PO-20260045', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0064', 4), ('BRG-0067', 6)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-04-11T15:43:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Katering Bu Ratna — INV-20260061', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0029', 10), ('BRG-0016', 9)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-04-13T14:09:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Hj. Fatimah — INV-20260062', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0074', 8)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-04-16T08:21:00', @Tipe = 'O', @Keterangan = N'Penjualan ke RM Padang Sederhana — INV-20260070', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0010', 65), ('BRG-0004', 28), ('BRG-0012', 27), ('BRG-0083', 49), ('BRG-0013', 65), ('BRG-0020', 46)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-04-16T08:57:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Cahaya Timur Sejahtera — PO-20260046', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0007', 7), ('BRG-0049', 4), ('BRG-0052', 2), ('BRG-0089', 1)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-04-17T11:41:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Pak Haji Usman — INV-20260065', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0041', 33), ('BRG-0026', 40), ('BRG-0011', 111)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-04-18T17:19:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Sinar Abadi Jaya — PO-20260043', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0010', 9), ('BRG-0066', 6)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-04-20T10:04:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Serba Ada Berkah — INV-20260066', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0034', 39), ('BRG-0043', 37), ('BRG-0010', 39), ('BRG-0025', 90), ('BRG-0091', 36)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-04-21T17:03:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Tunas Bangsa Distribusi — PO-20260041', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0012', 8), ('BRG-0030', 5)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-04-23T13:40:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Kelontong Hj. Aminah — INV-20260067', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0042', 28), ('BRG-0086', 32), ('BRG-0055', 13)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-04-25T16:46:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Indo Niaga Pratama — PO-20260040', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0057', 1), ('BRG-0018', 12), ('BRG-0075', 11)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-04-26T14:39:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Fresh Ibu Dewi — INV-20260073', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0035', 23), ('BRG-0037', 21), ('BRG-0011', 68)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-04-27T12:54:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Maju Bersama — PO-20260044', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0023', 4), ('BRG-0040', 1), ('BRG-0019', 6)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-04-27T13:06:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Fresh Ibu Dewi — INV-20260068', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0045', 5), ('BRG-0028', 6)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-05-02T15:01:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Pak Dedi — INV-20260084', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0013', 11), ('BRG-0064', 5)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-05-02T16:32:00', @Tipe = 'O', @Keterangan = N'Penjualan ke RM Padang Sederhana — INV-20260075', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0043', 41), ('BRG-0074', 37), ('BRG-0066', 59), ('BRG-0067', 49), ('BRG-0088', 18)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-05-03T17:21:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Sumber Makmur Abadi — PO-20260056', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0024', 11)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-05-04T08:10:00', @Tipe = 'O', @Keterangan = N'Penjualan ke RM Padang Sederhana — INV-20260080', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0042', 3), ('BRG-0029', 4)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-05-04T11:20:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Pak Dedi — INV-20260079', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0022', 32), ('BRG-0042', 57), ('BRG-0047', 15), ('BRG-0023', 25), ('BRG-0040', 60)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-05-04T17:39:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Sumber Makmur Abadi — PO-20260047', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0039', 58), ('BRG-0088', 43), ('BRG-0066', 33), ('BRG-0078', 52)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-05-06T09:38:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Indo Niaga Pratama — PO-20260052', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0080', 6), ('BRG-0007', 7), ('BRG-0055', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-05-06T11:06:00', @Tipe = 'O', @Keterangan = N'Penjualan ke RM Padang Sederhana — INV-20260087', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0055', 2), ('BRG-0087', 3), ('BRG-0033', 6), ('BRG-0015', 12), ('BRG-0067', 3)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-05-07T09:34:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Kopi Anak Muda — INV-20260086', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0039', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-05-08T09:51:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Kopi Anak Muda — INV-20260077', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0086', 23), ('BRG-0014', 39), ('BRG-0079', 37), ('BRG-0085', 54), ('BRG-0066', 19), ('BRG-0018', 80)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-05-10T09:31:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Tunas Bangsa Distribusi — PO-20260050', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0015', 25), ('BRG-0032', 56), ('BRG-0012', 26), ('BRG-0046', 38), ('BRG-0025', 67)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-05-11T13:38:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Sinar Abadi Jaya — PO-20260054', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0031', 1), ('BRG-0021', 6), ('BRG-0008', 11)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-05-13T12:30:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Kelontong Hj. Aminah — INV-20260083', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0081', 1), ('BRG-0028', 11), ('BRG-0013', 11), ('BRG-0037', 4)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-05-14T15:06:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Bu Siti — INV-20260076', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0057', 2), ('BRG-0023', 7), ('BRG-0004', 4)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-05-16T10:43:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Kantin Sekolah Ceria — INV-20260085', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0069', 3), ('BRG-0085', 1), ('BRG-0036', 6)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-05-16T17:58:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Kantin Sekolah Ceria — INV-20260081', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0044', 58), ('BRG-0025', 29), ('BRG-0053', 55), ('BRG-0038', 52)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-05-19T09:10:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Sumber Makmur Abadi — PO-20260048', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0082', 4)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-05-19T10:28:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Pak Dedi — INV-20260078', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0023', 39), ('BRG-0067', 54), ('BRG-0065', 12), ('BRG-0025', 90), ('BRG-0073', 24)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-05-20T15:45:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Barokah Makmur — PO-20260049', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0090', 58), ('BRG-0042', 53), ('BRG-0032', 50), ('BRG-0035', 20), ('BRG-0064', 29)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-05-22T11:31:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Tunas Bangsa Distribusi — PO-20260051', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0070', 6), ('BRG-0056', 1), ('BRG-0042', 4), ('BRG-0089', 4), ('BRG-0054', 1)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-05-24T14:00:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Fresh Ibu Dewi — INV-20260082', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0043', 20), ('BRG-0055', 6), ('BRG-0058', 53), ('BRG-0073', 95), ('BRG-0087', 35)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-05-27T16:25:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Tunas Bangsa Distribusi — PO-20260053', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0031', 15), ('BRG-0027', 25), ('BRG-0011', 51), ('BRG-0038', 51), ('BRG-0080', 48)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-05-28T14:41:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Berkah Jaya Abadi — PO-20260055', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0025', 93), ('BRG-0061', 24), ('BRG-0004', 24)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-06-01T13:57:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Indo Niaga Pratama — PO-20260060', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0002', 9), ('BRG-0008', 8), ('BRG-0003', 7), ('BRG-0076', 10)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-06-02T08:21:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Pak Haji Usman — INV-20260088', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0037', 60), ('BRG-0086', 48), ('BRG-0010', 53), ('BRG-0016', 44), ('BRG-0001', 28), ('BRG-0071', 117)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-06-02T12:49:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Cahaya Timur Sejahtera — PO-20260057', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0028', 74), ('BRG-0059', 59), ('BRG-0023', 62), ('BRG-0082', 23), ('BRG-0019', 25)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-06-03T08:09:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Sinar Abadi Jaya — PO-20260058', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0086', 4), ('BRG-0039', 5), ('BRG-0075', 10), ('BRG-0011', 7)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-06-04T17:13:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Katering Bu Ratna — INV-20260090', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0026', 4), ('BRG-0017', 12), ('BRG-0024', 7), ('BRG-0004', 3), ('BRG-0052', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-06-10T11:46:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Hj. Fatimah — INV-20260095', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0009', 9), ('BRG-0043', 2), ('BRG-0001', 12)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-06-14T13:15:00', @Tipe = 'O', @Keterangan = N'Penjualan ke RM Padang Sederhana — INV-20260096', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0045', 1), ('BRG-0060', 5), ('BRG-0082', 1)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-06-15T12:31:00', @Tipe = 'O', @Keterangan = N'Penjualan ke RM Padang Sederhana — INV-20260091', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0019', 10), ('BRG-0084', 3), ('BRG-0089', 6), ('BRG-0073', 7), ('BRG-0008', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-06-16T15:18:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Kantin Sekolah Ceria — INV-20260092', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0084', 28), ('BRG-0035', 34), ('BRG-0060', 14), ('BRG-0016', 31), ('BRG-0019', 73)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-06-17T14:27:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Sinar Abadi Jaya — PO-20260059', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0057', 2), ('BRG-0050', 1), ('BRG-0038', 4), ('BRG-0006', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-06-19T14:23:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Nasi Bu Yuni — INV-20260097', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0087', 2), ('BRG-0040', 3), ('BRG-0003', 9), ('BRG-0060', 6)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-06-21T16:38:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Serba Ada Berkah — INV-20260093', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0041', 48), ('BRG-0075', 112), ('BRG-0026', 104), ('BRG-0066', 41), ('BRG-0004', 27), ('BRG-0050', 24)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-06-23T17:52:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Sinar Abadi Jaya — PO-20260062', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0008', 99), ('BRG-0054', 4), ('BRG-0024', 67), ('BRG-0033', 55)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-06-24T15:12:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Indo Niaga Pratama — PO-20260061', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0013', 11), ('BRG-0073', 5), ('BRG-0079', 2), ('BRG-0033', 5), ('BRG-0076', 5)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-06-25T12:45:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Bu Siti — INV-20260094', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0083', 2), ('BRG-0054', 2), ('BRG-0004', 5), ('BRG-0072', 10)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-06-26T14:51:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Hj. Fatimah — INV-20260089', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0018', 4), ('BRG-0005', 9), ('BRG-0025', 10), ('BRG-0004', 3), ('BRG-0076', 4)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-07-01T09:12:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Barokah — INV-20260105', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0001', 41), ('BRG-0020', 24), ('BRG-0074', 24), ('BRG-0040', 13), ('BRG-0023', 87), ('BRG-0015', 100)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-07-06T13:22:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Indo Niaga Pratama — PO-20260069', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0073', 11), ('BRG-0003', 6), ('BRG-0085', 5), ('BRG-0061', 4)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-07-07T09:19:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Kantin Sekolah Ceria — INV-20260104', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0038', 6)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-07-08T14:29:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Bu Siti — INV-20260103', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0086', 17), ('BRG-0052', 11), ('BRG-0064', 21), ('BRG-0034', 50)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-07-09T17:00:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Berkah Jaya Abadi — PO-20260066', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0039', 1), ('BRG-0024', 10), ('BRG-0066', 6)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-07-09T17:46:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Katering Bu Ratna — INV-20260102', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0071', 30), ('BRG-0058', 52), ('BRG-0088', 42), ('BRG-0018', 100), ('BRG-0011', 48), ('BRG-0012', 119)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-07-12T15:18:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Sinar Abadi Jaya — PO-20260063', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0035', 49), ('BRG-0084', 14), ('BRG-0076', 119), ('BRG-0072', 97), ('BRG-0046', 16)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-07-15T17:54:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Cahaya Timur Sejahtera — PO-20260068', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0017', 12), ('BRG-0037', 4), ('BRG-0074', 11), ('BRG-0054', 2), ('BRG-0079', 3)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-07-17T11:40:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Nasi Bu Yuni — INV-20260107', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0068', 4)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-07-18T15:52:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Pak Dedi — INV-20260099', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0047', 41), ('BRG-0091', 45), ('BRG-0007', 104), ('BRG-0038', 52)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-07-19T12:26:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Barokah Makmur — PO-20260065', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0034', 20), ('BRG-0063', 44), ('BRG-0042', 16)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-07-19T13:04:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Cahaya Timur Sejahtera — PO-20260067', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0010', 5)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-07-20T17:30:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Pak Haji Usman — INV-20260106', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0052', 11), ('BRG-0091', 81), ('BRG-0085', 36)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-07-22T08:27:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Maju Bersama — PO-20260071', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0004', 11), ('BRG-0030', 2), ('BRG-0022', 12), ('BRG-0063', 4)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-07-22T12:17:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Hj. Fatimah — INV-20260098', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0002', 40), ('BRG-0019', 41)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-07-22T16:29:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Maju Bersama — PO-20260070', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0013', 64), ('BRG-0058', 37), ('BRG-0038', 26), ('BRG-0070', 27), ('BRG-0084', 16), ('BRG-0019', 99)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-07-24T09:28:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Maju Bersama — PO-20260064', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0027', 3), ('BRG-0008', 12), ('BRG-0026', 12)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-07-25T12:01:00', @Tipe = 'O', @Keterangan = N'Penjualan ke RM Padang Sederhana — INV-20260108', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0049', 5), ('BRG-0014', 5)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-07-26T12:46:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Kantin Sekolah Ceria — INV-20260100', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0012', 8), ('BRG-0077', 6), ('BRG-0053', 6)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-07-26T15:32:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Fresh Ibu Dewi — INV-20260101', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0075', 88), ('BRG-0031', 39), ('BRG-0089', 13), ('BRG-0047', 21)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-08-02T11:40:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Barokah Makmur — PO-20260078', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0063', 5), ('BRG-0006', 8), ('BRG-0057', 1)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-08-02T14:46:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Kopi Anak Muda — INV-20260117', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0052', 1), ('BRG-0015', 6), ('BRG-0061', 4)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-08-02T15:03:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Barokah — INV-20260109', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0065', 2), ('BRG-0075', 5), ('BRG-0071', 3)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-08-03T17:59:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Kopi Anak Muda — INV-20260113', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0075', 63), ('BRG-0066', 25), ('BRG-0083', 19), ('BRG-0077', 73), ('BRG-0063', 49), ('BRG-0074', 32)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-08-04T08:13:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Sumber Makmur Abadi — PO-20260076', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0014', 30), ('BRG-0072', 31), ('BRG-0042', 36), ('BRG-0089', 41)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-08-05T12:06:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Maju Bersama — PO-20260075', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0017', 12), ('BRG-0084', 2), ('BRG-0006', 11)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-08-06T14:27:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Pak Dedi — INV-20260116', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0084', 47), ('BRG-0069', 16), ('BRG-0058', 32)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-08-06T17:16:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Indo Niaga Pratama — PO-20260073', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0029', 5), ('BRG-0024', 3)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-08-07T12:11:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Fresh Ibu Dewi — INV-20260118', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0048', 44), ('BRG-0052', 13), ('BRG-0015', 30), ('BRG-0089', 13), ('BRG-0080', 34)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-08-08T11:04:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Barokah Makmur — PO-20260080', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0016', 9), ('BRG-0066', 1)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-08-09T13:08:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Nasi Bu Yuni — INV-20260112', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0091', 9)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-08-09T14:21:00', @Tipe = 'O', @Keterangan = N'Penjualan ke RM Padang Sederhana — INV-20260111', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0018', 41), ('BRG-0017', 39), ('BRG-0035', 59), ('BRG-0076', 118), ('BRG-0053', 21), ('BRG-0041', 26)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-08-11T14:58:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Sinar Abadi Jaya — PO-20260072', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0045', 21), ('BRG-0065', 13), ('BRG-0053', 32)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-08-14T10:12:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Maju Bersama — PO-20260079', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0032', 58), ('BRG-0006', 27), ('BRG-0021', 73), ('BRG-0004', 66), ('BRG-0033', 36)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-08-16T11:44:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Indo Niaga Pratama — PO-20260074', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0010', 118), ('BRG-0012', 63)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-08-19T13:52:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Tunas Bangsa Distribusi — PO-20260081', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0012', 4)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-08-23T16:33:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Kantin Sekolah Ceria — INV-20260110', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0010', 7), ('BRG-0046', 4)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-08-24T09:22:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Kelontong Hj. Aminah — INV-20260115', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0007', 5), ('BRG-0018', 7), ('BRG-0008', 6), ('BRG-0026', 2), ('BRG-0014', 6)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-08-26T09:31:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Fresh Ibu Dewi — INV-20260114', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0019', 26), ('BRG-0023', 113), ('BRG-0017', 66)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-08-27T16:07:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Sumber Makmur Abadi — PO-20260077', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0009', 5), ('BRG-0065', 1), ('BRG-0027', 11), ('BRG-0007', 8), ('BRG-0057', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-01T12:21:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Koperasi Karyawan Maju — INV-20260129', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0037', 5), ('BRG-0006', 4), ('BRG-0015', 3)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-05T10:52:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Bu Siti — INV-20260130', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0014', 12)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-05T12:19:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Kelontong Hj. Aminah — INV-20260120', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0032', 3), ('BRG-0055', 1), ('BRG-0082', 1)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-07T08:37:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Fresh Ibu Dewi — INV-20260122', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0025', 33), ('BRG-0078', 51), ('BRG-0041', 45), ('BRG-0046', 57)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-08T17:28:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Berkah Jaya Abadi — PO-20260091', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0018', 115), ('BRG-0004', 79)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-10T16:08:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Barokah Makmur — PO-20260083', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0002', 8), ('BRG-0046', 5), ('BRG-0014', 5), ('BRG-0063', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-10T16:22:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Koperasi Karyawan Maju — INV-20260119', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0071', 59), ('BRG-0047', 53)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-12T09:38:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Sinar Abadi Jaya — PO-20260090', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0008', 74), ('BRG-0078', 34), ('BRG-0091', 108), ('BRG-0023', 114), ('BRG-0083', 45), ('BRG-0087', 23)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-13T09:19:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Maju Bersama — PO-20260089', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0080', 27), ('BRG-0073', 92), ('BRG-0033', 35), ('BRG-0017', 95), ('BRG-0004', 86), ('BRG-0070', 48)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-13T14:30:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Tunas Bangsa Distribusi — PO-20260082', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0031', 1), ('BRG-0009', 12), ('BRG-0021', 2), ('BRG-0027', 3)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-13T14:43:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Pak Haji Usman — INV-20260126', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0073', 5), ('BRG-0057', 1), ('BRG-0056', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-15T11:49:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Fresh Ibu Dewi — INV-20260121', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0032', 6), ('BRG-0016', 9), ('BRG-0056', 2), ('BRG-0082', 6), ('BRG-0006', 9)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-17T11:02:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Serba Ada Berkah — INV-20260124', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0076', 9), ('BRG-0065', 1), ('BRG-0073', 12)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-17T17:45:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Nasi Bu Yuni — INV-20260133', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0048', 2), ('BRG-0009', 6), ('BRG-0025', 5), ('BRG-0041', 3)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-18T14:30:00', @Tipe = 'O', @Keterangan = N'Penjualan ke RM Padang Sederhana — INV-20260125', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0012', 8), ('BRG-0061', 6), ('BRG-0008', 12), ('BRG-0064', 1), ('BRG-0054', 1)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-19T14:09:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Bu Siti — INV-20260123', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0054', 1), ('BRG-0025', 12), ('BRG-0004', 9), ('BRG-0058', 1)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-21T10:15:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Serba Ada Berkah — INV-20260128', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0065', 4), ('BRG-0017', 103), ('BRG-0043', 52), ('BRG-0040', 34), ('BRG-0058', 54), ('BRG-0004', 99)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-22T14:33:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Berkah Jaya Abadi — PO-20260085', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0021', 65), ('BRG-0012', 109), ('BRG-0065', 14), ('BRG-0020', 13), ('BRG-0010', 53), ('BRG-0073', 95)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-22T16:04:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Sumber Makmur Abadi — PO-20260084', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0070', 102), ('BRG-0062', 3), ('BRG-0003', 37), ('BRG-0086', 44)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-23T08:24:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Tunas Bangsa Distribusi — PO-20260088', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0016', 30), ('BRG-0070', 32), ('BRG-0023', 39), ('BRG-0022', 24), ('BRG-0069', 17), ('BRG-0033', 22)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-25T16:09:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Barokah Makmur — PO-20260086', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0077', 8), ('BRG-0072', 10), ('BRG-0021', 11), ('BRG-0091', 6)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-26T15:52:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Kopi Anak Muda — INV-20260131', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0006', 3), ('BRG-0007', 7), ('BRG-0044', 6), ('BRG-0004', 12)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-26T17:55:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Pak Dedi — INV-20260127', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0012', 9), ('BRG-0054', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-27T10:37:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Pak Dedi — INV-20260132', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0041', 15), ('BRG-0081', 23)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-09-27T14:00:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Sumber Makmur Abadi — PO-20260087', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0083', 46), ('BRG-0001', 91), ('BRG-0027', 45), ('BRG-0002', 84), ('BRG-0040', 37), ('BRG-0056', 11)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-10-01T14:13:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Barokah Makmur — PO-20260099', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0084', 3), ('BRG-0038', 6), ('BRG-0016', 3)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-10-03T14:02:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Hj. Fatimah — INV-20260139', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0074', 6), ('BRG-0091', 12), ('BRG-0017', 11), ('BRG-0007', 7)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-10-03T16:37:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Fresh Ibu Dewi — INV-20260134', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0024', 8)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-10-05T14:56:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Hj. Fatimah — INV-20260140', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0056', 15), ('BRG-0052', 14), ('BRG-0015', 81), ('BRG-0072', 115), ('BRG-0048', 51), ('BRG-0057', 7)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-10-07T14:04:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Berkah Jaya Abadi — PO-20260098', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0009', 5), ('BRG-0075', 12), ('BRG-0010', 12), ('BRG-0013', 10), ('BRG-0019', 4)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-10-07T15:13:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Kantin Sekolah Ceria — INV-20260137', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0016', 52), ('BRG-0021', 117)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-10-11T12:29:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Barokah Makmur — PO-20260092', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0055', 2), ('BRG-0056', 1)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-10-12T08:14:00', @Tipe = 'O', @Keterangan = N'Penjualan ke RM Padang Sederhana — INV-20260143', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0076', 7), ('BRG-0065', 1)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-10-12T09:28:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Koperasi Karyawan Maju — INV-20260144', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0055', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-10-12T15:19:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Koperasi Karyawan Maju — INV-20260136', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0075', 9), ('BRG-0054', 2), ('BRG-0071', 7), ('BRG-0024', 10)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-10-16T12:16:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Koperasi Karyawan Maju — INV-20260142', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0059', 38), ('BRG-0043', 20), ('BRG-0077', 97), ('BRG-0053', 13)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-10-17T11:50:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Barokah Makmur — PO-20260100', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0071', 12), ('BRG-0057', 1), ('BRG-0091', 6), ('BRG-0009', 11)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-10-18T10:00:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Kopi Anak Muda — INV-20260135', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0082', 53), ('BRG-0033', 21)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-10-19T17:17:00', @Tipe = 'I', @Keterangan = N'Pembelian dari CV Sinar Abadi Jaya — PO-20260094', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0074', 2), ('BRG-0010', 5), ('BRG-0011', 10)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-10-20T09:33:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Toko Pak Haji Usman — INV-20260141', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0023', 78), ('BRG-0067', 51), ('BRG-0057', 3), ('BRG-0024', 108), ('BRG-0080', 23)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-10-21T09:11:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Maju Bersama — PO-20260096', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0009', 9), ('BRG-0078', 3)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-10-21T11:12:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Katering Bu Ratna — INV-20260145', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0066', 43), ('BRG-0065', 14)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-10-21T14:30:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Cahaya Timur Sejahtera — PO-20260093', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0002', 102), ('BRG-0089', 15), ('BRG-0043', 60), ('BRG-0079', 39), ('BRG-0086', 58), ('BRG-0031', 49)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-10-23T09:00:00', @Tipe = 'I', @Keterangan = N'Pembelian dari UD Barokah Makmur — PO-20260097', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0074', 9), ('BRG-0022', 8), ('BRG-0078', 1), ('BRG-0090', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-10-24T14:55:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Bu Siti — INV-20260138', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0048', 2)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-10-25T14:49:00', @Tipe = 'O', @Keterangan = N'Penjualan ke Warung Bu Siti — INV-20260146', @Details = @D;
    DELETE FROM @D;

    INSERT INTO @D (BarangId, Qty)
    SELECT b.BarangId, v.Qty
    FROM (VALUES ('BRG-0055', 5), ('BRG-0019', 25), ('BRG-0078', 51), ('BRG-0061', 15), ('BRG-0048', 15), ('BRG-0038', 57)) AS v(Kode, Qty)
    JOIN dbo.Barang AS b ON b.Kode = v.Kode;
    EXEC dbo.sp_SimpanTransaksi @Tanggal = '2026-10-28T14:39:00', @Tipe = 'I', @Keterangan = N'Pembelian dari PT Indo Niaga Pratama — PO-20260095', @Details = @D;
    DELETE FROM @D;

    PRINT 'Seed selesai: 91 barang, 248 transaksi.';
END
ELSE
    PRINT 'Barang sudah terisi — seed dilewati.';
GO
