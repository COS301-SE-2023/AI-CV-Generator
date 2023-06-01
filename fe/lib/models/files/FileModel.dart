
import 'dart:typed_data';
import 'package:ai_cv_generator/models/files/Unit8listConverter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'FileModel.g.dart';

@JsonSerializable()
class FileModel {

  String name;
  int size;
  @Uint8ListConverter()
  Uint8List bytes;

  FileModel({
    required this.name,
    required this.size,
    required this.bytes
  });

  factory FileModel.fromJson(Map<String, dynamic> json) => _$FileModelFromJson(json);
  Map<String, dynamic> toJson() => _$FileModelToJson(this);

}