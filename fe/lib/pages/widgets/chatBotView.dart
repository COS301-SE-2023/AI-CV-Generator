import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:flutter/material.dart';

class ChatBotView extends StatefulWidget {
  @override
  ChatBotViewState createState() => ChatBotViewState();
}

class ChatBotViewState extends State<ChatBotView> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(right: 48, bottom: 48), 
        alignment: Alignment.bottomRight,
        child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade200,
            border: Border.all(color: Color(0xFF333C64))
          ),
          height: 500, width: 500, 
          child: Scaffold(
            drawer: const NavDrawer(),
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                ), 
                onPressed: () {
                  setState(() {});
                },
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: ListView(
                    padding: EdgeInsets.all(48),
                    children: [
                      Message(text: "hello", isSender: true),
                      Message(text: "hey there", isSender: false)
                    ],
                  ),
                ),
                Expanded(
                  child: TextField()
                )
              ],
            )
          ),
        ),
      );
  }
}

class Message extends StatelessWidget {
  String text;
  bool isSender;
  Message({super.key, required this.text, required this.isSender});

  BorderRadiusGeometry messageBorderRadiusGeometry() {
    if(isSender == true) {
      return BorderRadius.only(
        bottomRight: Radius.circular(20),
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
    );
    }
    return BorderRadius.only(
      bottomLeft: Radius.circular(20),
      topLeft: Radius.circular(20),
      topRight: Radius.circular(20),
    );
  }

  messageAlignment() {
    if(isSender == true) {
      return CrossAxisAlignment.start;
    }
    return CrossAxisAlignment.end;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: messageAlignment(),
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: messageBorderRadiusGeometry()
          ),
          child: Text(text),
        ),
        SizedBox(height: 8,)
      ],
    );
  }
}