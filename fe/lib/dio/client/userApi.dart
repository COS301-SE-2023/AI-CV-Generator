import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:ai_cv_generator/models/user/Confirmation.dart';
import 'package:ai_cv_generator/models/user/UserLog.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';

import 'package:dio/dio.dart';

class userApi extends DioClient {
  Future<UserModel?> getUser({required UserLog logdetails}) async {
    UserModel? user;
    try {
      Response userData = await dio.get('$baseurl/users/${logdetails.data.email}');
      print('User Info: ${userData.data}');
      user = UserModel.fromJson(userData.data);
    } on DioError catch (e) {
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

  Future<UserModel?> createUser({required UserModel userInfo}) async {
    UserModel? retrievedUser;

    try {
      Response response = await dio.post(
        '$baseurl/users/create',
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
      Response response = await dio.delete(
        '$baseurl/users/delete/$id'
      );

      print('User created: ${response.data}');

      retrievedMsg = ConfirmationMsg.fromJSON(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedMsg?.msg;
  }


  //Will expand into different updates later on
  Future<UserModel?> updateUser({
      required UserModel user,
      required String id,
    }) async {
    UserModel? updateduser;

    try {
      Response response = await dio.put(
        '$baseurl/users/update/$id',
        data: user.toJson(),
      );

      print('User updated: ${response.data}');

      updateduser = UserModel.fromJson(response.data);
    } catch (e) {
      print('Error updating user: $e');
    }

    return updateduser;
  }
}