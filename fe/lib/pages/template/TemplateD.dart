import 'dart:typed_data';

import 'package:ai_cv_generator/models/aimodels/AIEmployment.dart';
import 'package:ai_cv_generator/models/aimodels/AILink.dart';
import 'package:ai_cv_generator/models/aimodels/AIQualification.dart';
import 'package:ai_cv_generator/models/aimodels/AIReference.dart';
import 'package:ai_cv_generator/models/aimodels/AISkill.dart';
import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:ai_cv_generator/models/user/Employment.dart';
import 'package:ai_cv_generator/models/user/Link.dart';
import 'package:ai_cv_generator/models/user/Qualification.dart';
import 'package:ai_cv_generator/models/user/Reference.dart';
import 'package:ai_cv_generator/models/user/Skill.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
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

class TemplateTemp {
  //Create a PDF document.
  final PdfDocument document = PdfDocument();
  //Add page to the PDF
  PdfPage? page;
  // double headingFontSize = 0;
  PdfStandardFont bodyHeadingFont = PdfStandardFont(PdfFontFamily.helvetica, 14);
  PdfStandardFont bodyTextFont = PdfStandardFont(PdfFontFamily.helvetica, 8);

  Future<Uint8List> templateD(CVData data) async {
    String description = data.description??'Description';
    String name = '${data.firstname??'First name'} ${data.lastname??'Last Name'}';
    String number = data.phoneNumber??'Phone Number';
    String address = data.location??'Address';
    String email = data.email??'Email';

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
      brush: PdfSolidBrush(PdfColor(56, 92, 100)),
      bounds: topBox
    );
    topBox = Rect.fromLTWH(topBox.left, topBox.top, topBox.width, topBox.height);
    drawNameSurname(page!, pageSize, topBox, name);

    //left
    page!.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(85, 144, 157)),
      bounds: leftBox
    );
    leftBox = Rect.fromLTWH(leftBox.left+8, leftBox.top, leftBox.width-8, 0);
    leftBox = drawContactDetails(page!, pageSize, leftBox, "${address}\n\n${number}\n\n${email}").bounds;
    //lists must be at bottom for now
    leftBox = drawSkills(page!, pageSize, leftBox, data.skills!).bounds;

    //right
    page!.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(250, 250, 250)),
      bounds: rightBox
    );
    rightBox = Rect.fromLTWH(rightBox.left+8, rightBox.top, rightBox.width-16, 0);
    rightBox = drawDescription(page!, pageSize, rightBox, description).bounds;
    rightBox = drawExperience(page!, pageSize, rightBox, data.employmenthistory??[]).bounds;
    rightBox = drawEducation(page!, pageSize, rightBox, data.qualifications??[]).bounds;
    rightBox = drawReference(page!, pageSize, rightBox, data.references??[]).bounds;
    rightBox = drawLinks(page!, pageSize, rightBox, data.links??[]).bounds;

    final List<int> bytes = document.saveSync();
    
    // showDialog(
    //   context: context, 
    //   builder: (context) {
    //     Size screenSize = MediaQuery.of(context).size;
    //   double w = screenSize.width/100;
    //   double h = screenSize.height/100;
    //     return SizedBox(
    //       child: Scaffold(
    //         backgroundColor: Colors.transparent,
    //         extendBodyBehindAppBar: true,
    //         appBar: AppBar(
    //           backgroundColor: Colors.transparent,
    //           elevation: 0,
    //           leading: IconButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //             }, 
    //             icon: const Icon(Icons.arrow_back,color: Colors.white,)
    //           ),
    //         ),
    //         body: SingleChildScrollView(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Container(
    //                 alignment: Alignment.center,
    //                 padding: EdgeInsets.all(w*1),
    //                 width: 1000,
    //                 height: 1000,
    //                 child: SfPdfViewer.memory(
    //                   Uint8List.fromList(bytes),
    //                   pageSpacing: 8
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       )
    //     );
    //   }
    // );
    return Uint8List.fromList(bytes);
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

/// Represents the PDF stateful widget class.
class CreatePdfStatefulWidget extends StatefulWidget {
  /// Initalize the instance of the [CreatePdfStatefulWidget] class.
  const CreatePdfStatefulWidget({Key? key}) : super(key: key);

  @override
  _CreatePdfState createState() => _CreatePdfState();
}

class _CreatePdfState extends State<CreatePdfStatefulWidget> {
  //Create a PDF document.
  final PdfDocument document = PdfDocument();
  //Add page to the PDF
  PdfPage? page;
  // double headingFontSize = 0;
  PdfStandardFont bodyHeadingFont = PdfStandardFont(PdfFontFamily.helvetica, 14);
  PdfStandardFont bodyTextFont = PdfStandardFont(PdfFontFamily.helvetica, 8);

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

  Future<Uint8List> templateD() async {
    String description = "BodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfTextBodyOfText";
    String name = "Avery Quinn";
    String number = "0823451286";
    String address = "Pretoria, Gauteng";
    String email = "Avery@Gmail.com";

    List<Qualification>? qualifications = [];
    qualifications.add(Qualification(qualification: "BSC IT", intstitution: "University of Pretoria", date: DateTime.now(), quaid: 0, endo: DateTime.now()));
    qualifications.add(Qualification(qualification: "BSC IT", intstitution: "University of Johannesburg", date: DateTime.now(), quaid: 0, endo: DateTime.now()));

    List<Employment>? employments = [];
    employments.add(Employment(company: "KPMG", title: "Accountant", startdate: DateTime.now(), enddate: DateTime.now(), empid: 0));
    employments.add(Employment(company: "EY", title: "Intern", startdate: DateTime.now(), enddate: DateTime.now(), empid: 0));

    List<Skill>? skills = [];
    skills.add(Skill(skill: "MongoDB", level: 0, reason: "Training", skillid: 0));
    skills.add(Skill(skill: "C#", level: 0, reason: "Training", skillid: 0));
    skills.add(Skill(skill: "C++", level: 0, reason: "Training", skillid: 0));
    
    List<Reference> reference = [];
    reference.add(Reference(description: "David Bill", contact: "billd@gmail.com", refid: 0));
    reference.add(Reference(description: "Tammy Toll", contact: "tollt@gmail.com", refid: 0));
    
    List<Link> links = [];
    links.add(Link(url: "www.gmail.com", linkid: 0));
    links.add(Link(url: "www.yahoo.com", linkid: 0));

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
      brush: PdfSolidBrush(PdfColor(56, 92, 100)),
      bounds: topBox
    );
    topBox = Rect.fromLTWH(topBox.left, topBox.top, topBox.width, topBox.height);
    drawNameSurname(page!, pageSize, topBox, name);

    //left
    page!.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(85, 144, 157)),
      bounds: leftBox
    );
    leftBox = Rect.fromLTWH(leftBox.left+8, leftBox.top, leftBox.width-8, 0);
    leftBox = drawContactDetails(page!, pageSize, leftBox, "${address}\n\n${number}\n\n${email}").bounds;
    //lists must be at bottom for now
    leftBox = drawSkills(page!, pageSize, leftBox, skills).bounds;

    //right
    page!.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor(250, 250, 250)),
      bounds: rightBox
    );
    rightBox = Rect.fromLTWH(rightBox.left+8, rightBox.top, rightBox.width-16, 0);
    rightBox = drawDescription(page!, pageSize, rightBox, description).bounds;
    rightBox = drawExperience(page!, pageSize, rightBox, employments).bounds;
    rightBox = drawEducation(page!, pageSize, rightBox, qualifications).bounds;
    rightBox = drawReference(page!, pageSize, rightBox, reference).bounds;
    rightBox = drawLinks(page!, pageSize, rightBox, links).bounds;

    final List<int> bytes = document.saveSync();
    
    // showDialog(
    //   context: context, 
    //   builder: (context) {
    //     Size screenSize = MediaQuery.of(context).size;
    //   double w = screenSize.width/100;
    //   double h = screenSize.height/100;
    //     return SizedBox(
    //       child: Scaffold(
    //         backgroundColor: Colors.transparent,
    //         extendBodyBehindAppBar: true,
    //         appBar: AppBar(
    //           backgroundColor: Colors.transparent,
    //           elevation: 0,
    //           leading: IconButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //             }, 
    //             icon: const Icon(Icons.arrow_back,color: Colors.white,)
    //           ),
    //         ),
    //         body: SingleChildScrollView(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               Container(
    //                 alignment: Alignment.center,
    //                 padding: EdgeInsets.all(w*1),
    //                 width: 1000,
    //                 height: 1000,
    //                 child: SfPdfViewer.memory(
    //                   Uint8List.fromList(bytes),
    //                   pageSpacing: 8
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       )
    //     );
    //   }
    // );
    return Uint8List.fromList(bytes);
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
    for(Employment employment in data) {
      String startDate = DateFormat('MMM yyyy').format(employment.startdate);
      String endDate = DateFormat('MMM yyyy').format(employment.enddate);
      result = addText(
        page,
        pageSize,
        bodyTextFont,
        PdfStringFormat(),
        Rect.fromLTWH(result.bounds.left, result.bounds.bottom+8, result.bounds.width, 0),
        "${employment.company}, ${employment.title}, ${startDate} - ${endDate}"
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
    for(Qualification qualification in data) {
      result = addText(
        page,
        pageSize,
        bodyTextFont,
        PdfStringFormat(),
        Rect.fromLTWH(result.bounds.left, result.bounds.bottom+8, result.bounds.width, 0),
        "${qualification.qualification}, ${qualification.intstitution}, ${qualification.date.year} - ${qualification.endo.year}"
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
    for(Reference reference in data) {
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
    for(Link link in data) {
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
    for(Skill skill in data)
    {
      skills.add(skill.skill);
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