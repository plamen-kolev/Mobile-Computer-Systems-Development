var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);

var clients = {};

app.get('/', function(req, res){
    res.send('Node Express Server');
});

io.on('connection', function (socket) {

    socket.on('join', function (data) {
      clients[data.email] = socket.id;
      socket.join(data.room);
      console.log("user " + data.email + " joined room " + data.room)
    });

    socket.on('chat', function(data){
      console.log("Will be emitting to client " + data.recipient + " with id " + clients[data.recipient] + " from user " + data.sender + " with id " + clients[data.sender] + " message: " + data.body);

      var msg_obj = {'sender': data.sender, 'recipient': data.recipient,'body': data.body, 'date': new Date() };

      io.to(clients[data.recipient]).emit('chat', msg_obj);
      io.to(socket.id).emit('chat', msg_obj);
    });

    socket.on('disconnect', function () {
        console.log("client disconnected");
    });
});

http.listen(4201, function(){
    console.log('listening on *:4201');
});
