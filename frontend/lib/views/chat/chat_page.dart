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

class ChatPage extends StatelessWidget {
<<<<<<< HEAD
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PreviousChat>(context, listen: true);
    var loggedInUser =
        Provider.of<RegisterProvider>(context, listen: false).currentUser;
    final previousChat = provider.chatHistory;

    ScrollController _scrollController = ScrollController();
    String title = '';
    // print("prvies chat : " + previousChat);
    if (previousChat.length != 0) {
      title = provider.getUsername() != previousChat[0].reciever
          ? previousChat[0].reciever
          : previousChat[0].sender;
    }

=======
  //  ChatPage({Key? key}));
  @override
  Widget build(BuildContext context) {
    // dynamic previousChat = SocketService.getChatHistory();
    var previousChat =
        Provider.of<PreviousChat>(context, listen: true).chatHistory;
    ScrollController _scrollController = ScrollController();

>>>>>>> parent of c6d9ecc (chatbot added)
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
          icon: Icon(
            Icons.arrow_back,
          ),
<<<<<<< HEAD
          onPressed: () {
            Provider.of<PreviousChat>(context, listen: false).dispose();
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: Text(title == "" ? "message" : title),
        actions: [
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: () async {
              final res =
                  await HttpUtil().createRoom(isVideo ? 'video' : 'audio');
              final String room = res['room'];
              final String type = res['type'];

              print('callee: $loggedInUser["_id"]');
              print('room: $room');

              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => RTCVideo(
                    room: room,
                    callee: route["id"],
                    caller: loggedInUser["_id"],
                    isCaller: true,
                    type: type,
                  ),
                ),
              );
            },
          )
        ],
      ),
=======
          centerTitle: true,
          title: const Text("chat")),
>>>>>>> parent of c6d9ecc (chatbot added)
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // const UserListView(),
<<<<<<< HEAD
            previousChat.length == 0
                ? Expanded(
                    child: Center(
                      child: Text("welcome"),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                        controller: _scrollController,
                        itemCount: previousChat.length,
                        itemBuilder: (contex, index) {
                          bool isSendByUser = previousChat[index].sender ==
                              Provider.of<PreviousChat>(context, listen: false)
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
                                  const SizedBox(height: 4),
                                  // Text(
                                  //   f.format(DateTime.parse(chat.time ?? '')),
                                  //   style: const TextStyle(fontSize: 10),
                                  // )
                                  const SizedBox(height: 10),
                                ],
                              ),
=======
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                  itemCount: previousChat.length,
                  itemBuilder: (contex, index) {
                    bool isSendByUser = previousChat[index].sender ==
                        Provider.of<PreviousChat>(context, listen: false)
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
                                  fontSize: 13, fontWeight: FontWeight.bold),
>>>>>>> parent of c6d9ecc (chatbot added)
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

//     class _ChatBody extends StatelessWidget {
//   const _ChatBody({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var chats = <Chat>[];
//     ScrollController _scrollController = ScrollController();

//     ///scrolls to the bottom of page
//     void _scrollDown() {
//       try {
//         Future.delayed(
//             const Duration(milliseconds: 300),
//             () => _scrollController
//                 .jumpTo(_scrollController.position.maxScrollExtent));
//       } on Exception catch (_) {}
//     }

//     return Expanded(
//       child: StreamBuilder(
//         stream: SocketService.getResponse,
//         builder: (BuildContext context, AsyncSnapshot<Chat> snapshot) {
//           if (snapshot.connectionState == ConnectionState.none) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasData && snapshot.data != null) {
//             chats.add(snapshot.data!);
//             print(snapshot.data!.message);
//           }
//           _scrollDown();

//           return ListView.builder(
//             controller: _scrollController,
//             itemCount: chats.length,
//             itemBuilder: (BuildContext context, int index) =>
//                 MessageView(chat: chats[index]),
//           );
//         },
//       ),
//     );
//   }
// }
