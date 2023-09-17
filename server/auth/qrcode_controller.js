const { userToAdmin } = require("../runtime_data");
const socket = require("../socket"); // Import your Socket.IO module

exports.ticketCheck = (req, res, next) => {
  const userSocketId = req.query.userSocketId;
  const adminSocketId = userToAdmin.get(userSocketId);
  console.log(`ticketCheck : ${userSocketId} ${adminSocketId}`);

  // Use the io variable from your socket.js module
  const io = socket.getIO();

  io.to(userSocketId).emit("ticket-check-success", true);
  io.to(adminSocketId).emit("admin-get-roomid", userSocketId);

  res.status(200).send("Event sent successfully.");
};
