import { NextResponse } from "next/server";
import { getViewerPool } from "@/lib/db";
import { validateSelectOnly } from "@/lib/sql-guard";


// POST /api/playground — SELECT bebas, pool read-only + filter + ROWCOUNT + timeout
export async function POST(req: Request) {
  const body = await req.json();
  const query = String(body?.query ?? "");
  if (!query.trim()) {
    return NextResponse.json({ error: "Query kosong." }, { status: 400 });
  }
  const rejected = validateSelectOnly(query);
  if (rejected) {
    return NextResponse.json({ error: rejected }, { status: 422 });
  }
  const pool = await getViewerPool();
  try {
    const rs = await pool.request().query(`SET ROWCOUNT 200; ${query}`);
    return NextResponse.json({ columns: Object.keys(rs.recordset[0] ?? {}), rows: rs.recordset });
  } catch (e) {
    const msg = e instanceof Error ? e.message : "Query gagal.";
    return NextResponse.json({ error: msg }, { status: 400 });
  }
}
