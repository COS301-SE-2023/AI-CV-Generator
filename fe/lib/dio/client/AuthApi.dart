import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:ai_cv_generator/dio/request/AuthRequests/ChangePasswordRequest.dart';
import 'package:ai_cv_generator/dio/request/AuthRequests/LoginRequest.dart';
import 'package:ai_cv_generator/dio/request/AuthRequests/RegisterRequest.dart';
import 'package:ai_cv_generator/dio/request/AuthRequests/ResendEmailRequest.dart';
import 'package:ai_cv_generator/dio/request/AuthRequests/ResetPasswordRequest.dart';
import 'package:ai_cv_generator/dio/request/AuthRequests/ValidatePasswordResetRequest.dart';
import 'package:ai_cv_generator/dio/request/AuthRequests/VerificationRequest.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/AuthResponse.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/ChangePasswordResponse.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/RegisterResponse.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/ResendEmailResponse.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/ResetPasswordResponse.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/ValidatePasswordResetResponse.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/VerificationResponse.dart';
import 'package:dio/dio.dart';

class AuthApi extends DioClient {
  static Future<Code> login({
    required String username,
    required String password
  }) async {
    LoginRequest req = LoginRequest(username: username, password: password);
    try {
      Response response = await DioClient.dio.post<Map<String,dynamic>>(
        'api/auth/authenticate',
        data: req.toJson(),
      );
      AuthResponse resp = AuthResponse.fromJson(response.data);
      if (resp.code ==Code.notEnabled) {
        return resp.code;
      }
      DioClient.SetAuth(resp.token!);
      DioClient.SetRefresh(resp.refreshToken!);
      return resp.code;
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
    RegisterRequest req = RegisterRequest(username: username, password: password, email: email,fname: fname,lname: lname);
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

  static Future<Code> resendEmail({
    required String username,
    required String password
  }) async {
    try {
      Response response = await DioClient.dio.post<Map<String,dynamic>>(
        'api/auth/resend',
        data: ResendEmailRequest(username: username, password: password).toJson()
      );
      return ResendEmailResponse.fromJson(response.data).code;
    } on DioException catch (e) {
      DioClient.handleError(e);
      if (e.response != null && e.response!.statusCode == 404) {
        return Code.requestFailed;
      } else if (e.response != null && e.response!.statusCode == 403) {
        return Code.failed;
      }
    }
    return Code.requestFailed;
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

  static Future<Code> reset({
    required String username,
    required String email
  }) async {
    try {
      Response response = await DioClient.dio.post<Map<String,dynamic>>(
        'api/auth/reset',
        data: ResetPasswordRequest(username: username, email: email).toJson()
      );
      return ResetPasswordResponse.fromJson(response.data).code;
    } on DioException catch (e) {
      DioClient.handleError(e);
    }
    return Code.requestFailed;
  }

  static Future<Code> validateReset({
    required String token
  }) async {
    try {
      Response response = await DioClient.dio.post<Map<String,dynamic>>(
        'api/auth/validate',
        data: ValidatePasswordResetRequest(token: token).toJson()
      );
      return ValidatePasswordResetResponse.fromJson(response.data).code;
    } on DioException catch (e) {
      DioClient.handleError(e);
    }
    return Code.requestFailed;
  }

  static Future<Code> changePassword({
    required String newPassword,
    required String token
  }) async {
    try {
      Response response = await DioClient.dio.post<Map<String,dynamic>>(
        'api/auth/change',
        data: ChangePasswordRequest(newPassword: newPassword, token: token).toJson()
      );
      return ChangePasswordResponse.fromJson(response.data).code;
    } on DioException catch (e) {
      DioClient.handleError(e);
    }
    return Code.requestFailed;
  }
}