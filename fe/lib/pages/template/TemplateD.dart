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
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class TemplateD {
  //Create a PDF document.
  final PdfDocument document = PdfDocument();
  //Add page to the PDF
  //PdfPage? page;
  List<PdfPage> pages = [];
  int currentPage = 0;
  double lHeight = 762; // margin size top = 40
  double rhHeight = 762;
  late ColorSet colorSet;
  // double headingFontSize = 0;
  PdfStandardFont bodyHeadingFont = PdfStandardFont(PdfFontFamily.helvetica, 14);
  PdfStandardFont bodyTextFont = PdfStandardFont(PdfFontFamily.helvetica, 12);

  Uint8List templateD(CVData data, ColorSet colorSet) {
    //create the initial page
    pages.add(document.pages.add());
    //Get page client size
    Size pageSize = pages[currentPage].getClientSize();
    this.colorSet = colorSet;
    //set main regions for text
    Rect topBox = Rect.fromLTWH(0, 0, pageSize.width, 90);
    lHeight -=90;
    Rect leftBox = Rect.fromLTWH(0, topBox.bottom, pageSize.width/4, pageSize.height - topBox.height);
    rhHeight -= 90;
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
    drawNameSurname(pages[currentPage], pageSize, topBox, '${data.firstname??'First name'} ${data.lastname??'Last Name'}');

    //left
    pages[currentPage].graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(colorSet.colB!.red,colorSet.colB!.green,colorSet.colB!.blue,colorSet.colB!.alpha)),
      bounds: leftBox
    );
    leftBox = Rect.fromLTWH(leftBox.left+8, leftBox.top, leftBox.width-8, 0);
    leftBox = drawContactDetails(pages[currentPage], pageSize, leftBox, "${data.location??'Address'}\n\n${data.phoneNumber??'Phone Number'}\n\n${data.email??'Email'}").bounds;
    //lists must be at bottom for now
    leftBox = drawSkills(pages[currentPage], pageSize, leftBox, data.skills!).bounds;

    pages[currentPage].graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(colorSet.colC!.red, colorSet.colC!.green, colorSet.colC!.blue,colorSet.colC!.alpha)),
      bounds: rightBox
    );
    rightBox = Rect.fromLTWH(rightBox.left+8, rightBox.top, rightBox.width-16, 0);
    rightBox = drawDescription(pages[currentPage], pageSize, rightBox, data.description??'Description').bounds;
    if (data.employmenthistory != null && data.employmenthistory!.isNotEmpty) {
      rightBox = drawExperience(pages[currentPage], pageSize, rightBox, data.employmenthistory??[]).bounds;
    }
    if (data.qualifications != null && data.qualifications!.isNotEmpty) {
      rightBox = drawEducation(pages[currentPage], pageSize, rightBox, data.qualifications??[]).bounds;
    }
    if (data.references != null && data.references!.isNotEmpty) {
      rightBox = drawReference(pages[currentPage], pageSize, rightBox, data.references??[]).bounds;
    }
    if (data.links != null && data.links!.isNotEmpty) {
      rightBox = drawLinks(pages[currentPage], pageSize, rightBox, data.links??[]).bounds;
    }
    return Uint8List.fromList(document.saveSync());
  }

  Rect addPage() {
    pages.add(document.pages.add());
    currentPage++;
    Size pageSize = pages[currentPage].getClientSize();
    Rect leftBox = Rect.fromLTWH(0, 0, pageSize.width/4, pageSize.height);
    rhHeight -= 90;
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

  PdfLayoutResult addText(PdfPage page, Size pageSize, PdfFont contentFont, PdfStringFormat format, Rect bound, String text)
  {
    if (bound.top + bodyTextFont.height >= 762) {
      print('SetOff');
      bound = addPage();
    }
    return PdfTextElement(
      text: text, 
      font: contentFont,
      format: format
      ).draw(
        page: pages[currentPage],
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
        lineAlignment: PdfVerticalAlignment.middle
      ),
      bounds,
      data
    );
  }

  PdfLayoutResult drawContactDetails(PdfPage page, Size pageSize, Rect bounds, String data) {
    bounds = addText(
      page,
      pageSize,
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, 0),
      "Contact Details"
    ).bounds;
    PdfLayoutResult result = addText(
      page,
      pageSize,
      bodyTextFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+8, bounds.width, 0),
      data
    );
    lHeight -= result.bounds.bottom;
    return result;
  }

  PdfLayoutResult drawDescription(PdfPage page, Size pageSize, Rect bounds, String data) {
    bounds = addText(
      page,
      pageSize,
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, bodyHeadingFont.height),
      "SUMMARY"
    ).bounds;
    double height = (data.length*bodyTextFont.size)/bodyTextFont.height;
    PdfLayoutResult result =  addText(
      page,
      pageSize,
      bodyTextFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+8, bounds.width,0),
      data
    );
    print('Description: ${result.bounds.bottom}');
    return result;
  }

  PdfLayoutResult drawExperience(PdfPage page, Size pageSize, Rect bounds, List data) {
    PdfLayoutResult result = addText(
      page,
      pageSize,
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, bodyHeadingFont.height),
      "EXPERIENCE"
    );

    for(AIEmployment employment in data) {
      result = addText(
        page,
        pageSize,
        bodyTextFont,
        PdfStringFormat(),
        Rect.fromLTWH(result.bounds.left, result.bounds.bottom+8, result.bounds.width, bodyTextFont.height),
        "${employment.company}, ${employment.jobTitle}, ${employment.startDate} - ${employment.endDate}"
      );
    }
    print('Experience: ${result.bounds.bottom}');
    return result;
  }

  PdfLayoutResult drawEducation(PdfPage page, Size pageSize, Rect bounds, List data) {
    PdfLayoutResult result = addText(
      page,
      pageSize,
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, 0),
      "EDUCATION"
    );
    for(AIQualification qualification in data) {
      result = addText(
        page,
        pageSize,
        bodyTextFont,
        PdfStringFormat(),
        Rect.fromLTWH(result.bounds.left, result.bounds.bottom+8, result.bounds.width, 0),
        "${qualification.qualification}, ${qualification.institution}, ${qualification.startDate} - ${qualification.endDate}"
      );
    }
    return result;
  }

  PdfLayoutResult drawReference(PdfPage page, Size pageSize, Rect bounds, List data) {
    PdfLayoutResult result = addText(
      page,
      pageSize,
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, 0),
      "REFERENCE"
    );
    for(AIReference reference in data) {
      result = addText(
        page,
        pageSize,
        bodyTextFont,
        PdfStringFormat(),
        Rect.fromLTWH(result.bounds.left, result.bounds.bottom+8, result.bounds.width, 0),
        "${reference.description} ${reference.contact}"
      );
    }
    return result;
  }
  PdfLayoutResult drawLinks(PdfPage page, Size pageSize, Rect bounds, List data) {
    PdfLayoutResult result = addText(
      page,
      pageSize,
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, 0),
      "Links"
    );
    for(AILink link in data) {
      result = addText(
        page,
        pageSize,
        bodyTextFont,
        PdfStringFormat(),
        Rect.fromLTWH(result.bounds.left, result.bounds.bottom+8, result.bounds.width, 0),
        "${link.url}"
      );
    }
    return result;
  }

  PdfLayoutResult drawSkills(PdfPage page, Size pageSize, Rect bounds, List data) {
    List<String> skills = [];
    for(AISkill skill in data)
    {
      skills.add('${skill.skill??'Skill'} level => ${skill.level??'5'}');
    }
    final skillsList = PdfUnorderedList(
      marker: PdfUnorderedMarker(
          font: PdfStandardFont(PdfFontFamily.helvetica, 10),
          style: PdfUnorderedMarkerStyle.disk,
      ),
      items: PdfListItemCollection(
        skills
      ),
      textIndent: 5,
      indent: 10
    );

    PdfLayoutResult result  = addText(
      page,
      pageSize,
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+8, bounds.width, bounds.height),
      "SKILLS"
    );

    skillsList.draw(
      page: page,
      bounds: Rect.fromLTWH(0, result.bounds.bottom+8, pageSize.width/3, 0),
    );
    return result;
  }
}