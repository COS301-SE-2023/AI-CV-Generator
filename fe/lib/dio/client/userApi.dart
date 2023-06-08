import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:ai_cv_generator/models/user/Confirmation.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';

import 'package:dio/dio.dart';

import '../../models/user/UserLog.dart';

class userApi extends DioClient {
  static Future<UserModel?> getUser({required String id}) async {
    UserModel? user;
    try {
      Response userData = await DioClient.dio.get('${DioClient.base}/users/retrieve/$id');
      print('User Info: ${userData.data}');
      user = UserModel.fromJson(userData.data);
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio error!  no response');
        print('STATUS: ${e.response?.statusCode} //status of dio request failuire');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print(e.message);
      }
    }
    return user;
  }

  static Future<UserModel?> createUser({required UserModel userInfo}) async {
    UserModel? retrievedUser;

    try {
      Response response = await DioClient.dio.post(
        '${DioClient.base}/users/create',
        data: userInfo.toJson(),
      );

      print('User created: ${response.data}');

      retrievedUser = UserModel.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
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
        '${DioClient.base}/users/delete/$id'
      );

      print('User created: ${response.data}');

      retrievedMsg = ConfirmationMsg.fromJSON(response.data);
    } catch (e) {
      print('Error creating user: $e');
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
        '${DioClient.base}/users/update/$id',
        data: user.toJson(),
      );

      print('User updated: ${response.data}');

      updateduser = UserModel.fromJson(response.data);
    } catch (e) {
      print('Error updating user: $e');
    }

    return updateduser;
  }

  static Future<UserLog?> login({
    required String username,
    required String password
  }) async {
    UserLog? user;
    try {
      Response userData = await DioClient.dio.get('${DioClient.base}/users/retrieve/$username');
      print('User Info: ${userData.data}');
      user = UserLog.fromJSON(userData.data);
    } on DioException catch (e) {
      if (e.response != null) {
        print('Dio error!  no response');
        print('STATUS: ${e.response?.statusCode} //status of dio request failuire');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print(e.message);
      }
    }
    return user;
  }

  static void testRequest({
    required String val
  }) async {
    Response resp = await DioClient.dio.get('${DioClient.base}/api/Users');
    print("Response: "+resp.data);
  }
}