import 'dart:convert';


import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import '../utils/helpers.dart';
import 'package:http/http.dart' as http;

class ChatBot extends StatefulWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  List<String> _data = [];
  TextEditingController queryController = TextEditingController();
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  void getResponse() {
    if (queryController.text.isNotEmpty) {
      insertSingleItem(queryController.text);

      var client = getClient();
      var newUrl = Uri.parse(chatbotUrl);

      try {
        client.post(newUrl, body: {"query": queryController.text}, ).then(
            (response) {
          print(response.body);
          Map<String, dynamic> data = jsonDecode(response.body);
          insertSingleItem(data['response'] + "<bot>");
        });
      } finally {
        client.close();
        queryController.clear();
      }
    }
  }

  void insertSingleItem(String message) {
    _data.add(message);
    _listKey.currentState!.insertItem(_data.length - 1);
  }

  http.Client getClient() {
    return http.Client();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("chatbot message"),
      ),
      body: Container(
        child: Stack(
          children: [
            AnimatedList(
              key: _listKey,
              initialItemCount: _data.length,
              itemBuilder:
                  (BuildContext ctx, int index, Animation<double> animation) {
                return buildItem(_data[index], animation, index);
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ColorFiltered(
                colorFilter: const ColorFilter.linearToSrgbGamma(),
                child: Container(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextField(
                      style: const TextStyle(color: Colors.black),
                      decoration: const InputDecoration(
                          icon: Icon(
                            Icons.message,
                            color: Colors.blue,
                          ),
                          hintText: 'Type Message',
                          fillColor: Colors.white12),
                      controller: queryController,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (msg) {
                        getResponse();
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildItem(String item, Animation<double> animation, int index) {
  bool mine = item.endsWith('<bot>');
  return SizeTransition(
    sizeFactor: animation,
    child: Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        alignment: mine ? Alignment.topLeft : Alignment.topRight,
        child: Bubble(
          color: mine ? Colors.blue : Colors.black,
          padding: const BubbleEdges.all(10),
          child: Text(
            item.replaceAll("<bot>", ""),
            style: const TextStyle(color :Colors.white),
          ),
        ),
      ),
    ),
  );
}
