import 'package:ai_cv_generator/dio/interceptors/Logger.dart';
import 'package:dio/dio.dart';

import '../interceptors/Mockinterceptor.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: baseurl,
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
    ]
  );
  static const baseurl = "http//localhost:8080"; //This will be the actual base usl during development of the system
  //final baseurl = "https//mockbackend/api"; //Until the backend is fully established

  static String authToken ="";
  static void SetAuth(String authT) {
    
  }

  static get dio => _dio;
  static get base => baseurl;
}