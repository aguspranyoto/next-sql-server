import { NextResponse } from "next/server";
import sql from "mssql";
import { getAppPool } from "@/lib/db";


// GET /api/laporan/stok-minim?batas= — agregasi + HAVING
export async function GET(req: Request) {
  const { searchParams } = new URL(req.url);
  const batas = Math.max(0, Number(searchParams.get("batas")) || 10);
  const pool = await getAppPool();
  const rs = await pool.request().input("batas", sql.Int, batas).query(`
    SELECT b.Kode, b.Nama, b.Satuan, b.Stok,
           ISNULL(SUM(CASE WHEN t.Tipe = 'O' AND t.Tanggal >= DATEADD(DAY, -30, SYSDATETIME()) THEN d.Qty ELSE 0 END), 0) AS Keluar30Hari
    FROM dbo.Barang AS b
    LEFT JOIN dbo.TransaksiDetail AS d ON d.BarangId = b.BarangId
    LEFT JOIN dbo.Transaksi AS t ON t.TransaksiId = d.TransaksiId
    GROUP BY b.BarangId, b.Kode, b.Nama, b.Satuan, b.Stok
    HAVING b.Stok <= @batas
    ORDER BY b.Stok ASC, b.Kode;
  `);
  return NextResponse.json({ data: rs.recordset, batas });
}
