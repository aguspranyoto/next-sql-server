import sql from "mssql";

function config(user: string, password: string, requestTimeout = 15000): sql.config {
  return {
    server: process.env.MSSQL_SERVER ?? "127.0.0.1",
    database: process.env.MSSQL_DATABASE ?? "InventoryDB",
    user,
    password,
    requestTimeout,
    options: { encrypt: false, trustServerCertificate: true },
    pool: { max: 10, min: 0, idleTimeoutMillis: 30000 },
  };
}

const g = globalThis as unknown as {
  _appPool?: Promise<sql.ConnectionPool>;
  _viewerPool?: Promise<sql.ConnectionPool>;
};

export function getAppPool(): Promise<sql.ConnectionPool> {
  g._appPool ??= new sql.ConnectionPool(
    config(process.env.MSSQL_USER!, process.env.MSSQL_PASSWORD!),
  ).connect();
  return g._appPool;
}

export function getViewerPool(): Promise<sql.ConnectionPool> {
  g._viewerPool ??= new sql.ConnectionPool(
    config(process.env.MSSQL_VIEWER_USER!, process.env.MSSQL_VIEWER_PASSWORD!, 5000),
  ).connect();
  return g._viewerPool;
}
