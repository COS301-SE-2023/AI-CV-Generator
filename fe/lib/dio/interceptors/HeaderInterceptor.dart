import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:dio/dio.dart';

class HeaderAdder extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!options.path.contains("http")) {
      options.path = DioClient.baseurl+options.path;
    }
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = '*/*';
    return handler.next(options);
  }
}