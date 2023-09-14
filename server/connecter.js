const { initAdmin } = require("./events/connection/admin");
const { processChat } = require("./events/function/chat");
const { initUser } = require("./events/connection/user");
const { disconnect } = require("./events/connection/disconnect");
const { sos } = require("./events/function/sos");
const { ticketCheck } = require("./events/connection/auth");

const Socket = (io) => {
  io.on("connection", (socket) => {
    console.log(`A socket connected ${socket.id}`);
    initAdmin(socket);
    initUser(socket);
    processChat(socket);
    disconnect(socket);
    sos(socket);
    // ticketCheck(socket);
  });
};
module.exports = { Socket };
