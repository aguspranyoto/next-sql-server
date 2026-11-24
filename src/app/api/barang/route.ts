import { NextResponse } from "next/server";
import sql from "mssql";
import { getAppPool } from "@/lib/db";


// GET /api/barang?q=&page=&pageSize= — WHERE + LIKE + OFFSET/FETCH + COUNT(*) OVER()
export async function GET(req: Request) {
  const { searchParams } = new URL(req.url);
  const q = (searchParams.get("q") ?? "").trim();
  const page = Math.max(1, Number(searchParams.get("page")) || 1);
  const pageSize = Math.min(100, Math.max(1, Number(searchParams.get("pageSize")) || 20));
  const offset = (page - 1) * pageSize;

  const pool = await getAppPool();
  const rs = await pool
    .request()
    .input("q", sql.NVarChar(200), `%${q}%`)
    .input("offset", sql.Int, offset)
    .input("pageSize", sql.Int, pageSize).query(`
      SELECT BarangId, Kode, Nama, Satuan, Stok, Harga,
             COUNT(*) OVER () AS TotalRows,
             Stok * Harga AS NilaiPersediaan
      FROM dbo.Barang
      WHERE (@q = '%%' OR Nama LIKE @q OR Kode LIKE @q)
      ORDER BY Kode
      OFFSET @offset ROWS FETCH NEXT @pageSize ROWS ONLY;
    `);

  const rows = rs.recordset as Array<Record<string, unknown> & { TotalRows: number }>;
  return NextResponse.json({
    data: rows.map(({ TotalRows: _t, ...r }) => r),
    total: rows[0]?.TotalRows ?? 0,
    page,
    pageSize,
  });
}

// POST /api/barang — INSERT master (tidak menyentuh Stok) + PUT update master
export async function POST(req: Request) {
  const body = await req.json();
  const { kode, nama, satuan = "Pcs", harga = 0 } = body ?? {};
  if (!kode || !nama) {
    return NextResponse.json({ error: "kode dan nama wajib diisi." }, { status: 400 });
  }
  const pool = await getAppPool();
  try {
    await pool
      .request()
      .input("kode", sql.VarChar(20), String(kode))
      .input("nama", sql.NVarChar(200), String(nama))
      .input("satuan", sql.VarChar(20), String(satuan))
      .input("harga", sql.Decimal(18, 2), Number(harga)).query(`
        INSERT INTO dbo.Barang (Kode, Nama, Satuan, Harga)
        VALUES (@kode, @nama, @satuan, @harga);
      `);
    return NextResponse.json({ ok: true }, { status: 201 });
  } catch (e) {
    const msg = e instanceof Error ? e.message : "Gagal menyimpan barang.";
    const status = /UNIQUE|duplicate/i.test(msg) ? 409 : 500;
    return NextResponse.json({ error: msg }, { status });
  }
}

export async function PUT(req: Request) {
  const body = await req.json();
  const { barangId, nama, satuan, harga } = body ?? {};
  if (!barangId || !nama) {
    return NextResponse.json({ error: "barangId dan nama wajib diisi." }, { status: 400 });
  }
  const pool = await getAppPool();
  // Catatan: kolom Stok SENGAJA tidak ada di SET — hanya sp_SimpanTransaksi yang boleh mengubahnya.
  await pool
    .request()
    .input("id", sql.Int, Number(barangId))
    .input("nama", sql.NVarChar(200), String(nama))
    .input("satuan", sql.VarChar(20), String(satuan ?? "Pcs"))
    .input("harga", sql.Decimal(18, 2), Number(harga ?? 0)).query(`
      UPDATE dbo.Barang SET Nama = @nama, Satuan = @satuan, Harga = @harga
      WHERE BarangId = @id;
    `);
  return NextResponse.json({ ok: true });
}
