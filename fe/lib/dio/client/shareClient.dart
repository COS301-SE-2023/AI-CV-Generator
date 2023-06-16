import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:ai_cv_generator/dio/interceptors/HeaderInterceptor.dart';
import 'package:ai_cv_generator/dio/interceptors/Logger.dart';
import 'package:ai_cv_generator/dio/request/FileRequests/GetSharedFileRequest.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class ShareApi {
  static final Dio shareClient = Dio(
    BaseOptions( 
      baseUrl: "http://localhost:8080/",
      connectTimeout: const Duration(
        seconds: 10
      ),
      receiveTimeout: const Duration(
        seconds: 10
      ),
    )
  ) ..interceptors.addAll(
    [
      Logger(log: true),
      HeaderAdder()
    ]
  );

  static Future<PlatformFile?> retrieveFile({
    required String uuid
  }) async {
    try {
      GetSharedFileRequest request = GetSharedFileRequest(uuid: uuid);
      Response response = await shareClient.post(
        'share',
        data: request.toJson()
      );
      
    } on DioError catch(e) {
      DioClient.handleError(e);
    }
    return null;
  }
}