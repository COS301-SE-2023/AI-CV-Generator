import 'package:dio/dio.dart';

class Tester extends Interceptor {
  final bool test;
  Tester({
    required this.test
  });

  //Logs outgoing requests
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!test) return super.onRequest(options, handler);
    print('Request [${options.method}] => at path: ${options.path}');
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