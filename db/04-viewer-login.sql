-- 04-viewer-login.sql
-- Dua login dengan hak minimal (prinsip least privilege).
-- Dijalankan TERAKHIR via db-setup.sh dengan sqlcmd scripting variables:
--   sqlcmd ... -v APP_PASS="..." VIEWER_PASS="..." -i db/04-viewer-login.sql
--
--   app_user   : dipakai SEMUA endpoint inventory (pool read-write).
--                Boleh SELECT/INSERT/UPDATE tabel + EXECUTE sp_SimpanTransaksi,
--                tapi DENY UPDATE kolom Barang(Stok) — penegakan aturan di level DB.
--   web_viewer : dipakai HANYA /api/playground (pool read-only).
--                db_datareader + DENY EXECUTE. Tidak bisa INSERT/UPDATE/DELETE,
--                tidak bisa menjalankan stored procedure.

USE master;
GO

IF NOT EXISTS (SELECT 1 FROM sys.sql_logins WHERE name = 'app_user')
    CREATE LOGIN app_user WITH PASSWORD = '$(APP_PASS)', CHECK_POLICY = ON;
GO

IF NOT EXISTS (SELECT 1 FROM sys.sql_logins WHERE name = 'web_viewer')
    CREATE LOGIN web_viewer WITH PASSWORD = '$(VIEWER_PASS)', CHECK_POLICY = ON;
GO

USE InventoryDB;
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'app_user')
    CREATE USER app_user FOR LOGIN app_user;
GO

IF NOT EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'web_viewer')
    CREATE USER web_viewer FOR LOGIN web_viewer;
GO

-- ---- app_user: read-write terbatas ----
GRANT SELECT, INSERT, UPDATE ON dbo.Barang TO app_user;
GRANT SELECT, INSERT       ON dbo.Transaksi TO app_user;
GRANT SELECT, INSERT       ON dbo.TransaksiDetail TO app_user;
GRANT SELECT               ON dbo.vw_StokBarang TO app_user;
GRANT EXECUTE ON OBJECT::dbo.sp_SimpanTransaksi TO app_user;
GRANT EXECUTE ON TYPE::dbo.TransaksiDetailType TO app_user;

-- Penegakan aturan "Stok hanya via procedure" di level database:
-- aplikasi TIDAK BISA meng-update kolom Stok secara langsung,
-- tapi procedure (milik dbo, ownership chaining) tetap bisa.
DENY UPDATE ON OBJECT::dbo.Barang (Stok) TO app_user;
GO

-- ---- web_viewer: read-only untuk playground ----
ALTER ROLE db_datareader ADD MEMBER web_viewer;
DENY EXECUTE TO web_viewer;
GO
