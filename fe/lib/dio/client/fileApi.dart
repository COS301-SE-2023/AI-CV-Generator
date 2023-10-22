import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:ai_cv_generator/dio/client/dioClient.dart';
import 'package:ai_cv_generator/dio/request/FileRequests/FileRequest.dart';
import 'package:ai_cv_generator/dio/request/FileRequests/ShareFileRequest.dart';
import 'package:ai_cv_generator/dio/response/AuthResponses/Code.dart';
import 'package:ai_cv_generator/dio/response/FileResponses/GetFilesResponse.dart';
import 'package:ai_cv_generator/dio/response/FileResponses/ShareFileResponse.dart';
import 'package:ai_cv_generator/dio/response/FileResponses/UploadFileResponse.dart';
import 'package:ai_cv_generator/models/files/FileModel.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render.dart';
import 'package:flutter/painting.dart' as paint;

class FileApi extends DioClient {
  static Future<Code> uploadFile(
    {
      required PlatformFile? file
    }
  ) async {
    if (file == null) return Code.requestFailed;
    final pdf = await PdfDocument.openData(file.bytes!);
    var page = await pdf.getPage(1);
    var imgPDF = await page.render();
    var img = await imgPDF.createImageDetached();
    var imgBytes = await img.toByteData(format: ImageByteFormat.png);
    
    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(
        file.bytes as List<int>, filename: file.name,
      ),
      "cover": MultipartFile.fromBytes(
        imgBytes!.buffer.asUint8List(imgBytes.offsetInBytes,imgBytes.lengthInBytes), filename: file.name
      ),
    });

    try {
      Response response = await DioClient.dio.post(
        'api/User/file',
        data: formData,
        onSendProgress: (int sent, int total) {
        },
      );
      return UploadFileResponse.fromJson(response.data).code;
    } on DioException catch(e) {
      DioClient.handleError(e);
    }
    return Code.requestFailed;
  }

  static Future<Image> getProfileImage() async {
    Image image = Image.asset('assets/images/NicePng_watsapp-icon-png_9332131.png');
    await DioClient.dio.get(
      'api/User/profimg',
      options: Options(
          responseType: ResponseType.bytes
      )
    ).then((value) {
        Uint8List data = Uint8List.fromList(value.data.toList() as List<int>);
        image = Image.memory(data);
    }).timeout(const Duration(milliseconds: 5000),onTimeout: () {
      
    },);
    return image;
    
  }

   static Future<Uint8List?> getProfileImageUint8List() async {
    Uint8List? list;
    await DioClient.dio.get(
      'api/User/profimg',
      options: Options(
          responseType: ResponseType.bytes
      )
    ).then((value) {
        list = Uint8List.fromList(value.data.toList() as List<int>);
        
    }).timeout(const Duration(milliseconds: 500),onTimeout: () {
      
    },);
    return list;
    
  }

  static Future<Image?> updateProfileImage({
    required Uint8List img
  }) async {
    Image? image = Image.asset('assets/images/NicePng_watsapp-icon-png_9332131.png');
    try {
      FormData formData = FormData.fromMap({
        "img": MultipartFile.fromBytes(
         img, filename: "profimage"
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
      image = Image.memory(data);
    } on DioException catch (e) {
      DioClient.handleError(e);
    }
    return image;
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
    } on DioException catch(e) {
      DioClient.handleError(e);
    }
    return url;
  }

  static Future<String> generateUrlFromNewFile({
    required PlatformFile? file,
    required int hours
  }) async {
    String url = "";
    try {
      if (file == null) return "";
      FormData formData = FormData.fromMap({
        "file": MultipartFile.fromBytes(
          file.bytes as List<int>, filename: file.name,
        ),
        "hours": hours
      });
      Response response = await DioClient.dio.post(
          'api/User/shareFile',
          data: formData,
        );
      ShareFileResponse resp =ShareFileResponse.fromJson(response.data);
        url = resp.generatedUrl;
    } on DioException catch(e) {
      DioClient.handleError(e);
    }
    return url;
  }

  static Future<paint.ImageProvider?> test({
    required String filename
  }) async {
    paint.ImageProvider? img;
    try {
      FileRequest request = FileRequest(filename: filename);
      Response response = await DioClient.dio.post(
        'api/User/test',
        data: request.toJson(),
        options: Options(
          responseType: ResponseType.bytes
        )
      );
      Uint8List data = Uint8List.fromList(response.data.toList() as List<int>);
      img = paint.MemoryImage(data);
    } on DioException catch (e) {
      DioClient.handleError(e);
    }
    return img;
  }
}