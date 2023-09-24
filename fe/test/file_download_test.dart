//import 'package:ai_cv_generator/api/downloadService.dart';
import 'package:flutter_test/flutter_test.dart'; // Import your DownloadService class
//import 'package:flutter/services.dart'; // Import for loading assets

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Test downloadPdf method', () async {
    /*// Load the test PDF file from the assets
    final ByteData pdfByteData = await rootBundle.load('assets/Resume 1.pdf');
    final List<int> pdfBytes = pdfByteData.buffer.asUint8List();
    
    // Define the download parameters
    const String pdfFileName = 'Resume 1.pdf';

    // Call the downloadPdf method
    //await DownloadService.downloadPdf(pdfBytes, downloadName: pdfFileName, mimeType: 'application/pdf');

    // You can add assertions here to verify the download behavior if needed
    // For example, you can check if the file was downloaded or check its content.

    // Please note that testing file download behavior can be complex and may
    // require additional setup depending on your testing environment.*/
  });
}
