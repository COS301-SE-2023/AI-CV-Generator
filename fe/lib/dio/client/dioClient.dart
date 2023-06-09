import 'package:ai_cv_generator/dio/interceptors/HeaderInterceptor.dart';
import 'package:ai_cv_generator/dio/interceptors/Logger.dart';
import 'package:ai_cv_generator/dio/interceptors/tokenRefreshInterceptor.dart';
import 'package:dio/dio.dart';

import '../interceptors/Mockinterceptor.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://localhost:8080/",
      //Will change depending on time
      connectTimeout: const Duration(
        seconds: 10
      ),
      receiveTimeout: const Duration(
        seconds: 10
      ),
    ),
  ) ..interceptors.addAll(
    [
      Logger(log: true),
      MockInterceptor(throwError: false, intercept: false),
      HeaderAdder(),
      TokenRevalidator()
    ]
  );
  static const baseurl = "http://localhost:8080/"; //This will be the actual base usl during development of the system
  //final baseurl = "https//mockbackend/api"; //Until the backend is fully established


  // Extreamely temporary (implementing secure method later on)
  static String authToken ="";
  static String refreshToken = "";
  static void SetAuth(String authT) {
    authToken = authT;
  }
  static void SetRefresh(String authT) {
    refreshToken = authT;
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