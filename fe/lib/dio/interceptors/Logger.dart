import 'package:dio/dio.dart';

class Logger extends Interceptor {
  final bool? log;
  Logger({
    this.log
  });

  //Logs outgoing requests
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (log == null || log == false) return super.onRequest(options,handler);
    print('Request [${options.method}] => at path: ${options.path}');
    return super.onRequest(options, handler);
  }

  //Logs incoming responses
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (log == null || log == false) return super.onResponse(response, handler);
    print(
      'Resonse Recieved [${response.statusCode}] => at Path: ${response.requestOptions.path}',
    );
    return super.onResponse(response, handler);
  }

  //Logs Errors
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (log == null || log ==false) return super.onError(err,handler);
    print(
      'Error [${err.response?.statusCode}] => at Path: ${err.requestOptions.path}',
    );
    if (err.response == null) {
      print("Error may be that frontend cannot connect to the backend or that the backend isnt running");
    }
    return handler.next(err);
  }
}