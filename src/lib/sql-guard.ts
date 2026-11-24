const BLOCKED = [
  "INSERT", "UPDATE", "DELETE", "DROP", "ALTER", "CREATE", "TRUNCATE",
  "MERGE", "EXEC", "EXECUTE", "GRANT", "REVOKE", "DENY", "BACKUP",
  "RESTORE", "DBCC", "SHUTDOWN", "OPENROWSET", "OPENDATASOURCE", "BULK",
];

export function validateSelectOnly(query: string): string | null {
  const q = query.trim();
  if (!/^(SELECT|WITH)\b/i.test(q)) {
    return "Hanya query SELECT atau WITH yang diizinkan.";
  }
  const noStrings = q.replace(/'(?:[^']|'')*'/g, "''").replace(/--[^\n]*/g, "");
  const upper = ` ${noStrings.toUpperCase()} `;
  for (const kw of BLOCKED) {
    if (new RegExp(`[^A-Z0-9_]${kw}[^A-Z0-9_]`).test(upper)) {
      return `Kata kunci "${kw}" tidak diizinkan di playground.`;
    }
  }
  if (/[^A-Z0-9_]XP_[A-Z]+/.test(upper)) {
    return 'Extended stored procedure (xp_*) tidak diizinkan.';
  }
  if (/;/.test(noStrings.replace(/''/g, "").replace(/;\s*$/, ""))) {
    return "Satu query saja per eksekusi — jalankan satu per satu, tanpa menggabungkan pakai titik koma.";
  }
  return null;
}
