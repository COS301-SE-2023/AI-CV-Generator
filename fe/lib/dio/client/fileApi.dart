import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:ai_cv_generator/dio/request/FileRequests/FileRequest.dart';
import 'package:ai_cv_generator/dio/request/FileRequests/ShareFileRequest.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

class FileApi extends DioClient {
  static Future<Response?> uploadFile(
    {
      required PlatformFile? file,

    }
  ) async {
    if (file == null) return null;
    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
        file.bytes as List<int>, filename: file.name,
      )
    });

    try {
      Response response = await DioClient.dio.post(
        'api/User/file',
        data: formData,
        onSendProgress: (int sent, int total) {
          print('$sent $total');
        },
      );
      return response;
    } on DioError catch(e) {
      DioClient.handleError(e);
    }
    return null;
  }

  static Future<PlatformFile?> requestFile(
    {
      required String filename
    }
  ) async {
    try {
      FileRequest request = FileRequest(filename: filename);
      Response response = await DioClient.dio.post(
          'api/User/retfile',
          data: request.toJson()
        );
      print(response.data);
    } on DioError catch (e) {
      DioClient.handleError(e);
    }
    
    return null;
  }

  static Future<String> generateUrl({
    required String filename
  }) async {
    String url = "";
    try {
      ShareFileRequest request = ShareFileRequest(filename: filename, base: "http:/${Uri.base.host}:${Uri.base.port}/");
      Response response = await DioClient.dio.post(
        'api/User/share',
        data: request.toJson()
      );
    } on DioError catch(e) {
      DioClient.handleError(e);
    }
    return url;
  }
}