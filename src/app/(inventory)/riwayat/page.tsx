"use client";

import { useCallback, useEffect, useState } from "react";

type Item = { DetailId: number; Kode: string; Nama: string; Satuan: string; Qty: number };
type Trx = { TransaksiId: number; Tanggal: string; Tipe: string; Keterangan: string | null; items: Item[] };

export default function RiwayatPage() {
  const [rows, setRows] = useState<Trx[]>([]);
  const load = useCallback(async () => {
    const r = await fetch("/api/transaksi?limit=50");
    const j = await r.json();
    setRows(j.data ?? []);
  }, []);
  useEffect(() => { load(); }, [load]);

  return (
    <div>
      <div className="flex items-center gap-3">
        <h1 className="text-2xl font-bold">Riwayat</h1>
        <button onClick={load} className="rounded border px-3 py-1 text-sm">Muat ulang</button>
      </div>
      <div className="mt-4 space-y-3">
        {rows.map((t) => (
          <div key={t.TransaksiId} className="rounded-lg bg-white p-4 shadow-sm ring-1 ring-zinc-200">
            <div className="flex flex-wrap items-center gap-2 text-sm">
              <span className={`rounded px-2 py-0.5 font-semibold ${t.Tipe === "I" ? "bg-green-100 text-green-800" : "bg-red-100 text-red-800"}`}>
                {t.Tipe === "I" ? "Masuk" : "Keluar"}
              </span>
              <span className="font-mono">#{t.TransaksiId}</span>
              <span className="text-zinc-500">{new Date(t.Tanggal).toLocaleString("id-ID")}</span>
              {t.Keterangan && <span className="text-zinc-600">— {t.Keterangan}</span>}
            </div>
            <table className="mt-2 w-full text-sm">
              <tbody>
                {t.items.map((d) => (
                  <tr key={d.DetailId} className="border-t">
                    <td className="py-1 font-mono">{d.Kode}</td>
                    <td className="py-1">{d.Nama}</td>
                    <td className="py-1 text-right">{d.Qty} {d.Satuan}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        ))}
        {!rows.length && <div className="text-sm text-zinc-500">Belum ada transaksi.</div>}
      </div>
    </div>
  );
}
