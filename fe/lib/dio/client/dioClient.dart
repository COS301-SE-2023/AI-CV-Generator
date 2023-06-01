import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio = Dio();

  final baseurl = "https//mockbackend/api";


  Future<UserModel?> getUser({required String id}) async {
    UserModel? user;
    try {
      Response userData = await _dio.get(baseurl + '/users/$id');
      print('User Info: ${userData.data}');
      user = UserModel.fromJSON(userData.data);
    } on DioError catch (e) {
      if (e.response != null) {
        print('Dio error!');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        print('Error sending request!');
        print(e.message);
      }
    }
    return user;
  }

  


}