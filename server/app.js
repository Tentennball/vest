const express = require("express");

const app = express();
const connecter = require("./connecter");

const authRoutes = require("./auth/qrcode_route");

app.use("/", (req, res, next) => {
  res.set({
    "ngrok-skip-broser-warning": "69420",
  });
  next();
});

// app.use("/", (req, res, next) => {
//   console.log("hello");
//   next();
// });

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use(authRoutes);

const server = app.listen(9000);
const io = require("./socket").init(server);
connecter.Socket(io);
