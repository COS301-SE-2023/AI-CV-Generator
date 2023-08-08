
import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:ai_cv_generator/dio/request/AIRequests/ExtractionRequest.dart';
import 'package:ai_cv_generator/dio/request/AIRequests/MockGenerationRequest.dart';
import 'package:ai_cv_generator/dio/response/AIResponses/ExtractionResponse.dart';
import 'package:ai_cv_generator/dio/response/AIResponses/MockGenerationResponse.dart';
import 'package:ai_cv_generator/models/aimodels/AIInput.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart'; 

class AIApi extends DioClient {
  static Future<MockGenerationResponse?> mockgenerate({
    required UserModel userModel
  }) async {

      MockGenerationResponse? response;
      await DioClient.dio.post(
        'generate/mockgenerate',
        data: MockGenerationRequest(adjustedModel: userModel).toJson()
      ).then((value) {
        response = MockGenerationResponse.fromJson(value.data);
      }).timeout(const Duration(milliseconds: 32000), 
      onTimeout: () {
        
      },);
      return response;
  }

  static Future<AIInput?> extractPdf({
    required PlatformFile file
  }) async {
    AIInput? data;
    await DioClient.dio.post(
        'generate/extract',
        data: ExtractionRequest(text: PdfTextExtractor(PdfDocument(inputBytes: file.bytes)).extractText()).toJson()
      ).then((value) {
        data = ExtractionResponse.fromJson(value.data).data;
      }).timeout(const Duration(milliseconds: 32000), 
      onTimeout: () {
        
      },);
    return data;
  }
}