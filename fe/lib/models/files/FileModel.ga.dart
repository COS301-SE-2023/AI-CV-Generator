part of 'FileModel.dart';

FileModel _$FileModelFromJson(Map<String, dynamic> json) => FileModel(
      cover: convertStringToUint8List(json['cover']),
      filename: json['filename'] as String,
    );

Map<String, dynamic> _$FileModelToJson(FileModel instance) => <String, dynamic>{
      'filename': instance.filename,
    };

Uint8List convertStringToUint8List(String str) {
  final Uint8List unit8List =  base64Decode(str);

  return unit8List;
}
