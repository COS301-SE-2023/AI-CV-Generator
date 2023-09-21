import 'dart:typed_data';

import 'package:ai_cv_generator/models/aimodels/AIEmployment.dart';
import 'package:ai_cv_generator/models/aimodels/AILink.dart';
import 'package:ai_cv_generator/models/aimodels/AIQualification.dart';
import 'package:ai_cv_generator/models/aimodels/AIReference.dart';
import 'package:ai_cv_generator/models/aimodels/AISkill.dart';
import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class TemplateD {
  //Create a PDF document.
  final PdfDocument document = PdfDocument();
  //Add page to the PDF
  PdfPage? page;
  // double headingFontSize = 0;
  PdfStandardFont bodyHeadingFont = PdfStandardFont(PdfFontFamily.helvetica, 14);
  PdfStandardFont bodyTextFont = PdfStandardFont(PdfFontFamily.helvetica, 12);

  Uint8List templateD(CVData data, ColorSet colorSet) {

    //create the initial page
    page = document.pages.add();
    //Get page client size
    final Size pageSize = page!.getClientSize();

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
    page!.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(colorSet.colA!.red, colorSet.colA!.green, colorSet.colA!.blue,colorSet.colA!.alpha)),
      bounds: topBox
    );
    topBox = Rect.fromLTWH(topBox.left, topBox.top, topBox.width, topBox.height);
    drawNameSurname(page!, pageSize, topBox, '${data.firstname??'First name'} ${data.lastname??'Last Name'}');

    //left
    page!.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(colorSet.colB!.red,colorSet.colB!.green,colorSet.colB!.blue,colorSet.colB!.alpha)),
      bounds: leftBox
    );
    leftBox = Rect.fromLTWH(leftBox.left+8, leftBox.top, leftBox.width-8, 0);
    leftBox = drawContactDetails(page!, pageSize, leftBox, "${data.location??'Address'}\n\n${data.phoneNumber??'Phone Number'}\n\n${data.email??'Email'}").bounds;
    //lists must be at bottom for now
    leftBox = drawSkills(page!, pageSize, leftBox, data.skills!).bounds;

    //right
    page!.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(colorSet.colC!.red, colorSet.colC!.green, colorSet.colC!.blue,colorSet.colC!.alpha)),
      bounds: rightBox
    );
    rightBox = Rect.fromLTWH(rightBox.left+8, rightBox.top, rightBox.width-16, 0);
    rightBox = drawDescription(page!, pageSize, rightBox, data.description??'Description').bounds;
    rightBox = drawExperience(page!, pageSize, rightBox, data.employmenthistory??[]).bounds;
    rightBox = drawEducation(page!, pageSize, rightBox, data.qualifications??[]).bounds;
    rightBox = drawReference(page!, pageSize, rightBox, data.references??[]).bounds;
    rightBox = drawLinks(page!, pageSize, rightBox, data.links??[]).bounds;
    return Uint8List.fromList(document.saveSync());
  }

  void setTheme(PdfDocument document, Rect leftBox, Rect rightBox) {
    document.pages.pageAdded =(sender, args) {
      page = args.page;
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
    return addText(
      page,
      pageSize,
      bodyTextFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+8, bounds.width, 0),
      data
    );
  }

  PdfLayoutResult drawDescription(PdfPage page, Size pageSize, Rect bounds, String data) {
    bounds = addText(
      page,
      pageSize,
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, 0),
      "SUMMARY"
    ).bounds;
    return addText(
      page,
      pageSize,
      bodyTextFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+8, bounds.width, 0),
      data
    );
  }

  PdfLayoutResult drawExperience(PdfPage page, Size pageSize, Rect bounds, List data) {
    PdfLayoutResult result = addText(
      page,
      pageSize,
      bodyHeadingFont,
      PdfStringFormat(),
      Rect.fromLTWH(bounds.left, bounds.bottom+16, bounds.width, 0),
      "EXPERIENCE"
    );
    for(AIEmployment employment in data) {
      result = addText(
        page,
        pageSize,
        bodyTextFont,
        PdfStringFormat(),
        Rect.fromLTWH(result.bounds.left, result.bounds.bottom+8, result.bounds.width, 0),
        "${employment.company}, ${employment.jobTitle}, ${employment.startDate} - ${employment.endDate}"
      );
    }
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

enum TemplateOption {
  templateA,
  templateB,
  templateC,
  templateD,
  templateE
}

class ColorSet {
  Color? colA;
  Color? colB;
  Color? colC;
  Color? colD;
  Color? colE;

  ColorSet({
    this.colA,
    this.colB,
    this.colC,
    this.colD,
    this.colE
  });

  setColorSetTemplateChoice(TemplateOption option) {
    switch (option) {
      case TemplateOption.templateA:
      setColorSetA();
      case TemplateOption.templateB:
      setColorSetB();
      case TemplateOption.templateC:
      setColorSetC();
      case TemplateOption.templateD:
      setColorSetD();
      case TemplateOption.templateE:
      setColorSetE();
    }
  }

  setColorSetA() {
    colA = Colors.blue;
    colB = Colors.green;
  }

  setColorSetB() {

  }

  setColorSetC() {

  }

  setColorSetD() {
    colA = const Color.fromRGBO(56, 92, 100,1);
    colB = const Color.fromRGBO(85, 144, 157,1);
    colC = const Color.fromRGBO(250, 250, 250, 1);
    colD = null;
    colE = null;
  }

  setColorSetE() {

  }

  getAmount() {
    int count = 0;
    if (colA != null) count++;
    if (colB != null) count++;
    if (colC != null) count++;
    if (colD != null) count++;
    if (colE != null) count++;
    return count;
  }
}

Future<Uint8List> templateChoice(CVData data, TemplateOption option, ColorSet colors) async {
  switch(option) {
    case TemplateOption.templateA:
    return TemplateD().templateD(data,colors);
    case TemplateOption.templateB:
    return TemplateD().templateD(data,colors);
    case TemplateOption.templateC:
    return TemplateD().templateD(data,colors);
    case TemplateOption.templateD:
    return TemplateD().templateD(data,colors);
    case TemplateOption.templateE:
    return TemplateD().templateD(data,colors);
  }
}
