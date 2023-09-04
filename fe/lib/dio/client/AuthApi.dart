import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:ai_cv_generator/dio/request/AuthRequests/LoginRequest.dart';
import 'package:ai_cv_generator/dio/request/AuthRequests/RegisterRequest.dart';
import 'package:ai_cv_generator/dio/request/AuthRequests/VerificationRequest.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/AuthResponse.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/RegisterResponse.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/VerificationResponse.dart';
import 'package:dio/dio.dart';

class AuthApi extends DioClient {
  static Future<Code> login({
    required String username,
    required String password
  }) async {
    LoginRequest req = LoginRequest(username: username, password: password, siteUrl: "http://${Uri.base.host}:${Uri.base.port}");
    try {
      Response response = await DioClient.dio.post<Map<String,dynamic>>(
        'api/auth/authenticate',
        data: req.toJson(),
      );
      AuthResponse resp = AuthResponse.fromJson(response.data);
      if (resp.code == Code.notEnabled) {
        return resp.code;
      }
      DioClient.SetAuth(resp.token);
      DioClient.SetRefresh(resp.refreshToken);
      return Code.success;
    } on DioException catch (e) {
     DioClient.handleError(e);
    }
    return Code.failed;
  }

  static Future<Code> register({
    required String username,
    required String password,
    required String email,
    required String fname,
    required String lname
  }) async {
    RegisterRequest req = RegisterRequest(username: username, password: password, email: email,fname: fname,lname: lname,siteUrl: "http://${Uri.base.host}:${Uri.base.port}");
    try {
      Response response = await DioClient.dio.post<Map<String,dynamic>>(
        'api/auth/reg',
        data: req.toJson(),
      );
      
      Code code = RegisterResponse.fromJson(response.data).code;
      return code;
    } on DioException catch (e) {
      DioClient.handleError(e);
      return Code.requestFailed;
    }
  }

  static Future<Code> verify({
    required String code
  }) async {
    try {
      Response response = await DioClient.dio.post<Map<String,dynamic>>(
        'api/auth/verify',
        data: VerificationRequest(registrationToken: code).toJson()
      );
      return VerificationResponse.fromJson(response.data).code;
    } on DioException catch (e) {
      DioClient.handleError(e);
    }
    return Code.failed;
  }
}