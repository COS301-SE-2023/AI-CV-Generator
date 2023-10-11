
import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:ai_cv_generator/dio/request/AIRequests/ChatRequest.dart';
import 'package:ai_cv_generator/dio/request/AIRequests/ExtractionRequest.dart';
import 'package:ai_cv_generator/dio/request/AIRequests/GenerationRequest.dart';
import 'package:ai_cv_generator/dio/response/AIResponses/ChatResponse.dart';
import 'package:ai_cv_generator/dio/response/AIResponses/ExtractionResponse.dart';
import 'package:ai_cv_generator/dio/response/AIResponses/GenerationResponse.dart';
import 'package:ai_cv_generator/models/aimodels/AIInput.dart';
import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart'; 

class AIApi extends DioClient {
  static Future<GenerationResponse?> generate({
    required AIInput data
  }) async {
      // Creating input
      GenerationResponse? response;
      await DioClient.dio.post(
        'generate/gen',
        data: GenerationRequest(data:data).toJson()
      ).then((value) {
        response = GenerationResponse.fromJson(value.data);
      }).timeout(const Duration(milliseconds: 35000), 
      onTimeout: () {
        
      },);
      return response;
  }

  static Future<CVData?> generateAI({
    required AIInput data
  }) async {
    // Creating input
      CVData? output;
      await DioClient.dio.post(
        'generate/gen',
        data: GenerationRequest(data:data).toJson()
      ).then((value) {
        output = GenerationResponse.fromJson(value.data).data;
      }).timeout(const Duration(milliseconds: 35000), 
      onTimeout: () {
        
      },);
      return output;
  }

  static Future<AIInput?> extractPdf({
    required PlatformFile file
  }) async {
    AIInput? data;
    try {
      Response response = await DioClient.dio.post(
        'generate/extract',
        data: ExtractionRequest(text: PdfTextExtractor(PdfDocument(inputBytes: file.bytes)).extractText()).toJson()
      );
      data = ExtractionResponse.fromJson(response.data).data;
    } on DioException catch(e) {
      DioClient.handleError(e);
    }
    return data;
  }

  static Future<List<String>?> chat({
    required List<String> messages,
    required String userMessage
  }) async {
    Response response = await DioClient.dio.post(
      'generate/chat',
      data: ChatRequest(messages: messages, userMessage: userMessage).toJson()
    );
    return ChatResponse.fromJson(response.data).messages;
  }
}

