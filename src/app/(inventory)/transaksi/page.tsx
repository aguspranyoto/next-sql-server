"use client";

import { useEffect, useState } from "react";

type Barang = { BarangId: number; Kode: string; Nama: string; Stok: number };
type Line = { barangId: number; qty: number };

export default function TransaksiPage() {
  const [barang, setBarang] = useState<Barang[]>([]);
  const [tipe, setTipe] = useState<"I" | "O">("I");
  const [keterangan, setKeterangan] = useState("");
  const [lines, setLines] = useState<Line[]>([{ barangId: 0, qty: 1 }]);
  const [msg, setMsg] = useState("");

  useEffect(() => {
    fetch("/api/barang?pageSize=100").then((r) => r.json()).then((j) => setBarang(j.data ?? []));
  }, []);

  const submit = async (e: React.FormEvent) => {
    e.preventDefault();
    setMsg("");
    const items = lines.filter((l) => l.barangId > 0 && l.qty > 0);
    if (!items.length) { setMsg("Tambahkan minimal 1 baris barang."); return; }
    const r = await fetch("/api/transaksi", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({ tipe, keterangan: keterangan || null, items }),
    });
    const j = await r.json();
    if (!r.ok) { setMsg(j.error); return; }
    setMsg(`Tersimpan — Transaksi #${j.transaksiId}.`);
    setLines([{ barangId: 0, qty: 1 }]);
    setKeterangan("");
  };

  return (
    <div>
      <h1 className="text-2xl font-bold">Transaksi</h1>
      <form onSubmit={submit} className="mt-4 rounded-lg bg-white p-4 shadow-sm ring-1 ring-zinc-200">
        <div className="flex flex-wrap gap-2">
          <select className="rounded border px-2 py-1.5" value={tipe} onChange={(e) => setTipe(e.target.value as "I" | "O")}>
            <option value="I">Masuk (pembelian)</option>
            <option value="O">Keluar (penjualan)</option>
          </select>
          <input className="min-w-64 flex-1 rounded border px-2 py-1.5" placeholder="Keterangan (opsional)" value={keterangan} onChange={(e) => setKeterangan(e.target.value)} />
        </div>
        <div className="mt-3 space-y-2">
          {lines.map((l, i) => (
            <div key={i} className="flex gap-2">
              <select className="flex-1 rounded border px-2 py-1.5" value={l.barangId} onChange={(e) => setLines(lines.map((x, j) => j === i ? { ...x, barangId: Number(e.target.value) } : x))}>
                <option value={0}>— pilih barang —</option>
                {barang.map((b) => <option key={b.BarangId} value={b.BarangId}>{b.Kode} — {b.Nama} (stok {b.Stok})</option>)}
              </select>
              <input type="number" min={1} className="w-24 rounded border px-2 py-1.5" value={l.qty} onChange={(e) => setLines(lines.map((x, j) => j === i ? { ...x, qty: Number(e.target.value) } : x))} />
              <button type="button" className="rounded border px-3" onClick={() => setLines(lines.filter((_, j) => j !== i))}>✕</button>
            </div>
          ))}
        </div>
        <div className="mt-3 flex gap-2">
          <button type="button" className="rounded border px-4 py-1.5 text-sm" onClick={() => setLines([...lines, { barangId: 0, qty: 1 }])}>+ Baris</button>
          <button className="rounded bg-zinc-900 px-4 py-1.5 text-sm text-white">Simpan transaksi</button>
        </div>
        {msg && <div className="mt-2 text-sm text-zinc-600">{msg}</div>}
      </form>
    </div>
  );
}
