"use client";

import { useState } from "react";

const CONTOH = [
  "SELECT TOP 10 Kode, Nama, Stok, Harga FROM dbo.Barang ORDER BY Stok DESC;",
  "SELECT * FROM dbo.vw_StokBarang WHERE Stok <= 10 ORDER BY Stok;",
  "SELECT Tipe, COUNT(*) AS Jumlah, SUM(d.Qty) AS TotalQty\nFROM dbo.Transaksi AS t\nJOIN dbo.TransaksiDetail AS d ON d.TransaksiId = t.TransaksiId\nGROUP BY Tipe;",
];

export default function PlaygroundPage() {
  const [query, setQuery] = useState(CONTOH[0]);
  const [columns, setColumns] = useState<string[]>([]);
  const [rows, setRows] = useState<Record<string, unknown>[]>([]);
  const [error, setError] = useState("");
  const [busy, setBusy] = useState(false);

  const run = async () => {
    setBusy(true);
    setError("");
    try {
      const r = await fetch("/api/playground", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({ query }),
      });
      const j = await r.json();
      if (!r.ok) { setError(j.error ?? "Query gagal."); setRows([]); setColumns([]); return; }
      setColumns(j.columns ?? []);
      setRows(j.rows ?? []);
    } finally {
      setBusy(false);
    }
  };

  return (
    <div>
      <h1 className="text-2xl font-bold">Playground SQL</h1>
      <p className="mt-1 text-sm text-zinc-600">SELECT saja, login read-only, dibatasi 200 baris & timeout 5 detik. <kbd className="rounded border px-1">Ctrl+Enter</kbd> untuk run.</p>
      <div className="mt-2 flex flex-wrap gap-2">
        {CONTOH.map((c, i) => (
          <button key={i} onClick={() => setQuery(c)} className="rounded border px-2 py-1 text-xs">Contoh {i + 1}</button>
        ))}
      </div>
      <textarea
        className="mt-2 h-36 w-full rounded-lg border p-3 font-mono text-sm"
        value={query}
        onChange={(e) => setQuery(e.target.value)}
        onKeyDown={(e) => { if ((e.ctrlKey || e.metaKey) && e.key === "Enter") run(); }}
        spellCheck={false}
      />
      <button onClick={run} disabled={busy} className="mt-2 rounded bg-zinc-900 px-5 py-1.5 text-sm text-white disabled:opacity-50">
        {busy ? "Menjalankan..." : "Run"}
      </button>
      {error && <div className="mt-2 rounded bg-red-50 p-3 text-sm text-red-700 ring-1 ring-red-200">{error}</div>}
      {!!rows.length && (
        <div className="mt-2 overflow-x-auto rounded-lg bg-white shadow-sm ring-1 ring-zinc-200">
          <div className="p-2 text-xs text-zinc-500">{rows.length} baris</div>
          <table className="w-full font-mono text-xs">
            <thead className="bg-zinc-50 text-left"><tr>{columns.map((c) => <th key={c} className="p-2">{c}</th>)}</tr></thead>
            <tbody>
              {rows.map((r, i) => (
                <tr key={i} className="border-t">
                  {columns.map((c) => <td key={c} className="p-2">{r[c] == null ? <span className="text-zinc-400">NULL</span> : String(r[c])}</td>)}
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}
