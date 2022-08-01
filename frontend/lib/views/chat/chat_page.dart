import 'package:flutter/material.dart';
import 'package:frontend/provider/register.dart';
import 'package:frontend/register/register.dart';
import 'package:provider/provider.dart';

import '../../model/chat.dart';
import '../../video_call/utils/http_util.dart';
import '../../video_call/rtc/rtc_media_screen.dart';
import '../../provider/message.dart';
import 'message_view.dart';
import 'chat_text_input.dart';
import 'user_list_view.dart';

class ChatPage extends StatefulWidget {
  ChatPage({Key? key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PreviousChat>(context, listen: true);
    var loggedInUser =
        Provider.of<RegisterProvider>(context, listen: false).currentUser;
    final previousChat = provider.chatHistory;
    ScrollController _scrollController = ScrollController();
    String title = "messaging";
    // print("prievs chat  " + previousChat);
    // if (previousChat != null) {
    //   title = provider.getUsername() != previousChat[0].reciever
    //       ? previousChat[0].reciever
    //       : previousChat[0].sender;
    // }

    void _scrollDown() {
      try {
        Future.delayed(
            const Duration(milliseconds: 300),
            () => _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent));
      } on Exception catch (_) {}
    }

    dynamic route = ModalRoute.of(context)!.settings.arguments;
    var size = MediaQuery.of(context).size;
    bool isVideo = true;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Provider.of<PreviousChat>(context, listen: false).dispose();
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
            ),
          ),
          centerTitle: true,
          title: Text(title)),
      body: previousChat == null
          ? Container(child: Center(child: Text("welcome ")))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const UserListView(),
                    Expanded(
                      child: ListView.builder(
                          controller: _scrollController,
                          itemCount: previousChat.length,
                          itemBuilder: (contex, index) {
                            bool isSendByUser = previousChat[index].sender ==
                                Provider.of<PreviousChat>(context,
                                        listen: false)
                                    .getUsername();
                            _scrollDown();
                            return Align(
                              alignment: isSendByUser
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                margin: const EdgeInsets.fromLTRB(8, 4, 8, 0),
                                child: Column(
                                  crossAxisAlignment: isSendByUser
                                      ? CrossAxisAlignment.end
                                      : CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (previousChat[index].sender ?? ''),
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                        padding: const EdgeInsets.all(8),
                                        constraints: BoxConstraints(
                                          maxWidth: size.width * 0.5,
                                          minWidth: size.width * 0.01,
                                        ),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: isSendByUser
                                                ? Colors.blue
                                                : Colors.grey.shade500),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            if (!isSendByUser)
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(right: 8),
                                                child: CircleAvatar(
                                                  child: Icon(Icons.person,
                                                      size: 10),
                                                  radius: 8,
                                                ),
                                              ),
                                            Flexible(
                                              child: Text(
                                                previousChat[index].message ??
                                                    'none',
                                                style: const TextStyle(
                                                    color: Colors.white),
                                                softWrap: true,
                                              ),
                                            ),
                                          ],
                                        )),
                                    // const SizedBox(height: 4),
                                    // Text(
                                    //   f.format(DateTime.parse(chat.time ?? '')),
                                    //   style: const TextStyle(fontSize: 10),
                                    // )
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                    SizedBox(height: 6),

                    ChatTextInput(),
                  ])),
    );
  }
}


