import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';

import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:ai_cv_generator/dio/request/FileRequests/FileRequest.dart';
import 'package:ai_cv_generator/dio/request/FileRequests/ShareFileRequest.dart';
import 'package:ai_cv_generator/dio/response/FileResponses/GetFilesResponse.dart';
import 'package:ai_cv_generator/dio/response/FileResponses/ShareFileResponse.dart';
import 'package:ai_cv_generator/models/files/FileModel.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class FileApi extends DioClient {
  static Future<Response?> uploadFile(
    {
      required PlatformFile? file,

    }
  ) async {
    if (file == null) return null;
    PdfDocument doc = await PdfDocument.openData(file.bytes as FutureOr<Uint8List>);
    PdfPage page = await doc.getPage(1);
    PdfPageImage? pageImage = await page.render(width: 20, height: 20);
    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
        file.bytes as List<int>, filename: file.name,
      ),
      "cover": MultipartFile.fromBytes(
        pageImage?.bytes as List<int>, filename: file.name
      ),
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
    } on DioException catch(e) {
      DioClient.handleError(e);
    }
    return null;
  }

  static Future<Image?> getProfileImage() async {
    try {
      Response response = await DioClient.dio.get(
        'api/User/profimg',
        options: Options(
            responseType: ResponseType.bytes
        )
      );
      Uint8List data = Uint8List.fromList(response.data.toList() as List<int>);
      return Image.memory(data);
    } on DioException catch (e) {
      return Image.asset('assets/images/NicePng_watsapp-icon-png_9332131.png');
    }
  }

  static Future<Image?> updateProfileImage({
    required Image img
  }) async {
    try {
      FormData formData = FormData.fromMap({
        "img": MultipartFile.fromBytes(
         img as List<int>
        )
      });
      Response response = await DioClient.dio.post(
        'api/User/updateprofimg',
        data: formData ,
        options: Options(
            responseType: ResponseType.bytes
        )
      );
      Uint8List data = Uint8List.fromList(response.data.toList() as List<int>);
      return Image.memory(data);
    } on DioException catch (e) {
      DioClient.handleError(e);
    }
  }

  static Future<List<FileModel>?> getFiles() async {
    try {
      Response response = await DioClient.dio.get('api/User/files');
      GetFilesResponse resp = GetFilesResponse.fromJson(response.data);
      return resp.files;
    } on DioException catch(e) {
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
          data: request.toJson(),
          options: Options(
            responseType: ResponseType.bytes
          )
        );
      Uint8List data = Uint8List.fromList(response.data.toList() as List<int>);
      PlatformFile file = PlatformFile(
        name: filename,
        size: data.length,
        bytes: data,
      );
      return file;
    } on DioException catch (e) {
      DioClient.handleError(e);
    }
    
    return null;
  }

  static Future<String> generateUrl({
    required String filename,
    required Duration duration
  }) async {
    String url = "";
    try {
      ShareFileRequest request = ShareFileRequest(filename: filename, base: "http://${Uri.base.host}:${Uri.base.port}/",duration: duration);
      Response response = await DioClient.dio.post(
        'api/User/share',
        data: request.toJson()
      );
      ShareFileResponse resp =ShareFileResponse.fromJson(response.data);
      url = resp.generatedUrl;
    } on DioError catch(e) {
      DioClient.handleError(e);
    }
    return url;
  }

  static Future<String> generateUrlFromNewFile({
    required PlatformFile? file,
    required DateTime date
  }) async {
    String url = "";
    try {
      if (file == null) return "";
      FormData formData = FormData.fromMap({
        "file": MultipartFile.fromBytes(
          file.bytes as List<int>, filename: file.name,
        ),
        "Date": date.toIso8601String(),
        "base": "http://${Uri.base.host}:${Uri.base.port}/"
      });
      Response response = await DioClient.dio.post(
          'api/User/shareFile',
          data: formData,
          onSendProgress: (int sent, int total) {
            print('$sent $total');
          },
        );
      ShareFileResponse resp =ShareFileResponse.fromJson(response.data);
        url = resp.generatedUrl;
    } on DioError catch(e) {
      DioClient.handleError(e);
    }
    return url;
  }
}