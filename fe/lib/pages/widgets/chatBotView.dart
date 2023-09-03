import 'package:ai_cv_generator/pages/widgets/AILoadingScreen.dart';
import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:flutter/material.dart';
import 'package:ai_cv_generator/pages/util/chatBot.dart';

class ChatBotView extends StatefulWidget {
  bool visible;
  ChatBotView({super.key, required this.visible});
  @override
  ChatBotViewState createState() => ChatBotViewState();
}

class ChatBotViewState extends State<ChatBotView> {
  List<Widget> messages = [];
  TextEditingController controller = TextEditingController();
  Chatbot chatBot = Chatbot();
  void addMesssage(String text, bool isSender) async {
    messages.add(Message(text: text, isSender: isSender));
    setState(() {});
    if (isSender) {
      String message = await chatBot.message(userMsg: text);
      addMesssage(message.trim(), false);
    }
    setState(() {});
  }

  @override
  void initState() {
    chatBot.greeting().then((value) {
      addMesssage(value, false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.visible,
      child: Container(
        padding: const EdgeInsets.only(right: 48, bottom: 48), 
        alignment: Alignment.bottomRight,
        child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: Colors.grey.shade300
          ),
          color: Colors.grey.shade100
          ),
          height: 500, width: 500, 
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Scaffold(
              drawer: const NavDrawer(),
              appBar: AppBar(
                title: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(right: 50),
                  child:Text("AI CHAT BOT", style: Theme.of(context).appBarTheme.toolbarTextStyle,),),
                  leading: IconButton(
                    icon: const Icon(
                      Icons.close,
                  ), 
                  onPressed: () {
                    setState(() {widget.visible = false;});
                  },
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100
                      ),
                      child: ListView(
                      padding: const EdgeInsets.all(48),
                      children: [
                        ...messages
                      ],
                      ),
                    )
                  ),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onSubmitted: (value) {
                        addMesssage(value, true);
                        controller.text = "";
                      },
                      decoration: const InputDecoration(
                        fillColor: Colors.white,
                        hintText: "Type a message",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(19), bottomRight: Radius.circular(19)),
                          borderSide:
                          BorderSide(color: Colors.black)
                        )
                      ),
                    )
                  )
                ],
              )
            ),
            ),
        ),
      )
    );

  }
}

class Message extends StatelessWidget {
  String text;
  bool isSender;
  Message({super.key, required this.text, required this.isSender});

  BorderRadiusGeometry messageBorderRadiusGeometry() {
    if(isSender == true) {
      return const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      );
    }
    return const BorderRadius.only(
        bottomRight: Radius.circular(20),
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      );
  }

  messageAlignment() {
    if(isSender == true) {
      return CrossAxisAlignment.end;
    }
    return CrossAxisAlignment.start;
  }

  Color messageColour(BuildContext context) {
    if(isSender == true) {
      return Theme.of(context).colorScheme.primary.withOpacity(0.3);
    }
    return Theme.of(context).colorScheme.surface;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: messageAlignment(),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          constraints: const BoxConstraints(
            minHeight: 60,
            maxWidth: 150
          ),
          decoration: BoxDecoration(
            color: messageColour(context),
            borderRadius: messageBorderRadiusGeometry(),
          ),
          child: Text(text),
        ),
        const SizedBox(height: 8,)
      ],
    );
  }
}