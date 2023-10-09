import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:ai_cv_generator/dio/interceptors/HeaderInterceptor.dart';
import 'package:ai_cv_generator/dio/interceptors/Logger.dart';
import 'package:ai_cv_generator/dio/request/FileRequests/GetSharedFileRequest.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

class ShareApi {
  static final Dio shareClient = Dio(
    BaseOptions( 
      baseUrl: "http://acgbackend.dmdyh8atf8dnd3cs.eastus2.azurecontainer.io:8080/",
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
        data: request.toJson(),
        options: Options(
          responseType: ResponseType.bytes,
          method: 'POST'
        )
      );
      Uint8List data = Uint8List.fromList(response.data.toList() as List<int>);
      PlatformFile file = PlatformFile(
        name: 'Untitled.pdf',
        size: data.length,
        bytes: data,
      );
      return file;
    } on DioException catch(e) {
      DioClient.handleError(e);
    }
    return null;
  }
}