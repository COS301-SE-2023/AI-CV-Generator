import 'package:dio/dio.dart';

class DioClient {
  final Dio _dio = Dio();

  final baseurl = "https//mockbackend/api"; //Until the backend is fully established

  get dio => _dio;
}