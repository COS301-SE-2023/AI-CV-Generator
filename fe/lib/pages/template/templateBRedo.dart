import 'package:ai_cv_generator/models/aimodels/AIEmployment.dart';
import 'package:ai_cv_generator/models/aimodels/AILink.dart';
import 'package:ai_cv_generator/models/aimodels/AIQualification.dart';
import 'package:ai_cv_generator/models/aimodels/AIReference.dart';
import 'package:ai_cv_generator/models/aimodels/AISkill.dart';
import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:ai_cv_generator/pages/template/TemplateChoice.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class TemplateB {
  //Create a PDF document.
  final PdfDocument document = PdfDocument();
  //Add page to the PDF
  //PdfPage? page;
  List<PdfPage> pages = [];
  int currentPage = 0;
  late ColorSet colorSet;
  // double headingFontSize = 0;
  PdfStandardFont bodyHeadingFont = PdfStandardFont(PdfFontFamily.helvetica, 14);
  PdfStandardFont bodyTextFont = PdfStandardFont(PdfFontFamily.helvetica, 12);

  Uint8List templateB(CVData data, ColorSet colorSet) {

    //create the initial page
    document.pageSettings.margins.all = 15;
    pages.add(document.pages.add());
    //Get page client size
    Size pageSize = pages[currentPage].getClientSize();
    this.colorSet = colorSet;
    //set main regions for text
    Rect topBox = Rect.fromLTWH(0, 0, pageSize.width, 110);
    Rect leftBox = Rect.fromLTWH(0, topBox.bottom+10, (pageSize.width/2) -1, pageSize.height -110);
    Rect rightBox = Rect.fromLTWH(leftBox.width+2, topBox.bottom+10, (pageSize.width/2) -1, pageSize.height -110);
    pages[currentPage].graphics.drawRectangle(bounds: Rect.fromLTWH(pageSize.width/2-1, topBox.bottom+20, 10, pageSize.height-10),brush: PdfBrushes.gray);
    pages[currentPage].graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(colorSet.colA!.red,colorSet.colA!.green,colorSet.colA!.blue,colorSet.colA!.alpha)),
      bounds: topBox
    );
    
    //left
    pages[currentPage].graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(colorSet.colB!.red,colorSet.colB!.green,colorSet.colB!.blue,colorSet.colB!.alpha)),
      bounds: leftBox
    );
    
    topBox = Rect.fromLTWH(topBox.left, topBox.top+20, topBox.width-8, topBox.height);
    topBox = drawNameSurname(pageSize, topBox, '${data.firstname??'First name'}\n ${data.lastname??'Last Name'}\n').bounds;
    leftBox = Rect.fromLTWH(leftBox.left, leftBox.top, leftBox.width-8, leftBox.height);
    leftBox = drawNameSurname(pageSize, leftBox, '').bounds;
    leftBox = drawContactDetails(pageSize, leftBox, "- ${data.location??'Address'}\n\n- ${data.phoneNumber??'Phone Number'}\n\n- ${data.email??'nate123@gmail.com'}").bounds;
    leftBox = Rect.fromLTWH(leftBox.left, leftBox.top+30, leftBox.width, leftBox.height);
    if (data.skills != null && data.skills!.isNotEmpty) {
      leftBox = drawSkills(pageSize, leftBox, data.skills!).bounds;
    }
    leftBox = Rect.fromLTWH(leftBox.left, leftBox.top+30, leftBox.width, leftBox.height);
    pages[currentPage].graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(colorSet.colC!.red, colorSet.colC!.green, colorSet.colC!.blue,colorSet.colC!.alpha)),
      bounds: rightBox
    );
    rightBox = Rect.fromLTWH(rightBox.left+8, rightBox.top, rightBox.width-16, 0);
    rightBox = drawDescription(pageSize, rightBox, data.description??'Description').bounds;
    if (data.employmenthistory != null && data.employmenthistory!.isNotEmpty) {
      rightBox = drawExperience(pageSize, rightBox, data.employmenthistory!).bounds;
    }
    if (data.qualifications != null && data.qualifications!.isNotEmpty) {
      rightBox = drawEducation(pageSize, rightBox, data.qualifications!).bounds;
    }
    if (data.references != null && data.references!.isNotEmpty) {
      rightBox = drawReference(pageSize, rightBox, data.references!).bounds;
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
    Rect leftBox = Rect.fromLTWH(0, 0, pageSize.width/4, pageSize.height);
    Rect rightBox = Rect.fromLTWH(leftBox.width, 0, pageSize.width/4*3, pageSize.height);
    pages[currentPage].graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(colorSet.colB!.red,colorSet.colB!.green,colorSet.colB!.blue,colorSet.colB!.alpha)),
      bounds: leftBox
    );
    pages[currentPage].graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(colorSet.colC!.red, colorSet.colC!.green, colorSet.colC!.blue,colorSet.colC!.alpha)),
      bounds: rightBox
    );
    rightBox = Rect.fromLTWH(rightBox.left+8, rightBox.top, rightBox.width-16, 0);
    return rightBox;
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
      PdfSolidBrush(PdfColor(colorSet.colD!.red, colorSet.colD!.blue,colorSet.colD!.green, colorSet.colD!.alpha)),
      PdfStandardFont(PdfFontFamily.helvetica, 30),
      PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.top
      ),
      bounds,
      data
    );
  }

  PdfLayoutResult drawContactDetails(Size pageSize, Rect bounds, String data) {
    bounds = addColorText(
      pageSize,
      PdfSolidBrush(PdfColor(colorSet.colE!.red, colorSet.colE!.blue, colorSet.colE!.green,colorSet.colE!.alpha)),
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, Rect.largest.height),
      "Personal Details"
    ).bounds;
    pages[currentPage].graphics.drawLine(PdfPen(PdfColor(colorSet.colE!.red, colorSet.colE!.green, colorSet.colE!.blue,colorSet.colE!.alpha)),Offset(bounds.left+110, bounds.bottom-bodyHeadingFont.height/2),Offset(bounds.right-10, bounds.bottom-bodyHeadingFont.height/2));
    PdfLayoutResult result = addColorText(
      pageSize,
      PdfSolidBrush(PdfColor(colorSet.colE!.red, colorSet.colE!.blue, colorSet.colE!.green,colorSet.colE!.alpha)),
      bodyTextFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+8, bounds.width, Rect.largest.height),
      data
    );
    return result;
  }

  PdfLayoutResult drawEmail(Size pageSize, Rect bounds, String email) {
    PdfFont font = PdfStandardFont(PdfFontFamily.helvetica, 9);
    pages[currentPage].graphics.drawLine(PdfPen(PdfColor(colorSet.colF!.red, colorSet.colF!.green, colorSet.colF!.blue,colorSet.colF!.alpha)),Offset(bounds.left, bounds.bottom+font.height/2),Offset(bounds.left + 10, bounds.bottom+font.height/2));
    return addColorText(
      pageSize, 
      PdfBrushes.white, 
      font, 
      PdfStringFormat(), 
      Rect.fromLTWH(bounds.left+15, bounds.bottom, bounds.width, Rect.largest.height), 
      email
    );
    
  }

  PdfLayoutResult drawDescription(Size pageSize, Rect bounds, String data) {
    bounds = addColorText(
      pageSize,
      PdfSolidBrush(PdfColor(colorSet.colF!.red, colorSet.colF!.green, colorSet.colF!.blue, colorSet.colF!.alpha)),
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, 0),
      "SUMMARY"
    ).bounds;
    pages[currentPage].graphics.drawLine(PdfPen(PdfColor(colorSet.colF!.red, colorSet.colF!.green, colorSet.colF!.blue,colorSet.colF!.alpha)),Offset(bounds.left+80, bounds.bottom-bodyHeadingFont.height/2),Offset(bounds.right-10, bounds.bottom-bodyHeadingFont.height/2));
    PdfLayoutResult result =  addColorText(
      pageSize,
      PdfSolidBrush(PdfColor(colorSet.colF!.red, colorSet.colF!.green, colorSet.colF!.blue, colorSet.colF!.alpha)),
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
      PdfSolidBrush(PdfColor(colorSet.colF!.red, colorSet.colF!.green, colorSet.colF!.blue, colorSet.colF!.alpha)),
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, Rect.largest.height),
      "EXPERIENCE"
    );
    pages[currentPage].graphics.drawLine(PdfPen(PdfColor(colorSet.colF!.red, colorSet.colF!.green, colorSet.colF!.blue,colorSet.colF!.alpha)),Offset(result.bounds.left+100, result.bounds.bottom-bodyHeadingFont.height/2),Offset(result.bounds.right-10, result.bounds.bottom-bodyHeadingFont.height/2));
    for(AIEmployment employment in data) {
      result = addColorText(
        pageSize,
        PdfSolidBrush(PdfColor(colorSet.colF!.red, colorSet.colF!.green, colorSet.colF!.blue, colorSet.colF!.alpha)),
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
      PdfSolidBrush(PdfColor(colorSet.colF!.red, colorSet.colF!.green, colorSet.colF!.blue, colorSet.colF!.alpha)),
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, Rect.largest.height),
      "Qualifications / Certifications"
    );
    pages[currentPage].graphics.drawLine(PdfPen(PdfColor(colorSet.colF!.red, colorSet.colF!.green, colorSet.colF!.blue,colorSet.colF!.alpha)),Offset(result.bounds.left+190, result.bounds.bottom-bodyHeadingFont.height/2),Offset(result.bounds.right-10, result.bounds.bottom-bodyHeadingFont.height/2));
    for(AIQualification qualification in data) {
      result = addColorText(
        pageSize,
        PdfSolidBrush(PdfColor(colorSet.colF!.red, colorSet.colF!.green, colorSet.colF!.blue, colorSet.colF!.alpha)),
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
      PdfSolidBrush(PdfColor(colorSet.colF!.red, colorSet.colF!.green, colorSet.colF!.blue, colorSet.colF!.alpha)),
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, Rect.largest.height),
      "REFERENCE"
    );
    pages[currentPage].graphics.drawLine(PdfPen(PdfColor(colorSet.colF!.red, colorSet.colF!.green, colorSet.colF!.blue,colorSet.colF!.alpha)),Offset(result.bounds.left+100, result.bounds.bottom-bodyHeadingFont.height/2),Offset(result.bounds.right-10, result.bounds.bottom-bodyHeadingFont.height/2));
    for(AIReference reference in data) {
      result = addColorText(
        pageSize,
        PdfSolidBrush(PdfColor(colorSet.colF!.red, colorSet.colF!.green, colorSet.colF!.blue, colorSet.colF!.alpha)),
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
      PdfSolidBrush(PdfColor(colorSet.colE!.red, colorSet.colE!.green, colorSet.colE!.blue,colorSet.colE!.alpha)),
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, Rect.largest.height),
      "Links"
    );
    pages[currentPage].graphics.drawLine(PdfPen(PdfColor(colorSet.colE!.red, colorSet.colE!.green, colorSet.colE!.blue,colorSet.colE!.alpha)),Offset(result.bounds.left+40, result.bounds.bottom-bodyHeadingFont.height/2),Offset(result.bounds.right-10, result.bounds.bottom-bodyHeadingFont.height/2));
    for(AILink link in data) {
      result = addColorText(
        pageSize,
        PdfSolidBrush(PdfColor(colorSet.colE!.red, colorSet.colE!.green, colorSet.colE!.blue,colorSet.colE!.alpha)),
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
      PdfSolidBrush(PdfColor(colorSet.colE!.red, colorSet.colE!.green, colorSet.colE!.blue,colorSet.colE!.alpha)),
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+8, bounds.width, bounds.height),
      "Skills"
    );
    pages[currentPage].graphics.drawLine(PdfPens.gray,Offset(result.bounds.left+60, result.bounds.bottom-bodyHeadingFont.height/2),Offset(result.bounds.right-10, result.bounds.bottom-bodyHeadingFont.height/2));
    for (AISkill skill in data) {
      result = addColorText(
        pageSize, 
        PdfSolidBrush(PdfColor(colorSet.colE!.red, colorSet.colE!.green, colorSet.colE!.blue,colorSet.colE!.alpha)),
        PdfStandardFont(PdfFontFamily.helvetica, 14), 
        PdfStringFormat(), 
        Rect.fromLTWH(result.bounds.left, result.bounds.bottom+15, result.bounds.width, Rect.largest.height), 
        '${skill.skill}'
      );
      int level = int.parse(skill.level!);
      double sum = (result.bounds.right - 10) - (result.bounds.left);
      double good = ((level/5) * sum);
      double bad = (((5-level)/5) * sum);
      pages[currentPage].graphics.drawRectangle(bounds: Rect.fromLTWH(result.bounds.left, result.bounds.bottom+4, good, 5),brush: PdfSolidBrush(PdfColor(colorSet.colA!.red, colorSet.colA!.green, colorSet.colA!.blue,colorSet.colA!.alpha)));
      pages[currentPage].graphics.drawRectangle(bounds: Rect.fromLTWH(result.bounds.left+good, result.bounds.bottom+4, bad, 5),brush: PdfSolidBrush(PdfColor(colorSet.colG!.red, colorSet.colG!.green, colorSet.colG!.blue,colorSet.colG!.alpha)));
    }
    return result;
  }
}