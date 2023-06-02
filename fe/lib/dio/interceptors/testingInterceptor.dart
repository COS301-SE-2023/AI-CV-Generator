import 'dart:convert';

import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class Tester extends Interceptor {
  final bool test;
  Tester({
    required this.test
  });

  static const _jsonDir = 'assets/json/';
  static const _jsonExtension = '.json';

  //Logs outgoing requests
  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (!test) return super.onRequest(options, handler);
    final resourcePath = _jsonDir + options.path.replaceAll(DioClient.base+"/","") + _jsonExtension;
    final data = await rootBundle.load(resourcePath);
    final map = json.decode(
      utf8.decode(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      ),
    );
    print(map.toString());
    return super.onRequest(options, handler);
  }

  //Logs incoming responses
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!test) return super.onResponse(response, handler);
    print(
      'Resonse Recieved [${response.statusCode}] => at Path: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  //Logs Errors
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (!test) return super.onError(err, handler);
    print(
      'Error [${err.response?.statusCode}] => at Path: ${err.requestOptions.path}',
    );
    if (err.response == null) {
      print("Error may be that frontend cannot connect to the backend or that the backend isnt running");
    }
    return super.onError(err, handler);
  }
}