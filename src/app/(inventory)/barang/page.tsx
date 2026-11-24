"use client";

import { useCallback, useEffect, useState } from "react";

type Barang = { BarangId: number; Kode: string; Nama: string; Satuan: string; Stok: number; Harga: number; NilaiPersediaan: number };
const rupiah = (n: number) => "Rp " + Number(n).toLocaleString("id-ID");

export default function BarangPage() {
  const [q, setQ] = useState("");
  const [page, setPage] = useState(1);
  const [rows, setRows] = useState<Barang[]>([]);
  const [total, setTotal] = useState(0);
  const [msg, setMsg] = useState("");
  const [form, setForm] = useState({ kode: "", nama: "", satuan: "Pcs", harga: "" });
  const [edit, setEdit] = useState<Barang | null>(null);
  const pageSize = 20;

  const load = useCallback(async () => {
    const r = await fetch(`/api/barang?q=${encodeURIComponent(q)}&page=${page}&pageSize=${pageSize}`);
    const j = await r.json();
    setRows(j.data ?? []);
    setTotal(j.total ?? 0);
  }, [q, page]);
  useEffect(() => { load(); }, [load]);

  const submit = async (e: React.FormEvent) => {
    e.preventDefault();
    setMsg("");
    const r = await fetch("/api/barang", {
      method: edit ? "PUT" : "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify(edit
        ? { barangId: edit.BarangId, nama: form.nama, satuan: form.satuan, harga: Number(form.harga) || 0 }
        : { kode: form.kode, nama: form.nama, satuan: form.satuan, harga: Number(form.harga) || 0 }),
    });
    const j = await r.json();
    if (!r.ok) { setMsg(j.error); return; }
    setMsg(edit ? "Barang diperbarui." : "Barang ditambah (stok awal 0 — tambah lewat Transaksi).");
    setForm({ kode: "", nama: "", satuan: "Pcs", harga: "" });
    setEdit(null);
    load();
  };

  const pages = Math.max(1, Math.ceil(total / pageSize));

  return (
    <div>
      <h1 className="text-2xl font-bold">Barang</h1>

      <form onSubmit={submit} className="mt-4 rounded-lg bg-white p-4 shadow-sm ring-1 ring-zinc-200">
        <div className="text-sm font-semibold">{edit ? `Ubah ${edit.Kode}` : "Tambah barang"}</div>
        <div className="mt-2 grid gap-2 sm:grid-cols-5">
          {!edit && <input className="rounded border px-2 py-1.5" placeholder="Kode" value={form.kode} onChange={(e) => setForm({ ...form, kode: e.target.value })} />}
          <input className="rounded border px-2 py-1.5 sm:col-span-2" placeholder="Nama" value={form.nama} onChange={(e) => setForm({ ...form, nama: e.target.value })} />
          <input className="rounded border px-2 py-1.5" placeholder="Satuan" value={form.satuan} onChange={(e) => setForm({ ...form, satuan: e.target.value })} />
          <input className="rounded border px-2 py-1.5" placeholder="Harga" inputMode="numeric" value={form.harga} onChange={(e) => setForm({ ...form, harga: e.target.value })} />
        </div>
        <div className="mt-2 flex gap-2">
          <button className="rounded bg-zinc-900 px-4 py-1.5 text-sm text-white">{edit ? "Simpan" : "Tambah"}</button>
          {edit && <button type="button" className="rounded border px-4 py-1.5 text-sm" onClick={() => { setEdit(null); setForm({ kode: "", nama: "", satuan: "Pcs", harga: "" }); }}>Batal</button>}
        </div>
        {msg && <div className="mt-2 text-sm text-zinc-600">{msg}</div>}
      </form>

      <div className="mt-4 flex items-center gap-2">
        <input className="w-72 rounded border px-2 py-1.5" placeholder="Cari kode / nama..." value={q} onChange={(e) => { setQ(e.target.value); setPage(1); }} />
        <span className="text-sm text-zinc-500">{total} barang</span>
      </div>

      <div className="mt-2 overflow-x-auto rounded-lg bg-white shadow-sm ring-1 ring-zinc-200">
        <table className="w-full text-sm">
          <thead className="bg-zinc-50 text-left">
            <tr><th className="p-2">Kode</th><th className="p-2">Nama</th><th className="p-2">Satuan</th><th className="p-2 text-right">Stok</th><th className="p-2 text-right">Harga</th><th className="p-2 text-right">Nilai</th><th className="p-2"></th></tr>
          </thead>
          <tbody>
            {rows.map((b) => (
              <tr key={b.BarangId} className="border-t">
                <td className="p-2 font-mono">{b.Kode}</td>
                <td className="p-2">{b.Nama}</td>
                <td className="p-2">{b.Satuan}</td>
                <td className="p-2 text-right font-semibold">{b.Stok}</td>
                <td className="p-2 text-right">{rupiah(b.Harga)}</td>
                <td className="p-2 text-right">{rupiah(b.NilaiPersediaan)}</td>
                <td className="p-2 text-right"><button className="text-blue-700 hover:underline" onClick={() => { setEdit(b); setForm({ kode: b.Kode, nama: b.Nama, satuan: b.Satuan, harga: String(b.Harga) }); }}>Ubah</button></td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <div className="mt-3 flex items-center gap-2 text-sm">
        <button disabled={page <= 1} onClick={() => setPage(page - 1)} className="rounded border px-3 py-1 disabled:opacity-40">‹ Prev</button>
        <span>Halaman {page} / {pages}</span>
        <button disabled={page >= pages} onClick={() => setPage(page + 1)} className="rounded border px-3 py-1 disabled:opacity-40">Next ›</button>
      </div>
    </div>
  );
}
