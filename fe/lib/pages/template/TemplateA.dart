import 'dart:typed_data';
import 'package:ai_cv_generator/dio/response/GenerationResponses/MockGenerationResponse.dart';
import 'package:ai_cv_generator/models/generation/CVData.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:ai_cv_generator/pages/template/userData.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../widgets/pdf_window.dart';

// Ui counter part for pdf
class TemplateA extends StatefulWidget {
  const TemplateA({super.key, required this.user, required this.data});
  // final MockGenerationResponse data;
  final UserModel user;
  final   CVData data;
  
  @override
  State<StatefulWidget> createState() => TemplateAState();
}

class TemplateAState extends State<TemplateA> {
  @override
  void initState() {
    UserData.user = widget.user;
    UserData.data = widget.data;

    UserData.nameC.text = UserData.user!.fname + " " + UserData.user!.lname;
    UserData.detailsC.text = (UserData.user!.location??"Please provide Location!") + " | " +
    (UserData.user!.phoneNumber??"Please provide phone number!") + " | " +
    (UserData.user!.email??"Please provide email!");
    UserData.descriptionHeadingC.text = "Professional Summary";
    UserData.employmentHeadingC.text = "Experience";
    UserData.qualificationHeadingC.text = "Qualifications";
    UserData.linksHeadingC.text = "Links";
    UserData.descriptionC.text = UserData.data!.description!;
    for(int i = 0; i < UserData.user!.employmenthistory!.length; i++) {
      UserData.employmentC.text += UserData.user!.employmenthistory![i].company + " | "
      + UserData.user!.employmenthistory![i].startdate.year.toString() + " - "
      + UserData.user!.employmenthistory![i].enddate.year.toString() + " | " + UserData.user!.employmenthistory![i].title + "\n\n" + UserData.data!.employmenthis![i] + "\n\n";
    }

    for(int i = 0; i < UserData.user!.qualifications!.length; i++) {
      UserData.qualificationC.text += UserData.user!.qualifications![i].intstitution + " | "
      + UserData.user!.qualifications![i].date.year.toString() + " - "
      + UserData.user!.qualifications![i].endo.year.toString() + " | " + UserData.user!.qualifications![i].qualification + "\n\n";
    }
    UserData.qualificationC.text += UserData.data!.education_description!;
    
    for(int i = 0; i < UserData.user!.links!.length; i++) {
      UserData.linksC.text += UserData.user!.links![i].url + "\n";
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [
            Expanded(
              child:Container(
                height: 300,
                color: Colors.lightGreenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFieldInput(controller: UserData.nameC, fontSize: 32, textAlign: TextAlign.center,),
                    SizedBox(height: 32),
                    TextFieldInput(controller: UserData.detailsC, textAlign: TextAlign.center,),
                      
                  ]
                )
              )
            ),

          ],
        ),
          Padding(
            padding: EdgeInsets.all(32),
            child: Row(
              children: [
                Expanded( child:
                  Container(
                    alignment: Alignment.topLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFieldInput(controller: UserData.descriptionHeadingC, fontSize: 24, textAlign: TextAlign.left, color: Colors.lightGreen),
                        SizedBox(height: 16),
                        TextFieldInput(controller: UserData.descriptionC, fontSize: 14, textAlign: TextAlign.left, maxLines: 6,),
                        
                        SizedBox(height: 48),
                        TextFieldInput(controller: UserData.employmentHeadingC, fontSize: 24, textAlign: TextAlign.left, color: Colors.lightGreen,),
                        SizedBox(height: 16),
                        TextFieldInput(controller: UserData.employmentC, fontSize: 14, textAlign: TextAlign.left, maxLines: 6,),

                        SizedBox(height: 48),
                        TextFieldInput(controller: UserData.qualificationHeadingC, fontSize: 24, textAlign: TextAlign.left, color: Colors.lightGreen),
                        SizedBox(height: 16),
                        TextFieldInput(controller: UserData.qualificationC, fontSize: 14, textAlign: TextAlign.left, maxLines: 6,),

                        SizedBox(height: 16),
                        TextFieldInput(controller: UserData.linksHeadingC, fontSize: 24, textAlign: TextAlign.left, color: Colors.lightGreen),
                        SizedBox(height: 8),
                        TextFieldInput(controller: UserData.linksC, fontSize: 14, textAlign: TextAlign.left, maxLines: 6,),
                      ]
                    )
                  )
                )
              ]
            )
          )
      ],
    );
  }
}

class TextFieldInput extends StatefulWidget {
  TextFieldInput({super.key, required this.controller, this.fontSize, this.textAlign, this.color, this.maxLines});
  final TextEditingController controller;
  double? fontSize = 16.0;
  TextAlign? textAlign = TextAlign.center;
  Color? color;
  int? maxLines = 1;

  @override
  TextFieldInputState createState() => TextFieldInputState();
}

class TextFieldInputState extends State<TextFieldInput> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: widget.maxLines,
      controller: widget.controller,
      textAlign: widget.textAlign!,
      style: TextStyle(
        color: widget.color,
        fontSize: widget.fontSize
      ),
      decoration: 
      InputDecoration(
        isDense: true,
        contentPadding: EdgeInsets.zero,
        border: InputBorder.none
      ),
    );
  }
}

// Pdf
class TemplateAPdf {
  final pdf = pw.Document();
  final double fontText = 13;
  final double fontHeading = 24;
  final double fontSubHeading = 16;
  final pw.Widget relatedSpacing = pw.SizedBox(height: 8);
  final pw.Widget unRelatedSpacing = pw.SizedBox(height: 16);

  void writeOnPdf() async {
    pdf.addPage(
     pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Expanded(child: 
              pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Container(
                      color: PdfColors.lightGreen50,
                      child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Text(UserData.nameC.text, style: pw.TextStyle(fontSize: 32)),
                          pw.SizedBox(height: 32),
                          pw.Text(UserData.detailsC.text)
                        ]
                      )
                      )
                  )
                ]
              )
            ),
            pw.Expanded(
              flex: 5,
              child: pw.Padding(
                padding: pw.EdgeInsets.all(32),
                child: pw.Row(
                  children: [
                    pw.Expanded( child:
                      pw.Container(
                        alignment: pw.Alignment.topLeft,
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Text(UserData.descriptionHeadingC.text, style: pw.TextStyle(fontSize: 24, color: PdfColors.lightGreen200,)),
                            pw.SizedBox(height: 8),
                            pw.Text(UserData.descriptionC.text),

                            pw.SizedBox(height: 48),

                            pw.Text(UserData.employmentHeadingC.text, style: pw.TextStyle(fontSize: 24, color: PdfColors.lightGreen200,)),
                            pw.SizedBox(height: 8),
                            pw.Column(
                              children: [
                                pw.Text(UserData.employmentC.text)
                              ]
                            ),

                            pw.SizedBox(height: 48),

                            pw.Text(UserData.qualificationHeadingC.text, style: pw.TextStyle(fontSize: 24, color: PdfColors.lightGreen200,)),
                            pw.SizedBox(height: 8),
                            pw.Column(
                              children: [
                                pw.Text(UserData.qualificationC.text)
                              ]
                            ),

                            pw.SizedBox(height: 48),

                            pw.Text(UserData.linksC.text, style: pw.TextStyle(fontSize: 24, color: PdfColors.lightGreen200,)),
                            pw.SizedBox(height: 8),
                            pw.Column(
                              children: [
                                pw.Text(UserData.linksC.text)
                              ]
                            ),
                          ]
                        )
                      )
                    )
                  ]
                )
              )
            ),
          ];
        }
     )
    );
  }
  Future<PlatformFile> getPdf() async {
      Uint8List bytes = await pdf.save();
      PlatformFile? file = PlatformFile(name: "gen.pdf", size: bytes.length,bytes: bytes);
      return file;
  }

  showPdf(BuildContext context) {
    getPdf().then((file) {
      showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: PdfWindow(file: file,)
          );
        });
    },);
  }
}