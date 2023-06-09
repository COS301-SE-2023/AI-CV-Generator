import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:ai_cv_generator/dio/request/RefreshRequest.dart';
import 'package:dio/dio.dart';

class TokenRevalidator extends Interceptor {
  

  //Logs outgoing requests
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!options.path.contains("auth")) {
      options.headers['Bearer'] = DioClient.authToken;
    }   
    return handler.next(options);
  }

  //Logs incoming responses
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    
    return super.onResponse(response, handler);
  }

  //Logs Errors
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 403 ) {
      try {
        RefreshRequest req = RefreshRequest(refreshToken: DioClient.refreshToken);
        Response resp = await DioClient.dio.post(
          "api/auth/refresh",
          body: req.toJson()
        );
        if (resp.statusCode == 200) {
          final options = Options(
            method: err.requestOptions.method
          );
          return handler.resolve(
            await DioClient.dio.request<dynamic>(
              err.requestOptions.path,
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters,
              options: options
          ));
        } else {
          return handler.next(err);
        }
      } on DioError catch (e) {
        print("Refresh failed!\nSign in again!");
        return handler.next(err);
      }
    }
    
  }
}