import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:langchain/langchain.dart';
import 'package:langchain_openai/langchain_openai.dart';
class Chatbot {

  final bot = ChatOpenAI(
    apiKey: dotenv.env['OPENAI_KEY'],
    temperature: double.parse(dotenv.env['OPENAI_TEMP']??"1"),
    maxTokens: int.parse(dotenv.env['OPENAI_MAX']??"256"),
    model: dotenv.env['OPENAI_MODEL']??"gpt-3.5-turbo"
  );

  bool ready = false;

  List<ChatMessage> messages = [
    ChatMessage.system(
      'You are a helpful chatbot that advises users on creating a cv as well as helping a user navigate our web application. A user will ask a question in the form of a paragraph, and you should answer there question in the form of a paragraph with a word count under 30. The web application starts on the home page where a user can provide their information manually by clicking "Survey" or upload a CV have their information extracted for them by clicking "Upload". The user may also navigate to the profile page by clicking on the button in the top right corner. On the profile page the user can access, store and edit their information.'     ),
  ];

  Future<String> greeting() async {
    try {
      messages.add(ChatMessage.human("Hello"));
      var response = await bot.call(messages);
      messages.add(response);
      return response.content;
    } on Exception catch (e) {
      print("Unable to request response from AI chatbot");
      return "Sorry this isnt working";
    }
  }
  
  Future<String> message({
    required String userMsg
  }) async {
    try {
      messages.add(ChatMessage.human(userMsg));
      var response  = await bot.call(messages);
      messages.add(response);
      return response.content;
    } on Exception catch (e) {
      print("Unable to request response from AI chatbot");
      return "Sorry this isnt working";
    }
  }
}