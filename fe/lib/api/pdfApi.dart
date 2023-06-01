import "package:file_picker/file_picker.dart";
import "package:dio/dio.dart" as http;

class pdfAPI{
  static Future<PlatformFile?> pick_cvfile() async {
    final res = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      withData: true
    );
    if (res != null) {
      return res.files.first;
    }
    return null;
  }
}