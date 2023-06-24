import 'dart:typed_data';

import 'package:ai_cv_generator/models/files/FileModel.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../models/files/Unit8listConverter.dart';

part 'GetFilesResponse.g.dart';

@JsonSerializable()
class GetFilesResponse {
  
  List<FileModel> files;

  GetFilesResponse({
    required this.files
  });

  factory GetFilesResponse.fromJson(Map<String, dynamic> json) => _$GetFilesResponseFromJson(json);
  Map<String, dynamic> toJson() => _$GetFilesResponseToJson(this);
}