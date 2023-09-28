
import 'dart:convert';
import 'dart:typed_data';

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