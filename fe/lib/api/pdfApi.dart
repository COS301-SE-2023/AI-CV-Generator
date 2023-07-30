import "package:file_picker/file_picker.dart";

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

  static Future<PlatformFile?> pick_imgfile() async {
    final res = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png','jpeg'],
      withData: true
    );
    if (res != null) {
      return res.files.first;
    }
    return null;
  }
}