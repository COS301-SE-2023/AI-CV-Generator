import 'package:ai_cv_generator/dio/interceptors/Logger.dart';
import 'package:ai_cv_generator/dio/interceptors/Mockinterceptor.dart';
import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio = Dio(
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
      //MockInterceptor()
    ]
  );

  final baseurl = "https//mockbackend/api"; //Until the backend is fully established

  get dio => _dio;
}