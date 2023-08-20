const sharedData = require("../../runtime_data");
const { getRandomAdmin } = require("../util");

const initUser = (socket) => {
  socket.on("user-init", () => {
    console.log(`User ${socket.id} connected`);
    sharedData.userSockets.add(socket.id);
    if (sharedData.adminNum == 0) {
      console.log(`No admin in server, User ${socket.id} to waiting queue`);
      sharedData.waitingQueue.push(socket.id);
      return;
    }
    const adminSocketId = getRandomAdmin(
      Array.from(sharedData.adminToUser.keys())
    );
    sharedData.userToAdmin.set(socket.id, adminSocketId);
    sharedData.adminToUser.get(adminSocketId).add(socket.id);

    socket.to(adminSocketId).emit("admin-get-roomid", socket.id);
    socket.emit("get-admin-socket", adminSocketId);

    sharedData.userNum++;

    return adminSocketId;
  });
};
module.exports = { initUser };
