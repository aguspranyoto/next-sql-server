import { writeFileSync } from "node:fs";
import { dirname, join } from "node:path";
import { fileURLToPath } from "node:url";

const dir = join(dirname(fileURLToPath(import.meta.url)), "..", "db");

function mulberry32(a) {
  return function () {
    a |= 0; a = (a + 0x6d2b79f5) | 0;
    let t = Math.imul(a ^ (a >>> 15), 1 | a);
    t = (t + Math.imul(t ^ (t >>> 7), 61 | t)) ^ t;
    return ((t ^ (t >>> 14)) >>> 0) / 4294967296;
  };
}
const rand = mulberry32(20251124);
const ri = (a, b) => a + Math.floor(rand() * (b - a + 1));
const pick = (arr) => arr[Math.floor(rand() * arr.length)];
const shuffle = (arr) => {
  const a = [...arr];
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(rand() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
};

// [nama, satuan, harga IDR, vel 0=slow 1=med 2=fast]
const F = 2, M = 1, S = 0;
const catalog = [
  ["Sembako", [
    ["Beras Premium 5Kg", "Karung", 62500, F],
    ["Gula Pasir 1Kg", "Pack", 17500, F],
    ["Minyak Goreng 2L", "Pouch", 44500, F],
    ["Tepung Terigu Protein Sedang 1Kg", "Pack", 12500, F],
    ["Mie Instan Goreng Dus 40", "Dus", 118000, F],
    ["Mie Instan Ayam Bawang Dus 40", "Dus", 112000, F],
    ["Sarden Kaleng 425G", "Pcs", 21000, F],
    ["Kecap Manis 550Ml", "Botol", 26500, F],
    ["Kopi Bubuk Robusta 250G", "Pack", 32000, F],
    ["Teh Celup Box 25", "Pack", 15000, F],
    ["Susu Kental Manis Kaleng 490G", "Pcs", 13500, F],
    ["Garam Dapur 500G", "Pack", 6000, F],
    ["Telur Ayam Negeri 1Kg", "Kg", 28000, F],
    ["Gula Merah Sisir 1Kg", "Pack", 19000, F],
    ["Saus Sambal 550Ml", "Botol", 24000, F],
    ["Penyedap Rasa Ayam 1Kg", "Pack", 32000, F],
    ["Santan Instan 200Ml", "Pcs", 8500, F],
    ["Biskuit Kaleng 485G", "Kaleng", 34000, F],
    ["Wafer Cokelat Dus 24", "Dus", 85000, F],
    ["Keripik Singkong Bal 2Kg", "Ball", 45000, M],
  ]],
  ["Minuman", [
    ["Air Mineral 600Ml Dus 24", "Dus", 54000, F],
    ["Air Mineral Galon 19L", "Galon", 20000, F],
    ["Teh Manis Botol 450Ml Dus 24", "Dus", 88000, F],
    ["Kopi Sachet Renteng 10", "Renteng", 15500, F],
    ["Jus Jeruk 1L", "Kotak", 18000, F],
    ["Minuman Soda Kaleng 330Ml Pack 6", "Pack", 45000, F],
    ["Sirup Cocopandan 650Ml", "Botol", 28000, F],
    ["Susu UHT Cokelat 1L", "Kotak", 21000, F],
    ["Susu UHT Full Cream 1L", "Kotak", 19500, F],
    ["Minuman Energi Dus 24", "Dus", 108000, M],
  ]],
  ["ATK", [
    ["Kertas HVS A4 80Gsm Rim 500", "Rim", 58000, M],
    ["Buku Tulis 58 Lembar Lusin 12", "Lusin", 48000, M],
    ["Pulpen Hitam 0.5 Box 12", "Box", 24000, M],
    ["Pensil 2B Box 12", "Box", 18000, M],
    ["Spidol Whiteboard Hitam", "Pcs", 12000, M],
    ["Map Plastik Kancing Lusin 12", "Lusin", 30000, M],
    ["Hekter Stapler No.10", "Set", 35000, M],
    ["Isi Staples No.10", "Box", 8000, M],
    ["Lakban Bening 48Mm", "Pcs", 12000, M],
    ["Amplop Coklat Pack 100", "Pack", 45000, M],
    ["Penggaris Plastik 30Cm", "Pcs", 5000, M],
    ["Sticky Note 3x3", "Pack", 15000, M],
    ["Correction Tape", "Pcs", 14000, M],
    ["Tinta Isi Ulang Printer 100Ml", "Botol", 45000, M],
  ]],
  ["Elektronik", [
    ["Baterai AA Pack 4", "Pack", 28000, M],
    ["Baterai AAA Pack 4", "Pack", 26000, M],
    ["Lampu LED 9W Putih", "Pcs", 22000, M],
    ["Stop Kontak Arde", "Pcs", 18000, M],
    ["Saklar Engkel", "Pcs", 15000, M],
    ["Kabel Data USB-C 1M", "Pcs", 35000, M],
    ["Charger HP 25W", "Pcs", 125000, M],
    ["Kabel Roll 4 Lubang 10M", "Pcs", 145000, S],
    ["Senter LED Tangan", "Pcs", 65000, M],
    ["Kipas Angin Meja 12 Inci", "Pcs", 185000, S],
    ["Setrika Listrik", "Pcs", 175000, S],
    ["Rice Cooker 1.8L", "Pcs", 325000, S],
    ["Dispenser Galon Bawah", "Pcs", 450000, S],
    ["Lakban Listrik", "Pcs", 8000, M],
  ]],
  ["Perkakas", [
    ["Palu Cakar Gagang Fiber", "Pcs", 45000, M],
    ["Obeng Set 6 Pcs", "Set", 75000, M],
    ["Tang Kombinasi 8 Inci", "Pcs", 55000, M],
    ["Kunci Pas Set 14 Pcs", "Set", 185000, S],
    ["Meteran 5M", "Pcs", 35000, M],
    ["Gergaji Kayu 18 Inci", "Pcs", 65000, M],
    ["Mesin Bor 13Mm", "Pcs", 385000, S],
    ["Kuas Cat 2 Inci", "Pcs", 12000, M],
    ["Cat Tembok Interior 5Kg", "Pail", 165000, M],
    ["Semen 40Kg", "Sak", 65000, M],
    ["Paku Campur 1Kg", "Kg", 22000, M],
  ]],
  ["Kebersihan", [
    ["Sabun Cuci Piring 800Ml", "Botol", 22000, F],
    ["Deterjen Bubuk 1Kg", "Pack", 24000, F],
    ["Pewangi Pakaian 800Ml", "Pouch", 21000, F],
    ["Pembersih Lantai 800Ml", "Botol", 19000, F],
    ["Sabun Mandi Batang Pack 4", "Pack", 18000, F],
    ["Sampo Anti Ketombe 340Ml", "Botol", 32000, F],
    ["Pasta Gigi Mint 190G", "Pcs", 18000, F],
    ["Tisu Wajah 250 Lembar", "Pack", 25000, F],
    ["Sapu Ijuk Lantai", "Pcs", 35000, M],
    ["Alat Pel Lantai", "Set", 45000, M],
    ["Keset Kaki", "Pcs", 25000, M],
    ["Ember Plastik 15L", "Pcs", 28000, M],
    ["Sikat Gigi Dewasa Lusin 12", "Lusin", 60000, M],
    ["Masker Medis Box 50", "Box", 25000, M],
    ["Hand Sanitizer 500Ml", "Botol", 35000, M],
  ]],
  ["Dapur", [
    ["Piring Melamin 9 Inci Lusin 12", "Lusin", 120000, M],
    ["Gelas Plastik Lusin 12", "Lusin", 45000, M],
    ["Sendok Makan Lusin 12", "Lusin", 30000, M],
    ["Pisau Dapur Set 3 Pcs", "Set", 95000, M],
    ["Wajan Anti Lengket 28Cm", "Pcs", 125000, M],
    ["Toples Plastik Set 3", "Set", 55000, M],
    ["Kantong Plastik Kresek 1Kg", "Pack", 15000, F],
  ]],
];

const suppliers = ["PT Sumber Makmur Abadi", "PT Cahaya Timur Sejahtera", "CV Berkah Jaya Abadi", "UD Maju Bersama", "PT Indo Niaga Pratama", "CV Sinar Abadi Jaya", "PT Tunas Bangsa Distribusi", "UD Barokah Makmur"];
const customers = ["Toko Kelontong Hj. Aminah", "Warung Pak Dedi", "Toko Barokah", "RM Padang Sederhana", "Kantin Sekolah Ceria", "Toko Hj. Fatimah", "Warung Kopi Anak Muda", "Toko Serba Ada Berkah", "Katering Bu Ratna", "Toko Pak Haji Usman", "Koperasi Karyawan Maju", "Warung Bu Siti", "Toko Fresh Ibu Dewi", "Warung Nasi Bu Yuni"];

const items = [];
catalog.forEach(([cat, list], ci) => {
  list.forEach(([nama, satuan, harga], j) => {
    items.push({ kode: `BRG-${String(items.length + 1).padStart(4, "0")}`, nama, satuan, harga, vel: list[j][3], cat });
  });
});
const byKode = Object.fromEntries(items.map((it) => [it.kode, it]));

const now = new Date();
const start = new Date(now.getFullYear(), now.getMonth(), now.getDate());
start.setFullYear(start.getFullYear() - 1);
const fmt = (d) => {
  const p = (n) => String(n).padStart(2, "0");
  return `${d.getFullYear()}-${p(d.getMonth() + 1)}-${p(d.getDate())}T${p(d.getHours())}:${p(d.getMinutes())}:${p(d.getSeconds())}`;
};
const dayInMonth = (y, m) => new Date(y, m, ri(1, 28), ri(8, 17), ri(0, 59), 0);

const esc = (s) => s.replace(/'/g, "''");
const stock = {};
items.forEach((it) => (stock[it.kode] = 0));
const events = [];

// Saldo awal per kategori agar riwayat terbaca rapi.
catalog.forEach(([cat]) => {
  const lines = items
    .filter((it) => it.cat === cat)
    .map((it) => {
      const q = it.vel === F ? ri(80, 220) : it.vel === M ? ri(25, 90) : ri(6, 30);
      stock[it.kode] += q;
      return [it.kode, q];
    });
  events.push({ date: new Date(start), tipe: "I", ket: `Saldo awal — stok opname gudang (${cat})`, lines });
});

let po = 1, inv = 1;
const fast = items.filter((i) => i.vel === F);
const med = items.filter((i) => i.vel === M);
const slow = items.filter((i) => i.vel === S);
const pickVel = () => {
  const r = rand();
  const pool = r < 0.55 ? fast : r < 0.85 ? med : slow;
  return pick(pool);
};

for (let m = 0; m < 12; m++) {
  const d = new Date(start.getFullYear(), start.getMonth() + m, 1);
  const y = d.getFullYear(), mo = d.getMonth();
  const nBuy = ri(6, 10), nSell = ri(10, 16);

  for (let i = 0; i < nBuy; i++) {
    const n = ri(2, 6);
    const lines = [];
    for (const it of shuffle(items).slice(0, n)) {
      const q = it.vel === F ? ri(24, 120) : it.vel === M ? ri(12, 60) : ri(3, 15);
      stock[it.kode] += q;
      lines.push([it.kode, q]);
    }
    events.push({ date: dayInMonth(y, mo), tipe: "I", ket: `Pembelian dari ${pick(suppliers)} — PO-${y}${String(po++).padStart(4, "0")}`, lines });
  }
  for (let i = 0; i < nSell; i++) {
    const n = ri(1, 5);
    const lines = [];
    for (const it of Array.from({ length: n }, pickVel)) {
      if (lines.some(([k]) => k === it.kode)) continue;
      const want = it.vel === F ? ri(2, 12) : it.vel === M ? ri(1, 6) : ri(1, 2);
      const q = Math.min(want, stock[it.kode]);
      if (q <= 0) continue;
      stock[it.kode] -= q;
      lines.push([it.kode, q]);
    }
    if (!lines.length) continue;
    events.push({ date: dayInMonth(y, mo), tipe: "O", ket: `Penjualan ke ${pick(customers)} — INV-${y}${String(inv++).padStart(4, "0")}`, lines });
  }
}
events.sort((a, b) => a.date - b.date);

// Replay sesuai URUTAN EKSEKUSI AKTUAL (kronologis): penjualan dijepit ke stok
// yang benar-benar tersedia pada tanggal itu. Tanpa ini, sort tanggal bisa
// menaruh penjualan sebelum pembelian yang digunakannya sebagai sumber stok.
const live = {};
items.forEach((it) => (live[it.kode] = 0));
const finalEvents = [];
for (const e of events) {
  if (e.tipe === "I") {
    for (const [k, q] of e.lines) live[k] += q;
    finalEvents.push(e);
  } else {
    const lines = [];
    for (const [k, q] of e.lines) {
      const take = Math.min(q, live[k]);
      if (take <= 0) continue;
      live[k] -= take;
      lines.push([k, take]);
    }
    if (lines.length) finalEvents.push({ ...e, lines });
  }
}
const useEvents = finalEvents;

const L = [];
L.push("-- 02-seed.sql");
L.push("-- Data master + riwayat transaksi 12 bulan terakhir (dibangkitkan: node scripts/gen-seed.mjs).");
L.push(`-- Isi: ${items.length} barang, ${useEvents.length} transaksi. Idempoten: tidak berbuat apa-apa bila Barang sudah terisi.`);
L.push("-- Seluruh pergerakan stok masuk lewat dbo.sp_SimpanTransaksi (aturan berlaku juga untuk seed).");
L.push("");
L.push("USE InventoryDB;");
L.push("GO");
L.push("");
L.push("SET NOCOUNT ON;");
L.push("IF (SELECT COUNT(*) FROM dbo.Barang) = 0");
L.push("BEGIN");
L.push("    PRINT 'Seeding InventoryDB...';");
L.push("");
L.push("    INSERT INTO dbo.Barang (Kode, Nama, Satuan, Harga)");
for (let i = 0; i < items.length; i++) {
  const it = items[i];
  L.push(`    ${i === 0 ? "VALUES" : "      "} ('${it.kode}', N'${esc(it.nama)}', '${esc(it.satuan)}', ${it.harga})${i === items.length - 1 ? ";" : ","}`);
}
L.push("");
L.push("    DECLARE @D dbo.TransaksiDetailType;");
for (const e of useEvents) {
  const vals = e.lines.map(([k, q]) => `('${k}', ${q})`).join(", ");
  L.push("");
  L.push("    INSERT INTO @D (BarangId, Qty)");
  L.push("    SELECT b.BarangId, v.Qty");
  L.push(`    FROM (VALUES ${vals}) AS v(Kode, Qty)`);
  L.push("    JOIN dbo.Barang AS b ON b.Kode = v.Kode;");
  L.push(`    EXEC dbo.sp_SimpanTransaksi @Tanggal = '${fmt(e.date)}', @Tipe = '${e.tipe}', @Keterangan = N'${esc(e.ket)}', @Details = @D;`);
  L.push("    DELETE FROM @D;");
}
L.push("");
L.push(`    PRINT 'Seed selesai: ${items.length} barang, ${useEvents.length} transaksi.';`);
L.push("END");
L.push("ELSE");
L.push("    PRINT 'Barang sudah terisi — seed dilewati.';");
L.push("GO");

writeFileSync(join(dir, "02-seed.sql"), L.join("\n") + "\n");
console.log(`02-seed.sql ditulis: ${items.length} barang, ${events.length} transaksi.`);
