let ioInstance; // Use a different variable name

module.exports = {
  init: (httpServer) => {
    ioInstance = require("socket.io")(httpServer); // Initialize ioInstance
    return ioInstance;
  },
  getIO: () => {
    if (!ioInstance) {
      throw new Error("Error!!");
    }
    return ioInstance;
  },
};
