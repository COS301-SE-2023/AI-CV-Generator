import 'package:ai_cv_generator/dio/interceptors/Logger.dart';
import 'package:ai_cv_generator/dio/interceptors/testingInterceptor.dart';
import 'package:dio/dio.dart';

class DioClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://mockbackend/api',
      //Will change depending on time
      connectTimeout: const Duration(
        minutes: 5
      ),
      receiveTimeout: const Duration(
        minutes: 5
      ),
    ),
  ) ..interceptors.addAll(
    [
      Logger(log: true),
      //MockInterceptor(),
      Tester(test: true)
    ]
  );
  static const baseurl = "http//localhost:8080"; //This will be the actual base usl during development of the system
  //final baseurl = "https//mockbackend/api"; //Until the backend is fully established

  static get dio => _dio;
  static get base => baseurl;
}