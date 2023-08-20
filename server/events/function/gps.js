const gps = () => {
  socket.on("gps", (data) => {
    console.log(clnt);
  });
};

module.exports = { gps };
