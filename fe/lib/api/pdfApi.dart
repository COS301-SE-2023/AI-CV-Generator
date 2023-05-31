import "dart:io";
import "package:http/http.dart" as http;
import "package:flutter/services.dart";
import "package:path/path.dart";
import "package:path_provider/path_provider.dart";

class pdfAPI{
  static Future<File> loadNet(String url) async {
    final resp = await http.get(url as Uri);
    final bytes = resp.bodyBytes;
    return _storFile(url,bytes);
  }

  static Future<File> _storFile(String url, List<int> bytes) async {
    final filName = basename(url);
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/$filName');
    await file.writeAsBytes(bytes,flush: true);
    return file;
  }
}