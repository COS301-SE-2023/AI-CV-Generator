import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:ai_cv_generator/dio/request/AuthRequests/LoginRequest.dart';
import 'package:ai_cv_generator/dio/request/AuthRequests/RegisterRequest.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/AuthResponse.dart';
import 'package:dio/dio.dart';

class AuthApi extends DioClient {
  static Future<bool> login({
    required String username,
    required String password
  }) async {
    LoginRequest req = LoginRequest(username: username, password: password);
    try {
      Response response = await DioClient.dio.post<Map<String,dynamic>>(
        'api/auth/authenticate',
        data: req.toJson(),
      );
      print('Response Info: ${response.data}');
      AuthResponse resp = AuthResponse.fromJson(response.data);
      DioClient.SetAuth(resp.token);
      DioClient.SetRefresh(resp.refreshToken);
      return true;
    } on DioException catch (e) {
     DioClient.handleError(e);
    }
    return false;
  }

  static Future<String?> register({
    required String username,
    required String password,
    required String email,
    required String fname,
    required String lname
  }) async {
    RegisterRequest req = RegisterRequest(username: username, password: password, email: email,fname: fname,lname: lname);
    try {
      Response response = await DioClient.dio.post<Map<String,dynamic>>(
        'api/auth/reg',
        data: req.toJson(),
      );
      print('Response Info: ${response.data}');
      AuthResponse resp = AuthResponse.fromJson(response.data);
      DioClient.SetAuth(resp.token);
      DioClient.SetRefresh(resp.refreshToken);
      return "1";
    } on DioException catch (e) {
      DioClient.handleError(e);
      return e.message;
    }
  }
}