"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const dotenv_1 = __importDefault(require("dotenv"));
const facturaController_1 = __importDefault(require("./controller/facturaController"));
// configures dotenv to work in your application
dotenv_1.default.config();
const app = (0, express_1.default)();
app.use(express_1.default.json());
app.use(express_1.default.urlencoded({ extended: false }));
const PORT = process.env.PORT;
app.get("/", (request, response) => {
    response.status(200).send("Hello World");
});
app.get("/factura/all", facturaController_1.default.getAll);
app.get("/factura/:id", facturaController_1.default.getToId);
app.post("/factura/save", facturaController_1.default.create);
app.put("/factura/update", facturaController_1.default.update);
app.delete("/factura/delete/:id", facturaController_1.default.delete);
app.get("/factura/generate", facturaController_1.default.exportFile);
app
    .listen(PORT, () => {
    console.log("Server running at PORT: ", PORT);
})
    .on("error", (error) => {
    // gracefully handle error
    throw new Error(error.message);
});
