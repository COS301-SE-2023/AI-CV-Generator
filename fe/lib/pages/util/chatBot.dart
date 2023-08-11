import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:langchain_openai/langchain_openai.dart';
class Chatbot {

  final llm = OpenAI(
    apiKey: dotenv.env['OPENAI_KEY'],
    temperature: double.parse(dotenv.env['OPENAI_TEMP']??"1"),
    maxTokens: int.parse(dotenv.env['OPENAI_MAX']??"256")
  
  );

  Future<String> message({
    required String userMsg
  }) async {
    return await llm.predict(userMsg);
  }
}