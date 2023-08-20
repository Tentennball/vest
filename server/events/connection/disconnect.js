const sharedData = require("../../runtime_data");
/**
 * actions are different whether exited user is admin or normal user
 */
const disconnect = (socket) => {
  socket.on("disconnect", () => {
    let isAdmin = null;
    let disconnectId = null;
    if (sharedData.adminToUser.has(socket.id)) {
      disconnectId = socket.id;
      isAdmin = true;
    }
    if (sharedData.userToAdmin.has(socket.id)) {
      disconnectId = socket.id;
      isAdmin = false;
    }

    console.log(`${isAdmin ? "Admin" : "User"} disconnected: ${socket.id}`);
    /**
     * Delete exited admin's socket, decrease adminNum
     * If there's no admin, users go waiting queue
     *
     * Push users of exited admin to another admin (replaceAdmin)
     */
    if (isAdmin) {
      sharedData.adminNum--;

      // There is no admin in server
      if (sharedData.adminNum === 0) {
        sharedData.adminToUser.get(disconnectId).forEach((user) => {
          sharedData.waitingQueue.push(user);
        });
        return;
      }

      // There is at least one admin
      sharedData.adminToUser.get(disconnectId).forEach((user) => {
        const adminSocketId = getRandomAdmin(
          Array.from(sharedData.adminToUser.keys())
        );
        sharedData.userToAdmin.set(user.id, adminSocketId);
        sharedData.adminToUser.get(adminSocketId).add(user.id);

        console.log(
          `User ${user.id} goes to Admin ${adminSocketId} from Admin ${disconnectId}`
        );
        socket.to(user.id).emit("get-admin-socket", adminSocketId);
      });
    } else {
      /**
       * Delete exited user's socket, decrease userNum
       * Delete admin who manages exited user
       */
      if (sharedData.userToAdmin.has(disconnectId)) {
        const adminSocketId = sharedData.userToAdmin.get(disconnectId);
        sharedData.adminToUser.get(adminSocketId).delete(disconnectId);
      }

      sharedData.userNum--;
      sharedData.userToAdmin.set(disconnectId, null);
      sharedData.userSockets.delete(disconnectId);
    }
  });
};

module.exports = { disconnect };
