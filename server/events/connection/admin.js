const sharedData = require("../../runtime_data");

const initAdmin = (socket) => {
  socket.on("admin-init", () => {
    console.log(`Admin ${socket.id} connected`);
    sharedData.adminToUser.set(socket.id, new Set());
    sharedData.adminNum++;

    if (sharedData.waitingQueue.length !== 0) {
      sharedData.waitingQueue.forEach((userSocketId) => {
        sharedData.adminToUser.get(socket.id).add(socket.id);
        sharedData.userToAdmin.set(userSocketId, socket.id);

        console.log(
          `User : ${userSocketId} to Admin : ${socket.id} from Waiting Queue`
        );
        socket.emit("admin-get-roomid", userSocketId);
        socket.to(userSocketId).emit("get-admin-socket", socket.id);
      });

      // Reset Waiting Queue
      sharedData.waitingQueue = [];
    }
  });
};

module.exports = { initAdmin };
