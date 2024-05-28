"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const db_1 = __importDefault(require("../config/db"));
const excel_1 = __importDefault(require("../utils/excel"));
class FacturaController {
    async getAll(req, res) {
        try {
            const sql = 'SELECT f.*, COUNT(fp.id_producto) AS "total_producto", CONCAT(c.nombre," ",c.apellido) AS "nombre_completo" FROM reddan.factura f JOIN reddan.factura_producto fp ON f.num_factura = fp.num_factura LEFT JOIN reddan.cliente c ON f.id_cliente = c.id_cliente GROUP BY f.num_factura;';
            const result = await db_1.default.query(sql);
            res
                .json({
                data: result,
            })
                .status(200);
        }
        catch (error) {
            throw new Error("se presento un error al traer todas las facturas " + error);
        }
    }
    async getToId(req, res) {
        try {
            const sql = 'SELECT f.*, COUNT(fp.id_producto) AS "total_producto", CONCAT(c.nombre," ",c.apellido) AS "nombre_completo" FROM reddan.factura f JOIN reddan.factura_producto fp ON f.num_factura = fp.num_factura LEFT JOIN reddan.cliente c ON f.id_cliente = c.id_cliente WHERE f.num_factura = ? GROUP BY f.num_factura;';
            const { id } = req.params;
            const result = await db_1.default.query(sql, [id]);
            res
                .json({
                data: result,
            })
                .status(200);
        }
        catch (error) {
            throw new Error("se presento un error al traer la factura");
        }
    }
    async create(req, res) {
        try {
            const data = req.body;
            const { id_cliente, fecha, productos } = data;
            const sql = "INSERT INTO reddan.factura (id_cliente, fecha) VALUES(?,?);";
            const value = [id_cliente, fecha];
            let sql_pivot = "INSERT INTO reddan.factura_producto (num_factura, id_producto) VALUES";
            const result_fact = await db_1.default.query(sql, value);
            const value_pivot = [];
            productos.forEach((value, index) => {
                value_pivot.push(result_fact.insertId);
                value_pivot.push(value);
                if (index !== productos.length - 1) {
                    sql_pivot += ` (?, ?),`;
                }
                else {
                    sql_pivot += ` (?, ?)`;
                }
            });
            await db_1.default.query(sql_pivot, value_pivot);
            res
                .json({ data: { message: "SE creo correctamente la factura" } })
                .status(200);
        }
        catch (error) {
            res.status(500).json({ data: { message: "Ocurrio un problema" } });
            throw new Error("Error al insertart una factura");
        }
    }
    async update(req, res) {
        try {
            const data = req.body;
            const { num_factura, id_cliente, fecha, productos } = data;
            const sql = "UPDATE reddan.factura SET id_cliente=?, fecha=? WHERE num_factura=?;";
            const value = [num_factura, id_cliente, fecha];
            await db_1.default.query(sql, value);
            let sql_pivot = "";
            productos.forEach((value, index) => {
                sql_pivot += `UPDATE reddan.factura_producto SET id_producto = ${value} WHERE id_factura_producto =`;
            });
            ("UPDATE reddan.factura_producto SET num_factura=? , id_producto=? WHERE id_factura_producto=?;");
            const value_pivot = [];
            res
                .json({ data: { message: "La factura se actualizo correctamente" } })
                .status(200);
        }
        catch (error) {
            res.status(500).json({ data: { message: "Ocurrio un problema" } });
            throw new Error("Error al actualizar una factura");
        }
    }
    async delete(req, res) {
        try {
            const { id } = req.params;
            const sql_factura = "DELETE FROM reddan.factura WHERE num_factura=?;";
            const sql_factura_producto = "DELETE FROM reddan.factura_producto WHERE num_factura=?;";
            await db_1.default.query(sql_factura_producto, [id]);
            await db_1.default.query(sql_factura, [id]);
            res
                .json({ data: { message: "La factura se elimino correctamente" } })
                .status(200);
        }
        catch (error) {
            res.status(500).json({ data: { message: "Ocurrio un problema" } });
            throw new Error("Error al eliminar la factura");
        }
    }
    async exportFile(req, res) {
        try {
            const { id } = req.body;
            const sql = 'SELECT f.*, COUNT(fp.id_producto) AS "total_producto", CONCAT(c.nombre," ",c.apellido) AS "nombre_completo" FROM reddan.factura f JOIN reddan.factura_producto fp ON f.num_factura = fp.num_factura LEFT JOIN reddan.cliente c ON f.id_cliente = c.id_cliente GROUP BY f.num_factura;';
            const value = [id];
            const result = await db_1.default.query(sql, value);
            const excel = new excel_1.default();
            return excel.generate(result, res);
            // const pdf = new Pdf();
            // return pdf.generate(result, res);
        }
        catch (error) {
            throw new Error("Error al exportar el archivo " + error);
        }
    }
}
const fc = new FacturaController();
exports.default = fc;
