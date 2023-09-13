
import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:ai_cv_generator/dio/request/AuthRequests/RefreshRequest.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/AuthResponse.dart';
import 'package:dio/dio.dart';

class TokenRevalidator extends Interceptor {

  bool revalidate = true;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (!options.path.contains("auth")) {
      options.headers['Authorization'] = "Bearer ${await DioClient.authToken()}";
    }   
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.requestOptions.path.contains("auth")) {
      return handler.next(err);
    }
    if (err.response?.statusCode == 403 && revalidate) {
      revalidate = false;
      print("Intercepting to refresh!");
      try {
        RefreshRequest req = RefreshRequest(refreshToken: await DioClient.refreshToken());
        Response resp = await DioClient.dio.post(
          "api/auth/refresh",
          data: req.toJson()
        );
        if (resp.statusCode == 200) {
          AuthResponse response = AuthResponse.fromJson(resp.data);
          DioClient.SetAuth(response.token!);
          DioClient.SetRefresh(response.refreshToken!);
          final options = Options(
            method: err.requestOptions.method
          );
          handler.resolve(
            await DioClient.dio.request<dynamic>(
              err.requestOptions.path,
              data: err.requestOptions.data,
              queryParameters: err.requestOptions.queryParameters,
              options: options
          ));
          revalidate = true;
        } else {
          return handler.next(err);
        }
      } on DioException {
        print("Refresh failed!\nSign in again!");
        return handler.next(err);
      }
    }
    
  }
}