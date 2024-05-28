"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const dotenv_1 = __importDefault(require("dotenv"));
const mysql2_1 = require("mysql2");
class DB {
    constructor() {
        this.acces = {
            user: "secret", //process.env.DB_USER,
            password: "secret", //process.env.DB_PASSWORD,
            database: "reddan", //process.env.DB_DATABASE,
            port: Number(process.env.DB_PORT),
            host: process.env.DB_HOST,
        };
        console.log("Se inicio conexion con la base de datos");
        dotenv_1.default.config();
        this.connection = (0, mysql2_1.createPool)(this.acces);
    }
    ensureConnection() {
        if (!(this === null || this === void 0 ? void 0 : this.connection))
            this.connection = (0, mysql2_1.createPool)(this.acces);
    }
    async query(sql, values) {
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
        }
        catch (error) {
            throw new Error(`Error en la consulta ${error}`);
        }
    }
}
const CONN = new DB();
exports.default = CONN;
