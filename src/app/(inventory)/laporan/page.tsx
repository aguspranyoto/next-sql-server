"use client";

import { useCallback, useEffect, useState } from "react";

type Mutasi = { Kode: string; Nama: string; Satuan: string; TotalMasuk: number; TotalKeluar: number; StokAkhir: number; MutasiBersih: number };
type Minim = { Kode: string; Nama: string; Satuan: string; Stok: number; Keluar30Hari: number };

export default function LaporanPage() {
  const [from, setFrom] = useState("");
  const [to, setTo] = useState("");
  const [batas, setBatas] = useState("10");
  const [mutasi, setMutasi] = useState<Mutasi[]>([]);
  const [minim, setMinim] = useState<Minim[]>([]);

  const load = useCallback(async () => {
    const p = new URLSearchParams();
    if (from) p.set("from", from);
    if (to) p.set("to", to);
    const [m, s] = await Promise.all([
      fetch(`/api/laporan/mutasi?${p}`).then((r) => r.json()),
      fetch(`/api/laporan/stok-minim?batas=${Number(batas) || 10}`).then((r) => r.json()),
    ]);
    setMutasi(m.data ?? []);
    setMinim(s.data ?? []);
  }, [from, to, batas]);
  useEffect(() => { load(); }, [load]);

  return (
    <div>
      <h1 className="text-2xl font-bold">Laporan</h1>

      <div className="mt-4 flex flex-wrap items-end gap-2 rounded-lg bg-white p-4 shadow-sm ring-1 ring-zinc-200">
        <label className="text-sm">Dari <input type="date" className="rounded border px-2 py-1.5" value={from} onChange={(e) => setFrom(e.target.value)} /></label>
        <label className="text-sm">Sampai <input type="date" className="rounded border px-2 py-1.5" value={to} onChange={(e) => setTo(e.target.value)} /></label>
        <label className="text-sm">Batas stok minim <input type="number" min={0} className="w-20 rounded border px-2 py-1.5" value={batas} onChange={(e) => setBatas(e.target.value)} /></label>
      </div>

      <h2 className="mt-6 font-semibold">⚠ Stok minim ({minim.length})</h2>
      <div className="mt-2 overflow-x-auto rounded-lg bg-white shadow-sm ring-1 ring-zinc-200">
        <table className="w-full text-sm">
          <thead className="bg-zinc-50 text-left"><tr><th className="p-2">Kode</th><th className="p-2">Nama</th><th className="p-2 text-right">Stok</th><th className="p-2 text-right">Keluar 30 hari</th></tr></thead>
          <tbody>
            {minim.map((b) => (
              <tr key={b.Kode} className="border-t">
                <td className="p-2 font-mono">{b.Kode}</td><td className="p-2">{b.Nama}</td>
                <td className="p-2 text-right font-bold text-red-700">{b.Stok}</td>
                <td className="p-2 text-right">{b.Keluar30Hari}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <h2 className="mt-6 font-semibold">Mutasi per barang</h2>
      <div className="mt-2 overflow-x-auto rounded-lg bg-white shadow-sm ring-1 ring-zinc-200">
        <table className="w-full text-sm">
          <thead className="bg-zinc-50 text-left"><tr><th className="p-2">Kode</th><th className="p-2">Nama</th><th className="p-2 text-right">Masuk</th><th className="p-2 text-right">Keluar</th><th className="p-2 text-right">Stok akhir</th></tr></thead>
          <tbody>
            {mutasi.map((b) => (
              <tr key={b.Kode} className="border-t">
                <td className="p-2 font-mono">{b.Kode}</td><td className="p-2">{b.Nama}</td>
                <td className="p-2 text-right text-green-700">+{b.TotalMasuk}</td>
                <td className="p-2 text-right text-red-700">-{b.TotalKeluar}</td>
                <td className="p-2 text-right font-semibold">{b.StokAkhir}</td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}
