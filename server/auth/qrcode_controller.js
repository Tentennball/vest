const { Socket } = require("socket.io");
const { userSockets } = require("../runtime_data");

exports.ticketCheck = (req, res, next) => {
  const userSocketId = req.query.userSocketId;
  console.log(userSocketId);

  if (userSockets.has(userSocketId)) {
    // Emit the "ticket-check" event to the specific socket
    io.to(userSocketId).emit("ticket-check-success", {
      isSuccessful: true,
    });

    res.status(200).send("Event sent successfully.");
  } else {
    res.status(400).send("User socket not found.");
  }
};
