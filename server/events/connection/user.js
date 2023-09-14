const sharedData = require("../../runtime_data");
const { getRandomAdmin } = require("../util");

const initUser = (socket) => {
  socket.on("user-init", () => {
    console.log(`User ${socket.id} connected`);
    sharedData.userSockets.add(socket.id);

    const adminSocketId = getRandomAdmin(
      Array.from(sharedData.adminToUser.keys())
    );

    console.log(adminSocketId, socket.id);
    sharedData.userToAdmin.set(socket.id, adminSocketId);
    console.log(adminSocketId);
    sharedData.adminToUser.get(adminSocketId).add(socket.id);

    // 수정
    socket.emit("get-admin-socket", adminSocketId);

    sharedData.userNum++;

    return socket.id;
  });
};
module.exports = { initUser };
