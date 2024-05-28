"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const moment = require("moment");
const pdf = require("pdfkit");
class Pdf {
    generate(content, res) {
        try {
            const stream = res.writeHead(200, {
                "content-type": "application/pdf",
                "content-disposition": "attachment;filename=doc.pdf",
            });
            // Call the function to build the PDF, providing
            // callbacks for data and end events
            buildPdf((chunk) => stream.write(chunk), () => stream.end());
            // Function to build the PDF
            function buildPdf(dataCallback, endCallback) {
                const tableTop = 120;
                const doc = new pdf();
                doc.on("data", dataCallback);
                doc.on("end", endCallback);
                doc.fontSize(30).text("Factura");
                generateHr(doc, tableTop);
                generateTableRow(doc, tableTop + 80, "Cliente", "Numero Factura", "Fecha", "Numero de productos");
                generateHr(doc, tableTop + 95);
                for (let i = 0; i < content.length; i++) {
                    const element = content[i];
                    const position = tableTop + 75 + (i + 1) * 30;
                    generateTableRow(doc, position, element.nombre_completo, element.num_factura, moment(element.fecha).format("YYYY-MM-DD"), element.total_producto);
                    generateHr(doc, position + 20);
                }
                doc.end();
            }
            function generateHr(doc, y) {
                doc
                    .strokeColor("#aaaaaa")
                    .lineWidth(1)
                    .moveTo(50, y)
                    .lineTo(550, y)
                    .stroke();
            }
            function generateTableRow(doc, y, c1, c2, c3, c4) {
                doc
                    .fontSize(10)
                    .text(c1, 50, y)
                    .text(c2, 150, y, { width: 100, align: "center" })
                    .text(c3, 280, y, { width: 100, align: "center" })
                    .text(c4, 370, y, { width: 150, align: "center" });
            }
        }
        catch (e) {
            throw new Error("Error al generar pdf" + e);
        }
    }
}
exports.default = Pdf;
