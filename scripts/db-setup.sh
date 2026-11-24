#!/bin/bash
# Setup database dari nol: buat DB, jalankan 01 -> 03 -> 02 -> 04 berurutan.
# Urutan sengaja: procedure (03) dipasang SEBELUM seed (02) supaya seluruh
# data seed masuk lewat sp_SimpanTransaksi — bukti aturan "Stok hanya via procedure".
#   npm run db:setup
set -euo pipefail
cd "$(dirname "$0")/.."

if [ ! -f .env ]; then
  echo "ERROR: .env tidak ditemukan. Salin dari .env.example dan isi password." >&2
  exit 1
fi
set -a; . ./.env; set +a

SA="${MSSQL_SA_PASSWORD:?isi MSSQL_SA_PASSWORD di .env}"
DB="${MSSQL_DATABASE:-InventoryDB}"
SQLCMD=(docker compose exec -T mssql /opt/mssql-tools18/bin/sqlcmd -S localhost -U sa -P "$SA" -C -b)

echo "==> Menunggu SQL Server siap..."
for i in $(seq 1 30); do
  if "${SQLCMD[@]}" -Q "SELECT 1" -o /dev/null 2>/dev/null; then break; fi
  if [ "$i" -eq 30 ]; then echo "ERROR: SQL Server tidak merespons." >&2; exit 1; fi
  sleep 2
done

echo "==> Membuat database $DB (bila belum ada)..."
"${SQLCMD[@]}" -Q "IF DB_ID('$DB') IS NULL CREATE DATABASE $DB;"

run() { echo "==> $1"; "${SQLCMD[@]}" -d "$DB" "${@:2}"; }

# sqlcmd berjalan DI DALAM container: salin file .sql ke sana dulu via docker cp,
# karena path host tidak terlihat dari dalam container.
CID="$(docker compose ps -q mssql)"
for f in db/01-schema.sql db/03-procedures.sql db/02-seed.sql; do
  docker cp "$f" "$CID:/tmp/$(basename "$f")"
done

run "01-schema.sql"      -i /tmp/01-schema.sql
run "03-procedures.sql"  -i /tmp/03-procedures.sql

if [ ! -f db/02-seed.sql ]; then
  echo "==> Membuat db/02-seed.sql dari generator..."
  node scripts/gen-seed.mjs
  docker cp db/02-seed.sql "$CID:/tmp/02-seed.sql"
fi
run "02-seed.sql"        -i /tmp/02-seed.sql

docker cp db/04-viewer-login.sql "$CID:/tmp/04-viewer-login.sql"
run "04-viewer-login.sql" -i /tmp/04-viewer-login.sql \
  -v "APP_PASS=$MSSQL_PASSWORD" "VIEWER_PASS=$MSSQL_VIEWER_PASSWORD"

echo "==> Verifikasi..."
"${SQLCMD[@]}" -d "$DB" -Q "SELECT COUNT(*) AS Barang, (SELECT COUNT(*) FROM dbo.Transaksi) AS Transaksi FROM dbo.Barang;"
echo "OK. Database siap."
