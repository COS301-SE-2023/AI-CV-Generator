import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:ai_cv_generator/dio/request/LoginRequest.dart';
import 'package:ai_cv_generator/dio/request/RegisterRequest.dart';
import 'package:ai_cv_generator/dio/response/AuthResponse.dart';
import 'package:ai_cv_generator/models/user/Confirmation.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';

import 'package:dio/dio.dart';

class userApi extends DioClient {
  static Future<UserModel?> getUser({required String id}) async {
    UserModel? user;
    try {
      Response userData = await DioClient.dio.get('users/retrieve/$id');
      print('User Info: ${userData.data}');
      user = UserModel.fromJson(userData.data);
    } on DioError catch (e) {
      DioClient.handleError(e);
    }
    return user;
  }

  static Future<UserModel?> createUser({required UserModel userInfo}) async {
    UserModel? retrievedUser;

    try {
      Response response = await DioClient.dio.post(
        'users/create',
        data: userInfo.toJson(),
      );

      print('User created: ${response.data}');

      retrievedUser = UserModel.fromJson(response.data);
    } on DioError catch (e) {
      DioClient.handleError(e);
    } 

    return retrievedUser;
  }

  Future<String?> deleteUser(
    {
      required id
    }
    ) async {
    ConfirmationMsg? retrievedMsg;
    
    try {
      Response response = await DioClient.dio.delete(
        'users/delete/$id'
      );

      print('User created: ${response.data}');

      retrievedMsg = ConfirmationMsg.fromJSON(response.data);
    } on DioError catch (e) {
      DioClient.handleError(e);
    }

    return retrievedMsg?.msg;
  }


  //Will expand into different updates later on
  static Future<UserModel?> updateUser({
      required UserModel user,
      required String id,
    }) async {
    UserModel? updateduser;

    try {
      Response response = await DioClient.dio.put(
        'users/update/$id',
        data: user.toJson(),
      );

      print('User updated: ${response.data}');

      updateduser = UserModel.fromJson(response.data);
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
    Response resp = await DioClient.dio.get('api/Users');
    print("Response: ${resp.data}");
  }
}