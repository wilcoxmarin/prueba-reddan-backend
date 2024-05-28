import { ConnectionOptions } from "mysql2/promise";
import dotenv from "dotenv";
import { createPool, Pool } from "mysql2";

class DB {
  private acces: ConnectionOptions = {
    user: "secret", //process.env.DB_USER,
    password: "secret", //process.env.DB_PASSWORD,
    database: "reddan", //process.env.DB_DATABASE,
    port: Number(process.env.DB_PORT),
    host: process.env.DB_HOST,
  };

  private connection: Pool;

  constructor() {
    console.log("Se inicio conexion con la base de datos");

    dotenv.config();
    this.connection = createPool(this.acces);
  }

  private ensureConnection() {
    if (!this?.connection) this.connection = createPool(this.acces);
  }

  async query(sql: string, values?: any[]) {
    try {
      this.ensureConnection();
      return new Promise((resolve, reject) => {
        this.connection.query(sql, values, (error, rows) => {
          if (error instanceof Error) {
            console.log(error);
            reject(error);
            return;
          }
          resolve(rows);
          // this.connection.end();
        });
      });
    } catch (error) {
      throw new Error(`Error en la consulta ${error}`);
    }
  }
}

const CONN = new DB();
export default CONN;
