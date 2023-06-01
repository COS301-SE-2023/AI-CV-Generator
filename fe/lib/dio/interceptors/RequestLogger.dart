import 'package:dio/dio.dart';

class Logger extends Interceptor {

  //Logs outgoing requests
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('Request [${options.method}] => at path: ${options.path}');
    return super.onRequest(options, handler);
  }

  //Logs incoming responses
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      'Resonse Recieved [${response.statusCode}] => at Path: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  //Logs Errors
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print(
      'error [${err.response?.statusCode}] => at Path: ${err.requestOptions.path}',
    );
    return super.onError(err, handler);
  }
}