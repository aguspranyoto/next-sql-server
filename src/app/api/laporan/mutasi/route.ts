import { NextResponse } from "next/server";
import sql from "mssql";
import { getAppPool } from "@/lib/db";


// GET /api/laporan/mutasi?from=&to= — JOIN 3 tabel + GROUP BY + SUM() OVER
export async function GET(req: Request) {
  const { searchParams } = new URL(req.url);
  const from = searchParams.get("from");
  const to = searchParams.get("to");
  const pool = await getAppPool();
  const rs = await pool
    .request()
    .input("from", sql.DateTime2(0), from ? new Date(`${from}T00:00:00`) : new Date(0))
    .input("to", sql.DateTime2(0), to ? new Date(`${to}T23:59:59`) : new Date("9999-12-31T23:59:59")).query(`
      SELECT b.Kode, b.Nama, b.Satuan,
             SUM(CASE WHEN t.Tipe = 'I' THEN d.Qty ELSE 0 END) AS TotalMasuk,
             SUM(CASE WHEN t.Tipe = 'O' THEN d.Qty ELSE 0 END) AS TotalKeluar,
             b.Stok AS StokAkhir,
             SUM(SUM(CASE WHEN t.Tipe = 'I' THEN d.Qty ELSE -d.Qty END)) OVER () AS MutasiBersih
      FROM dbo.Barang AS b
      LEFT JOIN dbo.TransaksiDetail AS d ON d.BarangId = b.BarangId
      LEFT JOIN dbo.Transaksi AS t
        ON t.TransaksiId = d.TransaksiId AND t.Tanggal BETWEEN @from AND @to
      GROUP BY b.BarangId, b.Kode, b.Nama, b.Satuan, b.Stok
      ORDER BY b.Kode;
    `);
  return NextResponse.json({ data: rs.recordset });
}
