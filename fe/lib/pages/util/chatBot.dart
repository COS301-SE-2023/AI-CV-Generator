import 'package:ai_cv_generator/dio/client/AIApi.dart';
class Chatbot {

  bool ready = false;

  List<String> messages = [];

  Future<String> greeting() async {
    try {
      var response = await AIApi.chat(messages: messages, userMessage: "Hello");
      messages = response!;
      return messages.last;
    } on Exception catch (e) {
      print("Unable to request response from AI chatbot");
      return "Sorry this isnt working";
    }
  }
  
  Future<String> message({
    required String userMsg
  }) async {
    try {
      var response = await AIApi.chat(messages: messages, userMessage: userMsg);
      messages = response!;
      return messages.last;
    } on Exception catch (e) {
      print("Unable to request response from AI chatbot");;
      return "Sorry this isnt working";
    }
  }
}