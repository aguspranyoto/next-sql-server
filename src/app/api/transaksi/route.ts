import { NextResponse } from "next/server";
import sql from "mssql";
import { getAppPool } from "@/lib/db";


const DetailType = "dbo.TransaksiDetailType";

// GET /api/transaksi?limit= — header + detail, terbaru dulu
export async function GET(req: Request) {
  const { searchParams } = new URL(req.url);
  const limit = Math.min(200, Math.max(1, Number(searchParams.get("limit")) || 50));
  const pool = await getAppPool();
  const rs = await pool.request().input("limit", sql.Int, limit).query(`
    SELECT TOP (@limit)
        t.TransaksiId, t.Tanggal, t.Tipe, t.Keterangan,
        d.DetailId, d.BarangId, d.Qty,
        b.Kode, b.Nama, b.Satuan
    FROM dbo.Transaksi AS t
    JOIN dbo.TransaksiDetail AS d ON d.TransaksiId = t.TransaksiId
    JOIN dbo.Barang AS b          ON b.BarangId = d.BarangId
    ORDER BY t.Tanggal DESC, t.TransaksiId DESC;
  `);

  const map = new Map<number, { TransaksiId: number; Tanggal: string; Tipe: string; Keterangan: string | null; items: unknown[] }>();
  for (const r of rs.recordset as Array<Record<string, unknown>>) {
    const id = r.TransaksiId as number;
    let h = map.get(id);
    if (!h) {
      h = { TransaksiId: id, Tanggal: r.Tanggal as string, Tipe: r.Tipe as string, Keterangan: (r.Keterangan as string) ?? null, items: [] };
      map.set(id, h);
    }
    h.items.push({ DetailId: r.DetailId, BarangId: r.BarangId, Qty: r.Qty, Kode: r.Kode, Nama: r.Nama, Satuan: r.Satuan });
  }
  return NextResponse.json({ data: [...map.values()] });
}

// POST /api/transaksi — catat mutasi lewat stored procedure (TVP)
export async function POST(req: Request) {
  const body = await req.json();
  const { tipe, keterangan = null, tanggal = null, items } = body ?? {};
  if (tipe !== "I" && tipe !== "O") {
    return NextResponse.json({ error: "tipe harus 'I' (masuk) atau 'O' (keluar)." }, { status: 400 });
  }
  if (!Array.isArray(items) || items.length === 0) {
    return NextResponse.json({ error: "items tidak boleh kosong." }, { status: 400 });
  }

  const tvp = new sql.Table(DetailType);
  tvp.columns.add("BarangId", sql.Int, { nullable: false });
  tvp.columns.add("Qty", sql.Int, { nullable: false });
  for (const it of items) {
    const barangId = Number(it?.barangId);
    const qty = Number(it?.qty);
    if (!Number.isInteger(barangId) || !Number.isInteger(qty) || qty <= 0) {
      return NextResponse.json({ error: "Setiap baris butuh barangId dan qty bilangan bulat > 0." }, { status: 400 });
    }
    tvp.rows.add(barangId, qty);
  }

  const pool = await getAppPool();
  try {
    const rs = await pool
      .request()
      .input("Tanggal", sql.DateTime2(0), tanggal ? new Date(tanggal) : null)
      .input("Tipe", sql.Char(1), tipe)
      .input("Keterangan", sql.NVarChar(255), keterangan)
      .input("Details", tvp)
      .execute("dbo.sp_SimpanTransaksi");
    return NextResponse.json({ ok: true, transaksiId: (rs.recordset[0] as { TransaksiId: number }).TransaksiId }, { status: 201 });
  } catch (e) {
    const msg = e instanceof Error ? e.message : "Gagal menyimpan transaksi.";
    const status = /Stok tidak mencukupi|Qty|Tipe|kosong|tidak dikenal/.test(msg) ? 422 : 500;
    return NextResponse.json({ error: msg }, { status });
  }
}
