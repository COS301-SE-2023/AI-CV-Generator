
import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:ai_cv_generator/dio/request/GenerationRequests/MockGenerationRequest.dart';
import 'package:ai_cv_generator/dio/response/GenerationResponses/MockGenerationResponse.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:dio/dio.dart';

class GenerationApi extends DioClient {
  static Future<MockGenerationResponse?> mockgenerate({
    required UserModel userModel
  }) async {
    try {
      return MockGenerationResponse.fromJson(
        (
          await DioClient.dio.post(
            'generate/mockgenerate',
            data: MockGenerationRequest(adjustedModel: userModel).toJson()
          )
        ).data
      );
    } on DioException catch(e) {
      DioClient.handleError(e);
    }
  }
}