const processChat = (socket) => {
  socket.on("request-chat", (data) => {
    console.log(JSON.stringify(data));

    socket.to(data.rx).emit("scroll-event");
    socket.to(data.rx).emit("response-chat", JSON.stringify(data));
  });
};
module.exports = { processChat };
