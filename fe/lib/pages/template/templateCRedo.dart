import 'package:ai_cv_generator/models/aimodels/AIEmployment.dart';
import 'package:ai_cv_generator/models/aimodels/AILink.dart';
import 'package:ai_cv_generator/models/aimodels/AIQualification.dart';
import 'package:ai_cv_generator/models/aimodels/AIReference.dart';
import 'package:ai_cv_generator/models/aimodels/AISkill.dart';
import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:ai_cv_generator/pages/template/TemplateChoice.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class TemplateC {
  //Create a PDF document.
  final PdfDocument document = PdfDocument();
  //Add page to the PDF
  //PdfPage? page;
  List<PdfPage> pages = [];
  int currentPage = 0;
  late ColorSet colorSet;
  // double headingFontSize = 0;
  PdfStandardFont bodyHeadingFont = PdfStandardFont(PdfFontFamily.helvetica, 16);
  PdfStandardFont bodyTextFont = PdfStandardFont(PdfFontFamily.helvetica, 12);

  Uint8List templateC(CVData data, ColorSet colorSet) {

    //create the initial page
    document.pageSettings.margins.all = 15;
    pages.add(document.pages.add());
    //Get page client size
    Size pageSize = pages[currentPage].getClientSize();
    this.colorSet = colorSet;
    //set main regions for text
    Rect leftBox = Rect.fromLTWH(0, 0, pageSize.width, pageSize.height);

    pages[currentPage].graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(colorSet.colA!.red,colorSet.colA!.green,colorSet.colA!.blue,colorSet.colA!.alpha)),
      bounds: Rect.fromLTWH(0, 0, leftBox.width, 90),
    );
    leftBox = Rect.fromLTWH(leftBox.left+8, leftBox.top+8, leftBox.width-8, leftBox.height);
    leftBox = drawNameSurname(pageSize, leftBox, '${data.firstname??'First name'} ${data.lastname??'Last Name'}').bounds;
    leftBox = Rect.fromLTWH(leftBox.left, leftBox.top+10, leftBox.width-8, leftBox.height);
    leftBox = drawContactDetails(pageSize, leftBox, "${data.location??'Address'} | ${data.phoneNumber??'Phone Number'} | ${data.email??'nate123@gmail.com'}\n\n").bounds;
    if (data.skills != null && data.skills!.isNotEmpty) {
      leftBox = drawSkills(pageSize, leftBox, data.skills!).bounds;
    }
    
    leftBox = Rect.fromLTWH(leftBox.left, leftBox.top+20, leftBox.width-16, 0);
    leftBox = drawDescription(pageSize, leftBox, data.description??'Description').bounds;
    // leftBox = Rect.fromLTWH(leftBox.left, leftBox.top, leftBox.width, leftBox.height);
    if (data.employmenthistory != null && data.employmenthistory!.isNotEmpty) {
      leftBox = drawExperience(pageSize, leftBox, data.employmenthistory!).bounds;
    }
    if (data.qualifications != null && data.qualifications!.isNotEmpty) {
      leftBox = drawEducation(pageSize, leftBox, data.qualifications!).bounds;
    }
    if (data.references != null && data.references!.isNotEmpty) {
      leftBox = drawReference(pageSize, leftBox, data.references!).bounds;
    }
    if (data.links != null && data.links!.isNotEmpty) {
      leftBox = drawLinks(pageSize, leftBox, data.links!).bounds;
    }
    return Uint8List.fromList(document.saveSync());
  }

  Rect addPage() {
    pages.add(document.pages.add());
    currentPage++;
    Size pageSize = pages[currentPage].getClientSize();
    Rect leftBox = Rect.fromLTWH(0, 0, pageSize.width, pageSize.height);
    return leftBox;
  }

  PdfLayoutResult addText(Size pageSize, PdfFont contentFont, PdfStringFormat format, Rect bound, String text)
  {
    return PdfTextElement(
      text: text, 
      font: contentFont,
      format: format
      ).draw(
        page: pages[currentPage],
        bounds: bound,
      )!;
  }

  PdfLayoutResult addColorText(Size pageSize,PdfBrush brush ,PdfFont contentFont, PdfStringFormat format, Rect bound, String text) {
    return PdfTextElement(
      text: text,
      font: contentFont,
      format: format,
      brush: brush
    ).draw(
      page: pages[currentPage],
      bounds: bound
    )!;
  }

  PdfLayoutResult drawNameSurname(Size pageSize, Rect bounds, String data) {
    return addColorText(
      pageSize,
      PdfSolidBrush(PdfColor(colorSet.colB!.red,colorSet.colB!.green,colorSet.colB!.blue,colorSet.colB!.alpha)),
      PdfStandardFont(PdfFontFamily.helvetica, 30),
      PdfStringFormat(
        alignment: PdfTextAlignment.center,
        // lineAlignment: PdfVerticalAlignment.top
      ),
      bounds,
      data
    );
  }

  PdfLayoutResult drawContactDetails(Size pageSize, Rect bounds, String data) {
    PdfLayoutResult result = addColorText(
      pageSize,
      PdfSolidBrush(PdfColor(colorSet.colB!.red,colorSet.colB!.green,colorSet.colB!.blue,colorSet.colB!.alpha)),
      bodyTextFont,
      PdfStringFormat(
        alignment: PdfTextAlignment.center,
      ),
      Rect.fromLTWH(bounds.left, bounds.bottom+8, bounds.width, Rect.largest.height),
      data
    );
    return result;
  }

  PdfLayoutResult drawEmail(Size pageSize, Rect bounds, String email) {
    PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 9);
    pages[currentPage].graphics.drawLine(PdfPens.darkBlue,Offset(bounds.left, bounds.bottom+font.height/2),Offset(bounds.left + 10, bounds.bottom+font.height/2));
    return addColorText(
      pageSize, 
      PdfBrushes.darkBlue, 
      font, 
      PdfStringFormat(), 
      Rect.fromLTWH(bounds.left+15, bounds.bottom, bounds.width, Rect.largest.height), 
      email
    );
    
  }

  PdfLayoutResult drawDescription(Size pageSize, Rect bounds, String data) {
    bounds = addColorText(
      pageSize,
      PdfSolidBrush(PdfColor(colorSet.colC!.red,colorSet.colC!.green,colorSet.colC!.blue,colorSet.colC!.alpha)), 
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, 0),
      "PROFESSIONAL SUMMARY"
    ).bounds;
    PdfLayoutResult result =  addColorText(
      pageSize,
      PdfSolidBrush(PdfColor(colorSet.colD!.red,colorSet.colD!.green,colorSet.colD!.blue,colorSet.colD!.alpha)), 
      bodyTextFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+8, bounds.width,Rect.largest.height),
      data
    );
    return result;
  }

  PdfLayoutResult drawExperience(Size pageSize, Rect bounds, List data) {
    PdfLayoutResult result = addColorText(
      pageSize,
      PdfSolidBrush(PdfColor(colorSet.colC!.red,colorSet.colC!.green,colorSet.colC!.blue,colorSet.colC!.alpha)), 
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, Rect.largest.height),
      "EXPERIENCE"
    );
    for(AIEmployment employment in data) {
      result = addColorText(
        pageSize,
        PdfSolidBrush(PdfColor(colorSet.colD!.red,colorSet.colD!.green,colorSet.colD!.blue,colorSet.colD!.alpha)), 
        bodyTextFont,
        PdfStringFormat(),
        Rect.fromLTWH(result.bounds.left, result.bounds.bottom+8, result.bounds.width, Rect.largest.height),
        "${employment.company}, ${employment.jobTitle}, ${employment.startDate} - ${employment.endDate}"
      );
    }
    return result;
  }

  PdfLayoutResult drawEducation(Size pageSize, Rect bounds, List data) {
    PdfLayoutResult result = addColorText(
      pageSize,
      PdfSolidBrush(PdfColor(colorSet.colC!.red,colorSet.colC!.green,colorSet.colC!.blue,colorSet.colC!.alpha)), 
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, Rect.largest.height),
      "EDUCATION"
    );
    for(AIQualification qualification in data) {
      result = addColorText(
        pageSize,
        PdfSolidBrush(PdfColor(colorSet.colD!.red,colorSet.colD!.green,colorSet.colD!.blue,colorSet.colD!.alpha)), 
        bodyTextFont,
        PdfStringFormat(),
        Rect.fromLTWH(result.bounds.left, result.bounds.bottom+8, result.bounds.width, Rect.largest.height),
        "${qualification.qualification}, ${qualification.institution}, ${qualification.startDate} - ${qualification.endDate}"
      );
    }
    return result;
  }

  PdfLayoutResult drawReference(Size pageSize, Rect bounds, List data) {
    PdfLayoutResult result = addColorText(
      pageSize,
      PdfSolidBrush(PdfColor(colorSet.colC!.red,colorSet.colC!.green,colorSet.colC!.blue,colorSet.colC!.alpha)), 
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, Rect.largest.height),
      "REFERENCE"
    );
    for(AIReference reference in data) {
      result = addColorText(
        pageSize,
        PdfSolidBrush(PdfColor(colorSet.colD!.red,colorSet.colD!.green,colorSet.colD!.blue,colorSet.colD!.alpha)), 
        bodyTextFont,
        PdfStringFormat(),
        Rect.fromLTWH(result.bounds.left, result.bounds.bottom+8, result.bounds.width, Rect.largest.height),
        "${reference.description} ${reference.contact}"
      );
    }
    return result;
  }
  PdfLayoutResult drawLinks(Size pageSize, Rect bounds, List data) {
    PdfLayoutResult result = addColorText(
      pageSize,
      PdfSolidBrush(PdfColor(colorSet.colC!.red,colorSet.colC!.green,colorSet.colC!.blue,colorSet.colC!.alpha)), 
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, Rect.largest.height),
      "LINKS"
    );
    for(AILink link in data) {
      result = addColorText(
        pageSize,
        PdfSolidBrush(PdfColor(colorSet.colD!.red,colorSet.colD!.green,colorSet.colD!.blue,colorSet.colD!.alpha)), 
        bodyTextFont,
        PdfStringFormat(),
        Rect.fromLTWH(result.bounds.left, result.bounds.bottom+8, result.bounds.width, Rect.largest.height),
        "${link.url}"
      );
    }
    return result;
  }

  PdfLayoutResult drawSkills(Size pageSize, Rect bounds, List data) {
    PdfLayoutResult result  = addColorText(
      pageSize,
      PdfSolidBrush(PdfColor(colorSet.colC!.red,colorSet.colC!.green,colorSet.colC!.blue,colorSet.colC!.alpha)), 
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+8, bounds.width, bounds.height),
      "CORE QUALIFICATIONS"
    );
    for (AISkill skill in data) {
      result = addColorText(
        pageSize, 
        PdfSolidBrush(PdfColor(colorSet.colD!.red,colorSet.colD!.green,colorSet.colD!.blue,colorSet.colD!.alpha)),  
        PdfStandardFont(PdfFontFamily.helvetica, 12), 
        PdfStringFormat(), 
        Rect.fromLTWH(result.bounds.left, result.bounds.bottom+8, result.bounds.width, Rect.largest.height), 
        '${skill.skill}: ${skill.level??'5'} / 5'
      );
    }
    return result;
  }
}