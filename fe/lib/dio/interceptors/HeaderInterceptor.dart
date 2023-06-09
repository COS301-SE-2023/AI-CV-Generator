import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:dio/dio.dart';

class HeaderAdder extends Interceptor {
  

  //Logs outgoing requests
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!options.path.contains("http")) {
      options.path = DioClient.baseurl+options.path;
    }
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = '*/*';
    return handler.next(options);
  }

  //Logs incoming responses
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }

  //Logs Errors
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    return super.onError(err, handler);
  }
}