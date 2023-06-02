import 'dart:convert';
 
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../client/dioClient.dart';
 
class MockInterceptor extends Interceptor {
 static const _jsonDir = 'assets/json/';
 static const _jsonExtension = '.json';
 
  @override
  void onRequest(RequestOptions options,RequestInterceptorHandler handler) async {
    final resourcePath = _jsonDir + options.path.replaceAll(DioClient.base+"/","") + _jsonExtension;
    print("Retriving from mock: $resourcePath");
    final data = await rootBundle.load(resourcePath);
    final map = json.decode(
      utf8.decode(
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes),
      ),
    );

    print("Loading data from $resourcePath was succesful returning data");
    print(map.toString());
  
    var resp = Response(
      data: map,
      statusCode: 200,
      requestOptions: options
    );

    handler.resolve(resp,true);
  }
}