import 'package:flutter/cupertino.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

import '../model/chat.dart';

class PreviousChat extends ChangeNotifier {
  List<Chat> _chatHistory = [];
  List<String> contacts = [];
  late io.Socket _socket;
  get chatHistory {
    return _chatHistory;
  }

  String _userName = '';
  String _reciever = '';
  String _sender = '';

  void setUserName(String name) {
    _userName = name;
  }

  String getUsername() {
    return _userName;
  }

  void setSender(String sender) {
    _sender = sender;
    setUserName(_sender);
  }

  void setReciever(String reciever) {
    _reciever = reciever;
  }

  void sendMessage(String message) {
    _socket.emit("send_message",
        {"reciever": _reciever, "message": message, "sender": _sender});
    addToChatHistory(
        {"reciever": _reciever, "message": message, "sender": _sender});
    notifyListeners();
  }

  void addToChatHistory(dynamic message) {
    _chatHistory.add(Chat.fromRawJson(message));
    notifyListeners();
  }

  void connectAndListen(String username) {
    print(username);

    _socket = io.io(
        "http://192.168.19.236:8080",
        io.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect()
            .setQuery({'userName': username})
            .build());

    _socket.connect();
    _socket.on("message", (data) {
      print(data.toString());
    });

    _socket.on("new_message", (data) {
      if (((_reciever == data["reciever"]) || (_reciever == data["sender"])) &&
          ((_sender == data["reciever"]) || (_sender == data["sender"]))) {
        addToChatHistory(data);
      }
    });

    //when users are connected or disconnected
    // _socket.on('users', (data) {
    //   var users = (data as List<dynamic>).map((e) => e.toString()).toList();
    //   _userResponse.sink.add(users);
    // });

    _socket.onDisconnect((_) => {print('disconnect')});
  }

  void dispose() {
    _chatHistory = [];
    _socket.dispose();
    _socket.destroy();
    _socket.query = null;
    _socket.close();
    _socket.disconnect();

    notifyListeners();
  }
}
