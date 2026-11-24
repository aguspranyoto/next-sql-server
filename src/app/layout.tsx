import type { Metadata } from "next";
import Link from "next/link";
import "./globals.css";

export const metadata: Metadata = {
  title: "Web Inventory",
  description: "Aplikasi inventory Next.js + SQL Server",
};

const NAV = [
  ["Barang", "/barang"],
  ["Transaksi", "/transaksi"],
  ["Riwayat", "/riwayat"],
  ["Laporan", "/laporan"],
  ["Playground", "/playground"],
] as const;

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="id">
      <body className="min-h-screen bg-zinc-100 text-zinc-900 antialiased">
        <header className="bg-zinc-900 text-white">
          <div className="mx-auto flex max-w-6xl items-center gap-6 px-4 py-3">
            <Link href="/" className="text-lg font-bold tracking-tight">
              📦 Inventory
            </Link>
            <nav className="flex flex-wrap gap-1 text-sm">
              {NAV.map(([label, href]) => (
                <Link key={href} href={href} className="rounded px-3 py-1.5 hover:bg-zinc-700">
                  {label}
                </Link>
              ))}
            </nav>
          </div>
        </header>
        <main className="mx-auto max-w-6xl px-4 py-6">{children}</main>
      </body>
    </html>
  );
}
