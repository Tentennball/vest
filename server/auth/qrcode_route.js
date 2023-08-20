const express = require("express");
const router = express.Router();

const ticketController = require("./qrcode_controller");

router.get("/ticket-check/", ticketController.ticketCheck);

module.exports = router;
