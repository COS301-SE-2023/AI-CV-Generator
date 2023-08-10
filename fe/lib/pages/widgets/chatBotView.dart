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
        borderRadius: BorderRadius.only(
            topLeft:Radius.circular(20), 
            topRight:Radius.circular(20), 
            bottomLeft:Radius.circular(20), 
          ),
          color: Colors.grey.shade200,
          border: Border.all(color: Color(0xFF333C64))
        ),
        height: 500, width: 500, 
        // color: Colors.black,
      ),
    );
  }
}