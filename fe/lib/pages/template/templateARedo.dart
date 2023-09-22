import 'dart:io';
import 'dart:typed_data';

import 'package:ai_cv_generator/models/aimodels/AIEmployment.dart';
import 'package:ai_cv_generator/models/aimodels/AILink.dart';
import 'package:ai_cv_generator/models/aimodels/AIQualification.dart';
import 'package:ai_cv_generator/models/aimodels/AIReference.dart';
import 'package:ai_cv_generator/models/aimodels/AISkill.dart';
import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:ai_cv_generator/pages/template/TemplateChoice.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class TemplateA {
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

  Future<Uint8List> templateA(CVData data, ColorSet colorSet) async {

    //create the initial page
    document.pageSettings.margins.all = 15;
    pages.add(document.pages.add());
    //Get page client size
    Size pageSize = pages[currentPage].getClientSize();
    this.colorSet = colorSet;
    //set main regions for text
    
    Rect leftBox = Rect.fromLTWH(0, 0, pageSize.width/3, pageSize.height);
    Rect rightBox = Rect.fromLTWH(leftBox.width, 0, pageSize.width/3*2, pageSize.height);

    

    //left
    pages[currentPage].graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(colorSet.colA!.red,colorSet.colA!.green,colorSet.colA!.blue,colorSet.colA!.alpha)),
      bounds: leftBox
    );
    leftBox = Rect.fromLTWH(leftBox.left, leftBox.top +20, leftBox.width-8, leftBox.height);
    leftBox = drawNameSurname(pageSize, leftBox, '${data.firstname??'First name'}\n ${data.lastname??'Last Name'}\n').bounds;
    leftBox = Rect.fromLTWH(leftBox.left+8, leftBox.top, leftBox.width-8, leftBox.height);
    leftBox = drawContactDetails(pageSize, leftBox, "${data.location??'Address'}\n\n${data.phoneNumber??'Phone Number'}\n\n").bounds;
    //leftBox = Rect.fromLTWH(leftBox.left+8, leftBox.top-8, leftBox.width-8, leftBox.height);
    leftBox = (await drawEmail(pageSize, leftBox,data.email??'nate123@gmail.com')).bounds;
    //lists must be at bottom for now
    if (data.skills != null && data.skills!.isNotEmpty) {
      leftBox = drawSkills(pageSize, leftBox, data.skills!).bounds;
    }
    
    pages[currentPage].graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(colorSet.colB!.red, colorSet.colB!.green, colorSet.colB!.blue,colorSet.colB!.alpha)),
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
      PdfStandardFont(PdfFontFamily.helvetica, 15),
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

  Future<PdfLayoutResult> drawEmail(Size pageSize, Rect bounds, String email) async {
    bounds = Rect.fromLTWH(bounds.left, bounds.bottom, 50, 50);
    ByteData emailImg = await rootBundle.load('images/icons8-email-50.png');
    pages[currentPage].graphics.drawImage(PdfBitmap(emailImg.buffer.asUint8List(emailImg.offsetInBytes)), bounds);
    //bounds = Rect.fromLTWH(bounds.left, bounds.bottom, bounds.width, Rect.largest.height);
    return addColorText(
      pageSize, 
      PdfBrushes.white, 
      PdfStandardFont(PdfFontFamily.helvetica, 9), 
      PdfStringFormat(), 
      Rect.fromLTWH(bounds.left, bounds.bottom, bounds.width, Rect.largest.height), 
      email
    );
    
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
      pageSize,
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+8, bounds.width, bounds.height),
      "SKILLS"
    );
    Rect newbounds = Rect.fromLTWH(0, result.bounds.bottom+8, pageSize.width/3, 0);
    if (newbounds.top + PdfStandardFont(PdfFontFamily.helvetica,10).height >= 762) {
      bounds = addPage();
    }
    skillsList.draw(
      page: pages[currentPage],
      bounds: Rect.fromLTWH(0, result.bounds.bottom+8, pageSize.width/3, 0),
    );
    return result;
  }
}