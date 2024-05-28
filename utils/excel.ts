import { Response } from "express";
const excelJs = require("exceljs");

export default class Excel {
  generate(content: any, res: Response) {
    const workBook = new excelJs.Workbook();
    const workSheet = workBook.addWorksheet("factura");

    workSheet.columns = [
      { header: "Cliente", key: "nombre_completo" },
      { header: "Numero Factura", key: "num_factura" },
      { header: "Fecha", key: "fecha" },
      { header: "Total Productos", key: "total_producto" },
    ];

    content.forEach((element: any) => {
      workSheet.addRow(element);
    });
    // Set up the response headers
    res.setHeader(
      "Content-Type",
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    );
    res.setHeader(
      "Content-Disposition",
      "attachment; filename=" + "users.xlsx",
    );

    // Write the workbook to the response object
    workBook.xlsx.write(res).then(() => res.end());
  }
}
