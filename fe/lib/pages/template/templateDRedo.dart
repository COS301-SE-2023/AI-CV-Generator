import 'dart:typed_data';

import 'package:ai_cv_generator/models/aimodels/AIEmployment.dart';
import 'package:ai_cv_generator/models/aimodels/AILink.dart';
import 'package:ai_cv_generator/models/aimodels/AIQualification.dart';
import 'package:ai_cv_generator/models/aimodels/AIReference.dart';
import 'package:ai_cv_generator/models/aimodels/AISkill.dart';
import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:ai_cv_generator/pages/template/TemplateChoice.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class TemplateD {
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

  Uint8List templateD(CVData data, ColorSet colorSet) {
    //create the initial page
    document.pageSettings.margins.all = 15;
    pages.add(document.pages.add());
    //Get page client size
    Size pageSize = pages[currentPage].getClientSize();
    this.colorSet = colorSet;
    //set main regions for text
    Rect topBox = Rect.fromLTWH(0, 0, pageSize.width, 90);
    Rect leftBox = Rect.fromLTWH(0, topBox.bottom, pageSize.width/4, pageSize.height - topBox.height);
    Rect rightBox = Rect.fromLTWH(leftBox.width, topBox.bottom, pageSize.width/4*3, pageSize.height - topBox.height);

    //set recurring theme for document
    setTheme(
      document,
      Rect.fromLTWH(0, 0, pageSize.width/4, pageSize.height),
      Rect.fromLTWH(leftBox.width-8, 0, pageSize.width/4*3+16, pageSize.height)
    );

    // top
    pages[currentPage].graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(colorSet.colA!.red, colorSet.colA!.green, colorSet.colA!.blue,colorSet.colA!.alpha)),
      bounds: topBox
    );
    topBox = Rect.fromLTWH(topBox.left, topBox.top, topBox.width, topBox.height);
    drawNameSurname(pageSize, topBox, '${data.firstname??'First name'} ${data.lastname??'Last Name'}');

    //left
    pages[currentPage].graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(colorSet.colB!.red,colorSet.colB!.green,colorSet.colB!.blue,colorSet.colB!.alpha)),
      bounds: leftBox
    );
    leftBox = Rect.fromLTWH(leftBox.left+8, leftBox.top, leftBox.width-8, 0);
    leftBox = drawContactDetails(pageSize, leftBox, "${data.location??'Address'}\n\n${data.phoneNumber??'Phone Number'}\n\n${data.email??'Email'}").bounds;
    //lists must be at bottom for now
    if (data.skills != null && data.skills!.isNotEmpty) {
      leftBox = Rect.fromLTWH(leftBox.left, leftBox.top+16, leftBox.width, leftBox.height);
      pages[currentPage].graphics.drawLine(PdfPens.white, Offset(leftBox.left, leftBox.bottom), Offset(leftBox.width, leftBox.bottom));
      leftBox = drawSkills(pageSize, leftBox, data.skills!).bounds;
    }
    
    pages[currentPage].graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(colorSet.colC!.red, colorSet.colC!.green, colorSet.colC!.blue,colorSet.colC!.alpha)),
      bounds: rightBox
    );
    rightBox = Rect.fromLTWH(rightBox.left+8, rightBox.top, rightBox.width-16, 0);
    rightBox = drawDescription(pageSize, rightBox, data.description??'Description').bounds;
    if (data.employmenthistory != null && data.employmenthistory!.isNotEmpty) {
      rightBox = Rect.fromLTWH(rightBox.left, rightBox.top+16, rightBox.width, rightBox.height);
      pages[currentPage].graphics.drawLine(PdfPens.black, Offset(rightBox.left, rightBox.bottom), Offset(rightBox.width, rightBox.bottom));
      rightBox = drawExperience(pageSize, rightBox, data.employmenthistory!).bounds;
    }
    if (data.qualifications != null && data.qualifications!.isNotEmpty) {
      rightBox = Rect.fromLTWH(rightBox.left, rightBox.top+16, rightBox.width, rightBox.height);
      pages[currentPage].graphics.drawLine(PdfPens.black, Offset(rightBox.left, rightBox.bottom), Offset(rightBox.width, rightBox.bottom));
      rightBox = drawEducation(pageSize, rightBox, data.qualifications!).bounds;
    }
    if (data.references != null && data.references!.isNotEmpty) {
      rightBox = Rect.fromLTWH(rightBox.left, rightBox.top+16, rightBox.width, rightBox.height);
      pages[currentPage].graphics.drawLine(PdfPens.black, Offset(rightBox.left, rightBox.bottom), Offset(rightBox.width, rightBox.bottom));
      rightBox = drawReference(pageSize, rightBox, data.references!).bounds;
    }
    if (data.links != null && data.links!.isNotEmpty) {
      rightBox = Rect.fromLTWH(rightBox.left, rightBox.top+16, rightBox.width, rightBox.height);
      pages[currentPage].graphics.drawLine(PdfPens.black, Offset(rightBox.left, rightBox.bottom), Offset(rightBox.width, rightBox.bottom));
      rightBox = drawLinks(pageSize, rightBox, data.links!).bounds;
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

  

  void setTheme(PdfDocument document, Rect leftBox, Rect rightBox) {
    document.pages.pageAdded =(sender, args) {
      pages[currentPage] = args.page;
      args.page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(85, 144, 157)),
        bounds: leftBox
      );
      args.page.graphics.drawRectangle(
        brush: PdfSolidBrush(PdfColor(250, 250, 250)),
        bounds: rightBox
      );
    };
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
      PdfBrushes.white,
      PdfStandardFont(PdfFontFamily.helvetica, 30),
      PdfStringFormat(
        alignment: PdfTextAlignment.center,
        lineAlignment: PdfVerticalAlignment.middle
      ),
      bounds,
      data
    );
  }

  PdfLayoutResult drawContactDetails(Size pageSize, Rect bounds, String data) {
    bounds = addColorText(
      pageSize,
      PdfBrushes.white,
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, Rect.largest.height),
      "Contact Details"
    ).bounds;
    PdfLayoutResult result = addColorText(
      pageSize,
      PdfBrushes.white,
      bodyTextFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+8, bounds.width, Rect.largest.height),
      data
    );
    return result;
  }

  PdfLayoutResult drawDescription(Size pageSize, Rect bounds, String data) {
    bounds = addText(
      pageSize,
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, 0),
      "SUMMARY"
    ).bounds;
    PdfLayoutResult result =  addText(
      pageSize,
      bodyTextFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+8, bounds.width,Rect.largest.height),
      data
    );
    return result;
  }

  PdfLayoutResult drawExperience(Size pageSize, Rect bounds, List data) {
    PdfLayoutResult result = addText(
      pageSize,
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, Rect.largest.height),
      "EXPERIENCE"
    );

    for(AIEmployment employment in data) {
      result = addText(
        pageSize,
        bodyTextFont,
        PdfStringFormat(),
        Rect.fromLTWH(result.bounds.left, result.bounds.bottom+8, result.bounds.width, Rect.largest.height),
        "${employment.company}, ${employment.jobTitle}, ${employment.startDate} - ${employment.endDate}"
      );
    }
    return result;
  }

  PdfLayoutResult drawEducation(Size pageSize, Rect bounds, List data) {
    PdfLayoutResult result = addText(
      pageSize,
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, Rect.largest.height),
      "EDUCATION"
    );
    for(AIQualification qualification in data) {
      result = addText(
        pageSize,
        bodyTextFont,
        PdfStringFormat(),
        Rect.fromLTWH(result.bounds.left, result.bounds.bottom+8, result.bounds.width, Rect.largest.height),
        "${qualification.qualification}, ${qualification.institution}, ${qualification.startDate} - ${qualification.endDate}"
      );
    }
    return result;
  }

  PdfLayoutResult drawReference(Size pageSize, Rect bounds, List data) {
    PdfLayoutResult result = addText(
      pageSize,
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, Rect.largest.height),
      "REFERENCE"
    );
    for(AIReference reference in data) {
      result = addText(
        pageSize,
        bodyTextFont,
        PdfStringFormat(),
        Rect.fromLTWH(result.bounds.left, result.bounds.bottom+8, result.bounds.width, Rect.largest.height),
        "${reference.description} ${reference.contact}"
      );
    }
    return result;
  }
  PdfLayoutResult drawLinks(Size pageSize, Rect bounds, List data) {
    PdfLayoutResult result = addText(
      pageSize,
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, Rect.largest.height),
      "Links"
    );
    for(AILink link in data) {
      result = addText(
        pageSize,
        bodyTextFont,
        PdfStringFormat(),
        Rect.fromLTWH(result.bounds.left, result.bounds.bottom+8, result.bounds.width, Rect.largest.height),
        "${link.url}"
      );
    }
    return result;
  }

  PdfLayoutResult drawSkills(Size pageSize, Rect bounds, List data) {
    List<String> skills = [];
    for(AISkill skill in data)
    {
      skills.add('${skill.skill??'Skill'}: ${skill.level??'5'} / 5');
    }
    PdfLayoutResult result = addColorText(
      pageSize,
      PdfBrushes.white,
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, Rect.largest.height),
      "Core Qualifications"
    );
    Rect newbounds = Rect.fromLTWH(0, result.bounds.bottom+8, pageSize.width/3, 0);
    if (newbounds.top + PdfStandardFont(PdfFontFamily.helvetica,10).height >= 762) {
      bounds = addPage();
    }
    for(String skill in skills) {
      result = addColorText(
        pageSize,
        PdfBrushes.white,
        bodyHeadingFont,
        PdfStringFormat(),
        Rect.fromLTWH(result.bounds.left, result.bounds.bottom+8, result.bounds.width, Rect.largest.height),
        skill
      );
    }
    return result;
  }
}