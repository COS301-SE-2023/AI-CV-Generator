import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:ai_cv_generator/dio/request/AuthRequests/LoginRequest.dart';
import 'package:ai_cv_generator/dio/request/AuthRequests/RegisterRequest.dart';
import 'package:ai_cv_generator/dio/request/DetailsRequests/Qualification/AddQualificationRequest.dart';
import 'package:ai_cv_generator/dio/request/UserRequests/UpdateUserRequest.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/AuthResponse.dart';
import 'package:ai_cv_generator/dio/response/UserResponses/UserResponse.dart';
import 'package:ai_cv_generator/models/user/Qualification.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';

import 'package:dio/dio.dart';

import '../request/DetailsRequests/Qualification/RemoveQualificationRequest.dart';
import '../request/DetailsRequests/Qualification/UpdateQualificationRequest.dart';
import '../response/DetailsResponses/QualificationsResponse.dart';

class userApi extends DioClient {
  static Future<UserModel?> getUser() async {
    UserModel? user;
    try {
      Response response = await DioClient.dio.get('api/User/user');
      print('User Info: ${response.data}');
      user = UserResponse.fromJson(response.data).user;
    } on DioError catch (e) {
      DioClient.handleError(e);
    }
    return user;
  }


  //Will expand into different updates later on
  static Future<UserModel?> updateUser({
      required UserModel user
    }) async {
    UserModel? updateduser;

    try {
      UpdateUserRequest request = UpdateUserRequest(user: user);
      Response response = await DioClient.dio.post(
        'api/User/user',
        data: request.toJson()
      );
      print('User updated: ${response.data}');

      updateduser = UserResponse.fromJson(response.data).user;
    } on DioError catch (e) {
      DioClient.handleError(e);
    }

    return updateduser;
  }

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
    } on DioError catch (e) {
     DioClient.handleError(e);
    }
    return false;
  }

  static Future<String?> register({
    required String username,
    required String password,
    required String fname,
    required String lname
  }) async {
    RegisterRequest req = RegisterRequest(username: username, password: password,fname: fname,lname: lname);
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
    } on DioError catch (e) {
      DioClient.handleError(e);
      return e.message;
    }
  }

  static void testRequest({
    required String val
  }) async {
    
    try {
      Response resp = await DioClient.dio.get('api/User/test');
      print("Response: "+resp.data);
    } on DioError catch (e) {
      DioClient.handleError(e);
    }
    Response resp = await DioClient.dio.get('api/Users');
    print("Response: ${resp.data}");
  }

  static Future<List<Qualification>?> addQulaification({
    required Qualification qualification
  }) async {
    try {
      AddQualificationRequest request = AddQualificationRequest(qualification: qualification);
      Response resp = await DioClient.dio.post(
        'api/User/addQua',
        data: request.toJson()
        );
      return QualificationsResponse.fromJson(resp.data).qualifications;
    } on DioError catch (e) {
      DioClient.handleError(e);
    }
    return null;
  }

  static Future<List<Qualification>?> removeQulaification({
    required Qualification qualification
  }) async {
    try {
      RemoveQualificationRequest request = RemoveQualificationRequest(qualification: qualification);
      Response resp = await DioClient.dio.post(
        'api/User/remQua',
        data: request.toJson()
        );
      return QualificationsResponse.fromJson(resp.data).qualifications;
    } on DioError catch (e) {
      DioClient.handleError(e);
    }
    return null;
  }

  static Future<List<Qualification>?> updateQulaification({
    required Qualification qualification
  }) async {
    try {
      UpdateQualificationRequest request = UpdateQualificationRequest(qualification: qualification);
      Response resp = await DioClient.dio.post(
        'api/User/updateQua',
        data: request.toJson()
        );
      return QualificationsResponse.fromJson(resp.data).qualifications;
    } on DioError catch (e) {
      DioClient.handleError(e);
    }
    return null;
  }
}