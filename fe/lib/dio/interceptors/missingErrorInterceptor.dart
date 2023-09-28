import 'package:dio/dio.dart';

class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    DioException exception = DioException.badResponse(statusCode: 404, requestOptions: RequestOptions(), response: Response(requestOptions: RequestOptions(),statusCode: 404));
    if (err.response != null&& err.response!.statusCode == null) {
      err = exception;
    }
    super.onError(exception, handler);
  }
}