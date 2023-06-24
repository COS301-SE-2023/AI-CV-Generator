
import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:ai_cv_generator/dio/request/AuthRequests/RefreshRequest.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/AuthResponse.dart';
import 'package:dio/dio.dart';

class TokenRevalidator extends Interceptor {

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!options.path.contains("auth")) {
      options.headers['Authorization'] = "Bearer ${DioClient.authToken}";
    }   
    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.requestOptions.path.contains("auth")) {
      return handler.next(err);
    }
    if (err.response?.statusCode == 403 ) {
      print("Intercepting to refresh!");
      try {
        RefreshRequest req = RefreshRequest(refreshToken: DioClient.refreshToken);
        Response resp = await DioClient.dio.post(
          "api/auth/refresh",
          data: req.toJson()
        );
        if (resp.statusCode == 200) {
          AuthResponse response = AuthResponse.fromJson(resp.data);
          DioClient.SetAuth(response.token);
          DioClient.SetRefresh(response.refreshToken);
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