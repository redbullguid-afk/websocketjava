const WebSocket = require('ws');
const net = require('net');

const PORT = process.env.PORT || 8080;
const wss = new WebSocket.Server({ port: PORT });

console.log(`Proxy đang chạy tại port ${PORT}`);

wss.on('connection', (ws, req) => {
  // Lấy IP và Port của Game Server thật từ đường dẫn (Ví dụ: wss://app.com/?target=123.45.67.89:5000)
  const urlParams = new URLSearchParams(req.url.split('?')[1]);
  const target = urlParams.get('target');

  if (!target) {
    ws.close();
    return;
  }

  const [host, port] = target.split(':');

  // Mở kết nối TCP tới Game Server thật
  const tcpClient = net.createConnection({ host, port: parseInt(port) }, () => {
    console.log(`Đã nối tới Server Game: ${host}:${port}`);
  });

  // Chuyển tiếp dữ liệu từ Web -> TCP Game
  ws.on('message', (data) => tcpClient.write(data));

  // Chuyển tiếp dữ liệu từ TCP Game -> Web
  tcpClient.on('data', (data) => ws.send(data));

  // Xử lý ngắt kết nối
  ws.on('close', () => tcpClient.end());
  tcpClient.on('close', () => ws.close());
  tcpClient.on('error', () => ws.close());
});