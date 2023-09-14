const sharedData = require("../../runtime_data");

const initAdmin = (socket) => {
  socket.on("admin-init", () => {
    console.log(`Admin ${socket.id} connected`);
    sharedData.adminToUser.set(socket.id, new Set());
    sharedData.adminNum++;
  });
};

module.exports = { initAdmin };
