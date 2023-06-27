import 'dart:convert';
 
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../client/dioClient.dart';
 
class MockInterceptor extends Interceptor {
 static const _jsonDir = 'assets/json/';
 static const _jsonExtension = '.json';
 bool? throwError;
 bool? intercept;

 MockInterceptor({
    this.throwError,
    this.intercept
 });
 
  @override
  void onRequest(RequestOptions options,RequestInterceptorHandler handler) async {
    if (intercept == null || intercept == false) return super.onRequest(options, handler);
    final resourcePath = _jsonDir + options.path.replaceAll(DioClient.base+"/","") + _jsonExtension;
    ByteData data;
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

      if (throwError != null && throwError == true) {
        handler.reject(DioError(requestOptions: options));
      } else {
        handler.resolve(resp);
      }
    }  on Error {
      print("Data from $resourcePath does not exit");
      if (throwError != null && throwError == true) {
        handler.reject(DioError(requestOptions: options));
      } else {
        handler.next(options);
      }
    }    
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      'Resonse Recieved [${response.statusCode}] => at Path: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  //Logs Errors
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print(
      'Error [${err.response?.statusCode}] => at Path: ${err.requestOptions.path}',
    );
    if (err.response == null) {
      print("Error may be that frontend cannot connect to the backend or that the backend isnt running");
    }
    return super.onError(err, handler);
  }
}