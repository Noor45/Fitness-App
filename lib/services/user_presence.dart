import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:t_fit/controllers/auth_controller.dart';

class UserPresence {
  IO.Socket socket;
  final String serverUrl = 'https://t-fit-online-offline.herokuapp.com/';
  void connectToServer() {
    try {
      socket = IO.io(serverUrl, <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      });
      socket.connect();
      socket.on('connect', (_) {
        print('connect');
        socket.send([
          {
            'socket_id': '${socket.id}',
            'user_id': AuthController.currentUser.uid,
          }
        ]);
      });
    } catch (e) {
      print(e.toString());
    }
  }
}

