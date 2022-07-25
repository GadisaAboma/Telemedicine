import 'package:flutter/cupertino.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

import '../model/chat.dart';

class PreviousChat extends ChangeNotifier {
  List<Chat> _chatHistory = [];
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
  }

  void addToChatHistory(dynamic message) {
    _chatHistory.add(Chat.fromRawJson(message));
    notifyListeners();
  }

  void connectAndListen(String username) {
    print(username);

    _socket = io.io(
        "http://127.0.0.1:8080",
        // "http://192.168.1.44:8080",
        io.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect()
            .setQuery({'userName': username})
            .build());

    _socket.connect();
    _socket.emit("connected", username);

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
    _socket.close();
    _socket.disconnect();
    _socket;
    notifyListeners();
  }
}
