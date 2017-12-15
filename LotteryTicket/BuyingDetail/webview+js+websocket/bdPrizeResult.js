
const URL_WebSocket = "http://push.pushsystem.serverddc.com";

const socket = io.connect(URL_WebSocket);
const lotteries = "cqssc";
//const lotteries = "ffcSsc60";
socket.on('connect', function() {
      console.log('websocket connected');
      socket.emit('alias', { alias: lotteries });
 }).on('reconnect', function() {
       socket.emit('fetch_lottery_result', {alias: lotteries});
 }).on(lotteries, function (data) {
       console.log('websocket received');
       console.log(new Date().toLocaleString(), socket.id, lotteries, data);
       //alert(data + " | " + data.message + " | " + data.data[0].result);
       iosFunc_WebsocketReceived(data);
 });

function jsWebsocketConnect() {
    socket.connect();
    return "websocket connect invoked";
}

function jsWebsocketDisconnect() {
    socket.disconnect();
}
