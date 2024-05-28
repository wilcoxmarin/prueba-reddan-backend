import { Response, Request } from "express";
import CONN from "../config/db";
import { ResultSetHeader } from "mysql2";
import Pdf from "../utils/pdf";
import Excel from "../utils/excel";

class FacturaController {
  async getAll(req: Request, res: Response) {
    try {
      const sql =
        'SELECT f.*, COUNT(fp.id_producto) AS "total_producto", CONCAT(c.nombre," ",c.apellido) AS "nombre_completo" FROM reddan.factura f JOIN reddan.factura_producto fp ON f.num_factura = fp.num_factura LEFT JOIN reddan.cliente c ON f.id_cliente = c.id_cliente GROUP BY f.num_factura;';
      const result: any = await CONN.query(sql);
      res
        .json({
          data: result,
        })
        .status(200);
    } catch (error) {
      throw new Error(
        "se presento un error al traer todas las facturas " + error,
      );
    }
  }

  async getToId(req: Request, res: Response) {
    try {
      const sql =
        'SELECT f.*, COUNT(fp.id_producto) AS "total_producto", CONCAT(c.nombre," ",c.apellido) AS "nombre_completo" FROM reddan.factura f JOIN reddan.factura_producto fp ON f.num_factura = fp.num_factura LEFT JOIN reddan.cliente c ON f.id_cliente = c.id_cliente WHERE f.num_factura = ? GROUP BY f.num_factura;';
      const { id } = req.params;
      const result = await CONN.query(sql, [id]);
      res
        .json({
          data: result,
        })
        .status(200);
    } catch (error) {
      throw new Error("se presento un error al traer la factura");
    }
  }

  async create(req: Request, res: Response) {
    try {
      const data = req.body;
      const { id_cliente, fecha, productos } = data;
      const sql = "INSERT INTO reddan.factura (id_cliente, fecha) VALUES(?,?);";
      const value = [id_cliente, fecha];
      let sql_pivot =
        "INSERT INTO reddan.factura_producto (num_factura, id_producto) VALUES";

      const result_fact: any = await CONN.query(sql, value);
      const value_pivot: any[] = [];

      productos.forEach((value: any, index: number) => {
        value_pivot.push(result_fact.insertId);
        value_pivot.push(value);
        if (index !== productos.length - 1) {
          sql_pivot += ` (?, ?),`;
        } else {
          sql_pivot += ` (?, ?)`;
        }
      });

      await CONN.query(sql_pivot, value_pivot);

      res
        .json({ data: { message: "SE creo correctamente la factura" } })
        .status(200);
    } catch (error) {
      res.status(500).json({ data: { message: "Ocurrio un problema" } });
      throw new Error("Error al insertart una factura");
    }
  }

  async update(req: Request, res: Response) {
    try {
      const data = req.body;
      const { num_factura, id_cliente, fecha, productos } = data;
      const sql =
        "UPDATE reddan.factura SET id_cliente=?, fecha=? WHERE num_factura=?;";
      const value = [num_factura, id_cliente, fecha];

      await CONN.query(sql, value);

      let sql_pivot: string = "";
      productos.forEach((value: any, index: number) => {
        sql_pivot += `UPDATE reddan.factura_producto SET id_producto = ${value} WHERE id_factura_producto =`;
      });
      ("UPDATE reddan.factura_producto SET num_factura=? , id_producto=? WHERE id_factura_producto=?;");
      const value_pivot = [];

      res
        .json({ data: { message: "La factura se actualizo correctamente" } })
        .status(200);
    } catch (error) {
      res.status(500).json({ data: { message: "Ocurrio un problema" } });
      throw new Error("Error al actualizar una factura");
    }
  }

  async delete(req: Request, res: Response) {
    try {
      const { id } = req.params;
      const sql_factura = "DELETE FROM reddan.factura WHERE num_factura=?;";
      const sql_factura_producto =
        "DELETE FROM reddan.factura_producto WHERE num_factura=?;";
      await CONN.query(sql_factura_producto, [id]);
      await CONN.query(sql_factura, [id]);
      res
        .json({ data: { message: "La factura se elimino correctamente" } })
        .status(200);
    } catch (error) {
      res.status(500).json({ data: { message: "Ocurrio un problema" } });
      throw new Error("Error al eliminar la factura");
    }
  }

  async exportFile(req: Request, res: Response) {
    try {
      const { type_document } = req.params;
      const sql =
        'SELECT f.*, COUNT(fp.id_producto) AS "total_producto", CONCAT(c.nombre," ",c.apellido) AS "nombre_completo" FROM reddan.factura f JOIN reddan.factura_producto fp ON f.num_factura = fp.num_factura LEFT JOIN reddan.cliente c ON f.id_cliente = c.id_cliente GROUP BY f.num_factura;';

      const result = await CONN.query(sql);

      if (type_document.toLowerCase() === "excel") {
        const excel = new Excel();
        return excel.generate(result, res);
      } else {
        const pdf = new Pdf();
        return pdf.generate(result, res);
      }
    } catch (error) {
      throw new Error("Error al exportar el archivo " + error);
    }
  }
}

const fc = new FacturaController();

export default fc;
