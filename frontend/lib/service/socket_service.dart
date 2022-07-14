import 'dart:async';
import 'dart:convert';

import 'package:socket_io_client/socket_io_client.dart' as io;

import '../model/chat.dart';

class SocketService {
  static late StreamController<Chat> _socketResponse;
  static late StreamController<List<String>> _userResponse;
  static late io.Socket _socket;
  static String _userName = '';
  static String _reciever = '';
  static String _sender = '';

  static String? get userId => _socket.id;

  static Stream<Chat> get getResponse =>
      _socketResponse.stream.asBroadcastStream();
  static Stream<List<String>> get userResponse =>
      _userResponse.stream.asBroadcastStream();

  static get serverUrl => null;

  static void setUserName(String name) {
    _userName = name;
  }

  static String getUsername() {
    return _userName;
  }

  static void setReciever(String reciever) {
    _reciever = reciever;
  }

  static void setSender(String sender) {
    _sender = sender;
    setUserName(_sender);
  }

  static void sendMessage(String message) {
    // _socket.emit('message',
    // Chat(message: "helloo", reciever: "hkkk", sender: "lhlshflhdslf"));

    _socket.emit("send_message",
        {"reciever": _reciever, "message": message, "sender": _sender});
  }

  static void connectAndListen(String username) {
    _socketResponse = StreamController<Chat>();
    _userResponse = StreamController<List<String>>();
    _socket = io.io(
        "http://127.0.0.1:8080",
        io.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect()
            .setQuery({'userName': username})
            .build());

    _socket.connect();

    //When an event recieved from server, data is added to the stream
    // _socket.on('message', (data) {
    //   // if(_reciever == data['reciever']){
    //   // _socketResponse.sink.add(Chat.fromRawJson(data));
    //   // }
    //   print("data" + data.toString());
    // });

    /// send message to specific user

    _socket.on("new_message", (data) {
      // print(data);
      // print(jsonDecode(data)["reciever"]);
      // print(_reciever + " rec " + _reciever == data["reciever"]);
      if (((_reciever == data["reciever"]) || (_reciever == data["sender"])) &&
          ((_sender == data["reciever"]) || (_sender == data["sender"]))) {
        _socketResponse.sink.add(Chat.fromRawJson(data));
      }
    });

    //when users are connected or disconnected
    _socket.on('users', (data) {
      var users = (data as List<dynamic>).map((e) => e.toString()).toList();
      _userResponse.sink.add(users);
    });

    // _socket.onDisconnect((_) => print('disconnect'));
  }

  static void dispose() {
    _socket.dispose();
    _socket.destroy();
    _socket.close();
    _socket.disconnect();
    _socketResponse.close();
    _userResponse.close();
    
  }
}
