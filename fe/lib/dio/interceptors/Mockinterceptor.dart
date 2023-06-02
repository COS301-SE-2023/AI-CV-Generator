import 'dart:convert';
 
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../client/dioClient.dart';
 
class MockInterceptor extends Interceptor {
 static const _jsonDir = 'assets/json/';
 static const _jsonExtension = '.json';
 bool throwError;

 MockInterceptor({
  required this.throwError
 });
 
  @override
  void onRequest(RequestOptions options,RequestInterceptorHandler handler) async {
    final resourcePath = _jsonDir + options.path.replaceAll(DioClient.base+"/","") + _jsonExtension;
    var data;
    print("Retriving from mock: $resourcePath");
    try {
      data = await rootBundle.load(resourcePath);
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

      if (throwError) {
        handler.reject(DioError(requestOptions: options));
      } else {
        handler.resolve(resp);
      }
    }  on Error catch(e) {
      print("Data from $resourcePath does not exit");
      if (throwError) {
        handler.reject(DioError(requestOptions: options));
      } else {
        handler.next(options);
      }
    }    
  }
}