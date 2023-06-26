
import 'dart:typed_data';
import 'package:ai_cv_generator/models/files/Unit8listConverter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FileModel.ga.dart';
class FileModel {
  String filename;
  Uint8List cover;

  FileModel({
    required this.filename,
    required this.cover
  });

  factory FileModel.fromJson(Map<String, dynamic> json) => _$FileModelFromJson(json);
  Map<String, dynamic> toJson() => _$FileModelToJson(this);

}