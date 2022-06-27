import 'package:flutter/material.dart';

class ChatBot extends StatelessWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("chatbot message"),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height * 0.9,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 70,
                margin: EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(),
                ),
                child: Row(
                  
                  children: [
                    Container(
                      child: Flexible(
                        flex: 0,
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.upload_file,
                              color: Theme.of(context).primaryColor,
                              size: 35,
                            )),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Write message",
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 0,
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.send,
                          color: Theme.of(context).primaryColor,
                          size: 35,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
