import 'dart:typed_data';
import 'package:json_annotation/json_annotation.dart';

class Uint8ListConverter implements JsonConverter<Uint8List, List<int>> {
  const Uint8ListConverter();

  @override
  Uint8List fromJson(List<int> json) {
    if (json == null) {
      return Uint8List(0);
    }

    return Uint8List.fromList(json);
  }

  @override
  List<int> toJson(Uint8List object) {
    if (object == null) {
      return List.empty();
    }

    return object.toList();
  }
}