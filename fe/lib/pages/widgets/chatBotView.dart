import 'package:ai_cv_generator/dio/client/fileApi.dart';
import 'package:ai_cv_generator/pages/widgets/loadingscreens/JumpingDotsLoadingScreen.dart';
import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:flutter/material.dart';
import 'package:ai_cv_generator/pages/util/chatBot.dart';

class ChatBotView extends StatefulWidget {
  const ChatBotView({super.key});
  @override
  ChatBotViewState createState() => ChatBotViewState();
}

class ChatBotViewState extends State<ChatBotView> {
  Image? userImage;
  bool visible = false;
  List<Widget> messages = [];
  TextEditingController controller = TextEditingController();
  Chatbot chatBot = Chatbot();
  void addMesssage(String text, bool isSender) async {
    messages.add(addImage(Message(message: Text(text), isSender: isSender), userImage!, isSender));
    setState(() {});
    if (isSender) {
      messages.add(Message(
        message: const JumpingDotsLoadingScreen(),
        isSender: !isSender
      ));
      String message = await chatBot.message(userMsg: text);
      messages.last = addImage(Message(message: Text(message), isSender: !isSender), userImage!, !isSender);
    }
    setState(() {});
  }

  @override
  void initState() {
    FileApi.getProfileImage().then((value) {
      userImage = value;
    });
    chatBot.greeting().then((value) {
      addMesssage(value, false);
    });
    super.initState();
  }

  Widget addImage(Widget widget, Image image, bool isSender)
  {
    if(isSender == true)
    {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: SizedBox(),
          ),
          Expanded(
            flex: 4,
            child: widget,
          ),
          Expanded(
            child: CircleAvatar(
              backgroundImage: image.image,
            ),
          )
        ],
      );
    }
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
          Expanded(
            child: CircleAvatar(
              backgroundColor: Colors.grey,
            ),
          ),
          Expanded(
            flex: 4,
            child: widget,
          ),
          Expanded(
            child: SizedBox(),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        padding: const EdgeInsets.only(right: 48, bottom: 48), 
        alignment: Alignment.bottomRight,
        child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
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
                    setState(() {visible = false;});
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
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                      children: [
                        ...messages
                      ],
                      ),
                    )
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Theme.of(context).colorScheme.primary),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20)),
                      ),
                      child: Row(
                        children: [
                          Expanded(child: Text("")),
                          Expanded(
                            flex: 40,
                            child: TextField(
                              controller: controller,
                              onSubmitted: (value) {
                                if(value != "") {
                                  addMesssage(value, true);
                                  controller.text = "";
                                }
                              },
                              decoration: const InputDecoration(
                                fillColor: Colors.white,
                                hintText: "Type a message",
                                border: InputBorder.none
                              ),
                            ),
                          ),
                          IconButton(
                            color: Theme.of(context).colorScheme.primary,
                            onPressed: () {
                              if(controller.text != "") {
                                addMesssage(controller.text, true);
                                controller.text = "";
                              }
                            },
                            icon: Icon(Icons.send_rounded)
                          ),
                        ],
                      )
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
  Widget message;
  bool isSender;
  Message({super.key, required this.message, required this.isSender});

  BorderRadiusGeometry messageBorderRadiusGeometry() {
    if(isSender == true) {
      return const BorderRadius.only(
        bottomLeft: Radius.circular(20),
        topLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
        topRight: Radius.circular(20),
      );
    }
    return const BorderRadius.only(
        bottomRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20),
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
      // crossAxisAlignment: messageAlignment(),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.center,
          // constraints: const BoxConstraints(
          //   minHeight: 60,
          //   maxWidth: 150
          // ),
          decoration: BoxDecoration(
            color: messageColour(context),
            borderRadius: messageBorderRadiusGeometry(),
          ),
          child: message,
        ),
        const SizedBox(height: 16,)
      ],
    );
  }
}