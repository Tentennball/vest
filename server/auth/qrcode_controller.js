const { userToAdmin } = require("../runtime_data");
const socket = require("../socket"); // Import your Socket.IO module

exports.ticketCheck = (req, res, next) => {
  const userSocketId = req.query.userSocketId;
  const adminSocketId = userToAdmin.get(userSocketId);
  console.log(userSocketId);

  // Use the io variable from your socket.js module
  const io = socket.getIO();

  io.to(userSocketId).emit("ticket-check-success", true);
  socket.to(adminSocketId).emit("admin-get-roomid", socket.id);

  res.status(200).send("Event sent successfully.");
};
