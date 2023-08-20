let io = require("../socket"); // Import your Socket.IO module

exports.ticketCheck = (req, res, next) => {
  const userSocketId = req.query.userSocketId;
  console.log(userSocketId);

  // Emit the event to the specific user socket using the centralized Socket.IO module
  io = io.getIO();
  io.to(userSocketId).emit("ticket-check-success", true);
  res.status(200).send("Event sent successfully.");
};
