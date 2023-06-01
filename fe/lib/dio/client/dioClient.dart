import 'package:ai_cv_generator/models/user/Confirmation.dart';
import 'package:ai_cv_generator/models/user/UserLog.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio = Dio();

  final baseurl = "https//mockbackend/api"; //Until the backend is fully established


  Future<UserModel?> getUser({required UserLog logdetails}) async {
    UserModel? user;
    try {
      Response userData = await _dio.get(baseurl + '/users/${logdetails.data.email}');
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
      Response response = await _dio.post(
        baseurl + '/users/create',
        data: userInfo.toJson(),
      );

      print('User created: ${response.data}');

      retrievedUser = UserModel.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedUser;
  }

  Future<String?> deleteUser({required UserLog log}) async {
    ConfirmationMsg? retrievedMsg;

    try {
      Response response = await _dio.post(
        baseurl + '/users/delete/${log.data.email}',
        data: log.toJson(),
      );

      print('User created: ${response.data}');

      retrievedMsg = ConfirmationMsg.fromJSON(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedMsg?.msg;
  }


  //Will expand into different updates later on
  Future<UserModel?> updateUser({required UserModel userInfo}) async {
    UserModel? retrievedUser;

    try {
      Response response = await _dio.post(
        baseurl + '/users/update/',
        data: userInfo.toJson(),
      );

      print('User created: ${response.data}');

      retrievedUser = UserModel.fromJson(response.data);
    } catch (e) {
      print('Error creating user: $e');
    }

    return retrievedUser;
  }






}