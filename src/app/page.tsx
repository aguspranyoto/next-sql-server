import Link from "next/link";

const CARDS = [
  ["Barang", "/barang", "Kelola master barang + stok terkini"],
  ["Transaksi", "/transaksi", "Catat barang masuk / keluar"],
  ["Riwayat", "/riwayat", "Daftar transaksi + detail"],
  ["Laporan", "/laporan", "Mutasi per barang + stok minim"],
  ["Playground", "/playground", "Uji query SELECT langsung"],
] as const;

export default function Home() {
  return (
    <div>
      <h1 className="text-2xl font-bold">Web Inventory</h1>
      <p className="mt-1 text-sm text-zinc-600">Next.js App Router + SQL Server 2022 (Docker).</p>
      <div className="mt-6 grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {CARDS.map(([t, href, d]) => (
          <Link key={href} href={href} className="rounded-lg bg-white p-5 shadow-sm ring-1 ring-zinc-200 hover:ring-zinc-400">
            <div className="font-semibold">{t}</div>
            <div className="mt-1 text-sm text-zinc-600">{d}</div>
          </Link>
        ))}
      </div>
    </div>
  );
}
