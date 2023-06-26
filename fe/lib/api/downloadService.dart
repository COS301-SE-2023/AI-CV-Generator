import 'dart:convert' as con;
import 'dart:html' as html;

class DownloadService {
  static void download(
    List<int> bytes, {
    required String downloadName,
  }) {
    final _base64 = con.base64Encode(bytes);
    final anchor =
        html.AnchorElement(href: 'data:application/octet-stream;base64,$_base64')
          ..target = 'blank';
    if (downloadName != null) {
      anchor.download = downloadName;
    }
    html.document.body!.append(anchor);
    anchor.click();
    anchor.remove();
    return;
  }
}