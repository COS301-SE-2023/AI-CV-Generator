import 'package:ai_cv_generator/dio/interceptors/HeaderInterceptor.dart';
import 'package:ai_cv_generator/dio/interceptors/Logger.dart';
import 'package:ai_cv_generator/dio/interceptors/tokenRefreshInterceptor.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://localhost:8080/",
      //Will change depending on time
      connectTimeout: const Duration(
        seconds: 40
      ),
      receiveTimeout: const Duration(
        seconds: 40
      ),
    ),
  ) ..interceptors.addAll(
    [
      Logger(log: true),
      HeaderAdder(),
      TokenRevalidator()
    ]
  );
  static const baseurl = "http://localhost:8080/"; //This will be the actual base usl during development of the system
  //final baseurl = "https//mockbackend/api"; //Until the backend is fully established

  

  // Extreamely temporary (implementing secure method later on)
  // Keeping as is until final demo

  static Future<String> authToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('auth')?? "";
  }

  static Future<String> refreshToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString('refresh')?? "";
  }

  static void SetAuth(String authT) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('auth', authT);
  }
  static void SetRefresh(String authT) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('refresh', authT);
  }

  static get dio => _dio;
  static get base => baseurl;

  static void handleError(DioException e) {
    if (e.response != null) {
        print('Dio error!  no response');
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
    } else {
      print(e.message);
    }
  }
}