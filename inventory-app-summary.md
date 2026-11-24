# Web Inventory — Next.js + SQL Server

Ringkasan blueprint aplikasi inventory sederhana dengan Next.js App Router dan SQL Server, termasuk fitur **live test SQL query**.

---

## Daftar Isi

1. [Arsitektur](#1-arsitektur)
2. [Stack](#2-stack)
3. [Database](#3-database)
4. [Route Handler (API)](#4-route-handler-api)
5. [Dua Pool Koneksi](#5-dua-pool-koneksi)
6. [Halaman](#6-halaman)
7. [Fitur Live Test SQL Query](#7-fitur-live-test-sql-query)
8. [Struktur File](#8-struktur-file)
9. [Environment Variables](#9-environment-variables)
10. [Deploy](#10-deploy)
11. [Urutan Build](#11-urutan-build)
12. [Checklist Bukti Portfolio](#12-checklist-bukti-portfolio)
13. [Catatan Penting](#13-catatan-penting)

---

## 1. Arsitektur

```
Browser ──Tailscale──► Next.js :3000 ──► SQL Server (Docker, 127.0.0.1:1433)
                       ├─ Pages (RSC + client)
                       └─ /api/* route handler (Node runtime)
```

Satu proses, satu build, tanpa CORS, tanpa backend terpisah.

Keunggulan dibanding Vue + Express: tidak ada dua pipeline build, tidak ada dua `package.json`, tidak ada konfigurasi CORS.

---

## 2. Stack

| Layer | Pilihan |
|---|---|
| Framework | Next.js App Router + TypeScript |
| UI | Phoenix UI / MUI (bebas, yang penting ringkas) |
| DB | SQL Server 2022 Express via Docker |
| Driver | `mssql` (runtime **nodejs**, bukan Edge) |
| Akses | Tailscale `serve`, tanpa port publik |

---

## 3. Database

Skema terdiri dari 3 tabel, 1 view, 1 table type, dan 1 stored procedure.

```sql
Barang(BarangId, Kode UNIQUE, Nama, Satuan, Stok, Harga)
Transaksi(TransaksiId, Tanggal, Tipe 'I'/'O', Keterangan)
TransaksiDetail(DetailId, TransaksiId FK, BarangId FK, Qty)

vw_StokBarang
TYPE TransaksiDetailType
PROC sp_SimpanTransaksi   -- BEGIN TRAN + TRY/CATCH + validasi stok
```

**Aturan inti:** kolom `Stok` hanya boleh berubah lewat `sp_SimpanTransaksi`. Halaman Barang hanya mengelola data master (nama, satuan, harga), tidak pernah menulis `Stok` secara langsung.

Alasan: konsistensi data terjaga, dan menjadi bahan cerita teknis yang kuat di README.

---

## 4. Route Handler (API)

| Endpoint | SQL yang dilatih | Pool |
|---|---|---|
| `GET /api/barang` | `WHERE` + `LIKE` + `OFFSET/FETCH` + `COUNT(*) OVER()` | read-write |
| `POST /api/barang` | `INSERT` dengan parameter binding | read-write |
| `POST /api/transaksi` | `EXEC sp_SimpanTransaksi` | read-write |
| `GET /api/transaksi` | `JOIN` header-detail | read-write |
| `GET /api/laporan/mutasi` | `JOIN` 3 tabel + `GROUP BY` + `SUM() OVER` | read-write |
| `GET /api/laporan/stok-minim` | agregasi + `HAVING` | read-write |
| `POST /api/playground` | `SELECT` bebas | **read-only** |

Total 7 endpoint. Tidak perlu lebih.

Semua query wajib memakai parameter binding (`.input()`), tidak boleh string concatenation.

---

## 5. Dua Pool Koneksi

| Pool | Login | Dipakai oleh |
|---|---|---|
| app | `app_user` (read-write terbatas) | semua endpoint inventory |
| viewer | `web_viewer` (`db_datareader` + `DENY EXECUTE`) | hanya `/api/playground` |

Pool aplikasi tidak pernah dipakai oleh halaman playground.

### Gotcha khas Next.js dev mode

Hot reload membuat modul di-reload dan berpotensi membuat pool baru setiap kali. Simpan di `globalThis` supaya tidak bocor:

```ts
const g = globalThis as unknown as { _pool?: Promise<sql.ConnectionPool> };
export const pool = g._pool ??= new sql.ConnectionPool(cfg).connect();
```

---

## 6. Halaman

| Route | Isi | Sumber data |
|---|---|---|
| `/barang` | tabel + filter + paging + form tambah/edit | `GET/POST /api/barang` |
| `/transaksi` | form multi-baris masuk/keluar | `POST /api/transaksi` |
| `/riwayat` | daftar transaksi + detail | `GET /api/transaksi` |
| `/laporan` | mutasi per barang + stok minim | `/api/laporan/*` |
| `/playground` | editor SQL + tabel hasil dinamis | `POST /api/playground` |

Empat halaman pertama adalah web inventory. Halaman kelima adalah fitur live test query.

---

## 7. Fitur Live Test SQL Query

### Komponen

- `<textarea>` untuk menulis query
- Tombol **Run** (shortcut `Ctrl+Enter`)
- Tabel hasil dengan kolom dibangun dinamis dari `Object.keys(rows[0])`
- Area error yang menampilkan pesan dari SQL Server

React otomatis melakukan escaping, jadi isi tabel aman dari XSS.

### Tiga pengaman berlapis

| Lapis | Fungsi | Sifat |
|---|---|---|
| **Login read-only** | `web_viewer` hanya bisa `SELECT` | Pertahanan sebenarnya |
| **Filter query** | Hanya `SELECT`/`WITH`, keyword berbahaya ditolak | Kosmetik / UX |
| **Batas eksekusi** | `SET ROWCOUNT 200` + `requestTimeout: 5000` | Anti-DoS |

Keyword yang ditolak: `INSERT`, `UPDATE`, `DELETE`, `DROP`, `ALTER`, `CREATE`, `TRUNCATE`, `MERGE`, `EXEC`, `EXECUTE`, `GRANT`, `REVOKE`, `DENY`, `BACKUP`, `RESTORE`, `DBCC`, `SHUTDOWN`, `OPENROWSET`, `OPENDATASOURCE`, `BULK`, dan pola `xp_*`.

### Wajib di route handler

```ts
export const runtime = "nodejs";   // driver mssql butuh net/tls
```

### Larangan

Jangan pakai `output: 'export'` di `next.config.ts`. Static export menghapus seluruh route handler, dan fitur playground ikut hilang.

---

## 8. Struktur File

```
src/
├─ app/
│  ├─ (inventory)/
│  │  ├─ barang/page.tsx
│  │  ├─ transaksi/page.tsx
│  │  ├─ riwayat/page.tsx
│  │  ├─ laporan/page.tsx
│  │  └─ playground/page.tsx
│  └─ api/
│     ├─ barang/route.ts
│     ├─ transaksi/route.ts
│     ├─ laporan/mutasi/route.ts
│     ├─ laporan/stok-minim/route.ts
│     └─ playground/route.ts
├─ lib/
│  ├─ db.ts          # pool read-write (singleton)
│  ├─ db-viewer.ts   # pool read-only (singleton)
│  └─ sql-guard.ts   # filter SELECT-only

db/
├─ 01-schema.sql
├─ 02-seed.sql
├─ 03-procedures.sql
└─ 04-viewer-login.sql
```

---

## 9. Environment Variables

```env
MSSQL_SERVER=127.0.0.1
MSSQL_USER=app_user
MSSQL_PASSWORD=...
MSSQL_VIEWER_USER=web_viewer
MSSQL_VIEWER_PASSWORD=...
MSSQL_SA_PASSWORD=...
```

Catatan: `MSSQL_SA_PASSWORD` hanya dipakai saat setup dan backup, tidak pernah dipakai aplikasi.

---

## 10. Deploy

1. `docker compose up -d`
2. Jalankan `db/01-schema.sql` → `02-seed.sql` → `03-procedures.sql` → `04-viewer-login.sql` berurutan
3. `npm run build`
4. `pm2 start "npm run start" --name inventory`
5. `tailscale serve --bg 3000`
6. Pasang cron backup harian, lalu tes restore sekali

### Docker SQL Server

```yaml
services:
  mssql:
    image: mcr.microsoft.com/mssql/server:2022-latest
    environment:
      ACCEPT_EULA: "Y"
      MSSQL_SA_PASSWORD: "${MSSQL_SA_PASSWORD}"
      MSSQL_PID: "Express"
    ports:
      - "127.0.0.1:1433:1433"
    volumes:
      - mssql-data:/var/opt/mssql
    restart: unless-stopped
```

Port 1433 **hanya** di-bind ke `127.0.0.1`, tidak pernah ke `0.0.0.0`. Akses dari luar hanya lewat Tailscale atau SSH tunnel.

Gunakan `tailscale serve`, **bukan** `tailscale funnel` — funnel membuka ke internet publik.

---

## 11. Urutan Build

1. Docker + `db/*.sql` → tes query di Azure Data Studio
2. `lib/db.ts` + `GET /api/barang` → tes pakai curl
3. Halaman `/barang`
4. `sp_SimpanTransaksi` + halaman `/transaksi`
5. Halaman `/laporan` (paling banyak SQL)
6. Halaman `/playground` (paling akhir, paling cepat selesai)
7. Deploy + Tailscale
8. README + screenshot

---

## 12. Checklist Bukti Portfolio

- [ ] `db/*.sql` bisa dijalankan berurutan dari DB kosong tanpa error
- [ ] Kolom `Stok` hanya berubah lewat satu stored procedure
- [ ] Minimal 1 index + screenshot execution plan sebelum/sesudah
- [ ] Playground memakai `web_viewer`, **bukan** `sa` atau `app_user`
- [ ] File `.sql` ada di repo, bukan cuma screenshot
- [ ] README berisi cara run, screenshot 5 halaman, dan contoh query

---

## 13. Catatan Penting

- **Jangan pakai `sa` di aplikasi.** Buat `app_user` dengan permission terbatas. `sa` hanya untuk setup dan backup.
- **Playground jangan memakai pool aplikasi.** Ini satu-satunya kesalahan yang benar-benar berbahaya.
- **`OFFSET/FETCH` wajib disertai `ORDER BY`.** Tanpa itu SQL Server akan error.
- **Semua query pakai `.input()`.** Jangan pernah menyambung string dari input user.
- **Satu proses, satu titik gagal.** Di Next.js, query berat di playground bisa memperlambat aplikasi utama. Mitigasinya adalah `ROWCOUNT` dan timeout, bukan pemisahan proses.
- **Jangan campur dengan kode aplikasi lain.** Kalau inventory ditaruh di repo yang sudah ada, gunakan route group terpisah.

---

*Dokumen ini adalah ringkasan blueprint. Tidak ada kode aplikasi yang dibuat.*
