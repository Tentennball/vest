const sharedData = require("../../runtime_data");

const sos = (socket) => {
  socket.on("sos", (userSocketId) => {
    console.log(`${userSocketId} sends SOS Call`);
    const adminSocketId = sharedData.userToAdmin.get(userSocketId);
    socket.to(adminSocketId).emit("admin-get-sos", userSocketId);
  });
};

module.exports = { sos };
