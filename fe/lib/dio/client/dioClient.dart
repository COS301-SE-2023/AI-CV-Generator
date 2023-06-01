import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio = Dio(
  BaseOptions(
    baseUrl: 'https://mockbackend/api',
    connectTimeout: Duration(

    ),
    receiveTimeout: Duration(
      
    ),
  ),
);

  final baseurl = "https//mockbackend/api"; //Until the backend is fully established

  get dio => _dio;
}