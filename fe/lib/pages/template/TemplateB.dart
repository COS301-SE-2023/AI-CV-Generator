import 'dart:typed_data';

import 'package:ai_cv_generator/models/generation/CVData.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:ai_cv_generator/pages/widgets/pdf_window.dart';

// Ui counter part for pdf
class TemplateB extends StatefulWidget {
  const TemplateB({super.key});

  @override
  State<StatefulWidget> createState() => TemplateBState();
}

class TemplateBState extends State<TemplateB> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          
        ],
      ),
    );
  }
}

// Pdf
class TemplateBPdf {
  final pdf = pw.Document();
  final double fontText = 13;
  final double fontHeading = 24;
  final double fontSubHeading = 16;
  final pw.Widget relatedSpacing = pw.SizedBox(height: 8);
  final pw.Widget unRelatedSpacing = pw.SizedBox(height: 16);

  Future<void> writeOnPdf(UserModel user, CVData data) async {
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
                          pw.Text(user.fname + " " + user.lname, style: pw.TextStyle(fontSize: 32)),
                          pw.SizedBox(height: 32),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text(user.location??"Please provide Location!" + " | "),
                              pw.Text(user.phoneNumber??"Please provide phone number!" + " | "),
                              pw.Text(user.email??"Please provide email!"),
                            ]
                          )
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
                            pw.Text("Professional Summary", style: pw.TextStyle(fontSize: 24, color: PdfColors.lightGreen200,)),
                            pw.SizedBox(height: 8),
                            pw.Text(data.description!),

                            pw.SizedBox(height: 48),

                            pw.Text("Experience", style: pw.TextStyle(fontSize: 24, color: PdfColors.lightGreen200,)),
                            pw.SizedBox(height: 8),
                            pw.Column(
                              children: [
                                pw.ListView.builder(
                                  itemCount: user.employmenthistory!.length,
                                  itemBuilder: ((context, index) {
                                    return pw.Align(
                                      alignment: pw.Alignment.centerLeft,
                                      child: pw.Column(
                                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                        children: [
                                          pw.Text(data.employmenthis![index]),
                                          pw.SizedBox(height: 8),
                                          pw.Text(user.employmenthistory![index].company),
                                          pw.SizedBox(height: 24),
                                        ]
                                      )
                                    );
                                  }),
                                )
                              ]
                            ),

                            pw.SizedBox(height: 48),

                            pw.Text("Qualifications", style: pw.TextStyle(fontSize: 24, color: PdfColors.lightGreen200,)),
                            pw.SizedBox(height: 8),
                            pw.Column(
                              children: [
                                pw.ListView.builder(
                                  itemCount: user.qualifications!.length,
                                  itemBuilder: ((context, index) {
                                    return pw.Align(
                                      alignment: pw.Alignment.centerLeft,
                                      child: pw.Column(
                                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                        children: [
                                          pw.Row(
                                            children: [
                                              pw.Text(user.qualifications![index].intstitution + " | "),
                                              pw.Text(user.qualifications![index].date.year.toString() + " - "),
                                              pw.Text(user.qualifications![index].endo.year.toString()),
                                            ],
                                          ),
                                          pw.SizedBox(height: 8),
                                          pw.Text(user.qualifications![index].qualification),
                                          pw.SizedBox(height: 24),
                                        ]
                                      )
                                    );
                                  }),
                                ),
                                pw.SizedBox(height: 8),
                                pw.Text(data.education_description!)
                              ]
                            ),

                            pw.SizedBox(height: 48),

                            pw.Text("Links", style: pw.TextStyle(fontSize: 24, color: PdfColors.lightGreen200,)),
                            pw.SizedBox(height: 8),
                            pw.Column(
                              children: [
                                pw.ListView.builder(
                                  itemCount: user.links!.length,
                                  itemBuilder: ((context, index) {
                                    return pw.Align(
                                      alignment: pw.Alignment.centerLeft,
                                      child: pw.Column(
                                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                        children: [
                                          pw.SizedBox(height: 8),
                                          pw.Text(user.links![index].url),
                                          pw.SizedBox(height: 24),
                                        ]
                                      )
                                    );
                                  }),
                                )
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