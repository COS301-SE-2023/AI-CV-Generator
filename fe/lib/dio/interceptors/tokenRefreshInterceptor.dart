
import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:ai_cv_generator/dio/request/AuthRequests/RefreshRequest.dart';
import 'package:dio/dio.dart';

class TokenRevalidator extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!options.path.contains("auth")) {
      print(DioClient.authToken);
      options.headers['Authorization'] = "Bearer ${DioClient.authToken}";
    }   
    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.requestOptions.path.contains("auth")) {
      return handler.next(err);
    }
    if (err.response?.statusCode == 401 ) {
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
      } on DioError {
        print("Refresh failed!\nSign in again!");
        return handler.next(err);
      }
    }
    
  }
}