import express, { Request, Response } from "express";
import dotenv from "dotenv";
import fc from "./controller/facturaController";

const cors = require("cors");
// configures dotenv to work in your application
dotenv.config();
const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cors());

const PORT = process.env.PORT;

app.get("/", (request: Request, response: Response) => {
  response.status(200).send("Hello World");
});

app.get("/factura/all", fc.getAll);
app.get("/factura/:id", fc.getToId);
app.post("/factura/save", fc.create);
app.put("/factura/update", fc.update);
app.delete("/factura/delete/:id", fc.delete);
app.get("/factura/exportar/:type_document", fc.exportFile);

app
  .listen(PORT, () => {
    console.log("Server running at PORT: ", PORT);
  })
  .on("error", (error) => {
    // gracefully handle error
    throw new Error(error.message);
  });
