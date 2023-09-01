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
      'You are a helpful chatbot that advises users on creating a cv as well as helping a user navigate a web application. A user will ask a question in the form of a paragraph, and you should answer there question in the form of a paragraph.The web application starts on the home page where a user can provide their imformatio manually by clicking "Survey" or upload a CV have their imformation extracted for them by clicking "Upload".The user may also navigate to the profile page by clicking on the button in the top right corner. On the profile page the user can access, store and edit their imformation.'
    ),
  ];

  Future<String> greeting() async {
    messages.add(ChatMessage.human("Hello"));
    var response = await bot.call(messages);
    messages.add(response);
    return response.content;
  }
  
  Future<String> message({
    required String userMsg
  }) async {
    messages.add(ChatMessage.human(userMsg));
    var response  = await bot.call(messages);
    messages.add(response);
    return response.content;
  }
}