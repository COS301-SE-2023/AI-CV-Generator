import 'dart:convert' as con;
//import 'dart:html' as html;
import "package:universal_html/html.dart" as html;

class DownloadService {
  static void download(
    List<int> bytes, {
    required String downloadName,
  }) {
    final base64 = con.base64Encode(bytes);
    final anchor =
        html.AnchorElement(href: 'data:application/octet-stream;base64,$base64')
          ..target = 'blank';
    anchor.download = downloadName;
    html.document.body!.append(anchor);
    anchor.click();
    anchor.remove();
    return;
  }
}