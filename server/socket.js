let io;

module.exports = {
    init: httpServer => {
        io = require('socket.io')(httpServer);
        return io;
    },
    getIO: () => {
        if(!io){
            throw Error = new Error('Error!!');
        }
        return io;
    }
}