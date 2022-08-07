import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/cupertino.dart';

import 'package:socket_io_client/socket_io_client.dart' as io;

import '../model/chat.dart';
import '../utils/helpers.dart';
import '../video chat/rtc/client_io.dart';
import '../video chat/rtc/contact_event.dart';

class PreviousChat extends ChangeNotifier {
  List<Chat> _chatHistory = [];
  late io.Socket _socket;

  late StreamSubscription<ContactEvent> _sub;
  List<String> contacts = [];
  dynamic currentContact;

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

  Future<void> contactedDoctor(String username) async {
    try {
      final response = await http
          .get(Uri.parse("$serverUrl/patients/doctorsList"), headers: {
        "Content-type": "application/json",
        "Accept": "application/json",
      });
      final data = json.decode(response.body);
      print(data["_docs"]);
    } catch (e) {}
  }

  void initVideo(BuildContext ctx, String id, String username) {
    ClientIO().init(id, username);

    ClientIO().rootContext = ctx;

    _sub = ClientIO().watchMain().listen((event) {
      print('listen contact event');

      final contact = event.username + ':' + event.userid;

      if (event.online) {
        if (contacts.contains(contact)) return;

        contacts.add(contact);
        notifyListeners();
      } else {
        if (contacts.remove(contact)) notifyListeners();
      }
    });
  }

  void connectAndListen(String username) {
    print(username);

    _socket = io.io(
        "http://192.168.1.106:8080",
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
