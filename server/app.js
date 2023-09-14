const express = require("express");

const app = express();
const connecter = require("./connecter");

const authRoutes = require("./auth/qrcode_route");

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(authRoutes);

const server = app.listen(8080);
const io = require("./socket").init(server);
connecter.Socket(io);
