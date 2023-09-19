import 'dart:typed_data';

import 'package:ai_cv_generator/pages/personaldetails2.dart';
import 'package:ai_cv_generator/pages/util/fileView.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

//Local imports
//import 'save_file_mobile.dart' if (dart.library.html) 'save_file_web.dart';

void main() {
  runApp(CreatePdfWidget());
}

/// Represents the PDF widget class.
class CreatePdfWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CreatePdfStatefulWidget(),
    );
  }
}

/// Represents the PDF stateful widget class.
class CreatePdfStatefulWidget extends StatefulWidget {
  /// Initalize the instance of the [CreatePdfStatefulWidget] class.
  const CreatePdfStatefulWidget({Key? key}) : super(key: key);

  @override
  _CreatePdfState createState() => _CreatePdfState();
}

class _CreatePdfState extends State<CreatePdfStatefulWidget> {
  TextEditingController fullnameC = TextEditingController();
  TextEditingController addressC = TextEditingController();
  TextEditingController phonenumberC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController descriptC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create PDF document'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.lightBlue,
                disabledForegroundColor: Colors.grey,
              ),
              onPressed: templateD,
              child: const Text('Generate PDF'),
            )
          ],
        ),
      ),
    );
  }
  TextEditingController controller = TextEditingController(text: "INVOICE");
  Future<void> templateD() async {
    //Create a PDF document.
    final PdfDocument document = PdfDocument();
    //Add page to the PDF
    final PdfPage page = document.pages.add();
    //Get page client size
    final Size pageSize = page.getClientSize();

    Rect topPane = Rect.fromLTWH(0, -90, pageSize.width, 90);
    Rect leftPane = Rect.fromLTWH(8, -pageSize.height+90, pageSize.width/4-8, pageSize.height);
    Rect rightPane = Rect.fromLTWH(pageSize.width/4 + 8, 0, pageSize.width/4*3 + 8, 90);

    page.graphics.drawRectangle(
      bounds: Rect.fromLTWH(0, 0, pageSize.width, pageSize.height),
      pen: PdfPen(PdfColor(0, 0, 0))
    );
    page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(56, 92, 100)),
      bounds: Rect.fromLTWH(0, 0, pageSize.width, 90)
    );
    page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(85, 144, 157)),
      bounds: Rect.fromLTWH(0, 90, pageSize.width/4, pageSize.height - 90)
    );
    page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(255, 255, 255)),
      bounds: Rect.fromLTWH(pageSize.width/4, 90, pageSize.width/4*3-1, pageSize.height - 90-1)
    );

    drawNameSurname(page, pageSize, topPane, "Name Surname");
    PdfLayoutResult resultLeft = drawContactDetails(page, pageSize, leftPane, "Contact Details");
    drawSkills(page, pageSize, resultLeft.bounds, []);

    
    PdfLayoutResult resultRight = drawDescription(page, pageSize, rightPane, "");
    resultRight = drawExperience(page, pageSize, resultRight.bounds, []);
    resultRight = drawEducation(page, pageSize, resultRight.bounds, []);
    resultRight = drawReference(page, pageSize, resultRight.bounds, []);
    final List<int> bytes = document.saveSync();
    
    showDialog(
      context: context, 
      builder: (context) {
        Size screenSize = MediaQuery.of(context).size;
      double w = screenSize.width/100;
      double h = screenSize.height/100;
        return SizedBox(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                }, 
                icon: const Icon(Icons.arrow_back,color: Colors.white,)
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(w*1),
                    width: 1000,
                    height: 1000,
                    child: SfPdfViewer.memory(
                      Uint8List.fromList(bytes),
                      pageSpacing: 8
                    ),
                  ),
                ],
              ),
            ),
          )
        );
      }
    );
  }

  PdfLayoutResult addText(PdfPage page, Size pageSize, PdfFont contentFont, PdfStringFormat format, Rect bound, String text)
  {
    final Size contentSize = contentFont.measureString(text);
    return PdfTextElement(
      text: text, 
      font: contentFont,
      format: format
      ).draw(
        page: page,
        bounds: bound,
      )!;
  }

  PdfLayoutResult drawNameSurname(PdfPage page, Size pageSize, Rect bounds, String data) {
    return addText(
      page,
      pageSize,
      PdfStandardFont(PdfFontFamily.helvetica, 30),
      PdfStringFormat(
        alignment: PdfTextAlignment.center,
        // lineAlignment: PdfVerticalAlignment.middle
      ),
      Rect.fromLTWH(bounds.left, bounds.bottom+8, bounds.width, bounds.height),
      data
    );
  }

  PdfLayoutResult drawContactDetails(PdfPage page, Size pageSize, Rect bounds, String data) {
    return addText(
      page,
      pageSize,
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+8, bounds.width, bounds.height),
      data
    );
  }

  PdfLayoutResult drawDescription(PdfPage page, Size pageSize, Rect bounds, String data) {
    bounds = addText(
      page,
      pageSize,
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+8, bounds.width, bounds.height),
      "SUMMARY"
    ).bounds;
    return addText(
      page,
      pageSize,
      PdfStandardFont(PdfFontFamily.helvetica, 11),
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+8, bounds.width, bounds.height),
      data
    );
  }

  PdfLayoutResult drawExperience(PdfPage page, Size pageSize, Rect bounds, List data) {
    bounds = addText(
      page,
      pageSize,
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+8, bounds.width, bounds.height),
      "EXPERIENCE"
    ).bounds;
    return addText(
      page,
      pageSize,
      PdfStandardFont(PdfFontFamily.helvetica, 11),
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+8, bounds.width, bounds.height),
      ""
    );
  }

  PdfLayoutResult drawEducation(PdfPage page, Size pageSize, Rect bounds, List data) {
    bounds = addText(
      page,
      pageSize,
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+8, bounds.width, bounds.height),
      "EDUCATION"
    ).bounds;
    return addText(
      page,
      pageSize,
      PdfStandardFont(PdfFontFamily.helvetica, 11),
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+8,
          bounds.width, bounds.height),
      ""
    );
  }

  PdfLayoutResult drawReference(PdfPage page, Size pageSize, Rect bounds, List data) {
    bounds = addText(
      page,
      pageSize,
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+8, bounds.width, bounds.height),
      "REFERENCE"
    ).bounds;
    return addText(
      page,
      pageSize,
      PdfStandardFont(PdfFontFamily.helvetica, 11),
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+8,
          bounds.width, bounds.height),
      ""
    );
  }

  drawSkills(PdfPage page, Size pageSize, Rect bounds, List data) {
    final skillsList = PdfUnorderedList(
      marker: PdfUnorderedMarker(
          font: PdfStandardFont(PdfFontFamily.helvetica, 10),
          style: PdfUnorderedMarkerStyle.disk,
      ),
      items: PdfListItemCollection(
        <String>[
          'SKILL 1',
          'SKILL 2',
          'SKILL 3',
          'SKILL 4',
          'SKILL 5',
        ]
      ),
      textIndent: 10,
      indent: 20
    );

    bounds = addText(
      page,
      pageSize,
      PdfStandardFont(PdfFontFamily.helvetica, 12),
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+8, bounds.width, bounds.height),
      "SKILLS"
    ).bounds;

    skillsList.draw(
      page: page,
      bounds: Rect.fromLTWH(0, bounds.bottom+8, pageSize.width/3, pageSize.height - 90),
    );
  }
}