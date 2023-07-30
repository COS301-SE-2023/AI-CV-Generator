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

  UserModel adjustedModel;
  CVData data;

  TemplateB({
    required this.adjustedModel,
    required this.data,
    super.key
  });

  @override
  State<StatefulWidget> createState() => TemplateBState();

  UserModel get adjusted => adjustedModel;
  CVData get cvdata => data;
}

class TemplateBState extends State<TemplateB> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Expanded(child: 
              Row(
                children: [
                  Expanded(
                    child: Container(
                      color: Colors.lightGreen.shade50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(widget.adjusted.fname + " " + widget.adjusted.lname, style: const TextStyle(fontSize: 32)),
                          SizedBox(height: 32),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(widget.adjusted.location??"Please provide Location!" + " | "),
                              Text(widget.adjusted.phoneNumber??"Please provide phone number!" + " | "),
                              Text(widget.adjusted.email??"Please provide email!"),
                            ]
                          )
                        ]
                      )
                      )
                  )
                ]
              )
            ),
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(32),
                child: Row(
                  children: [
                    Expanded( child:
                      Container(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Professional Summary", style: TextStyle(fontSize: 24, color: Colors.lightGreen,)),
                            const SizedBox(height: 8),
                            Text(widget.data.description!),

                            const SizedBox(height: 48),

                            const Text("Experience", style: TextStyle(fontSize: 24, color: Colors.lightGreen,)),
                            const SizedBox(height: 8),
                            Column(
                              children: [
                                ListView.builder(
                                  itemCount: widget.adjusted.employmenthistory!.length,
                                  itemBuilder: ((context, index) {
                                    return Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Text(widget.data.employmenthis![index]),
                                        ]
                                      )
                                    );
                                  }),
                                )
                              ]
                            ),

                            const SizedBox(height: 48),

                            const Text("Qualifications", style: TextStyle(fontSize: 24, color: Colors.lightGreen,)),
                            const SizedBox(height: 8),
                            Column(
                              children: [
                                ListView.builder(
                                  itemCount: widget.adjusted.qualifications!.length,
                                  itemBuilder: ((context, index) {
                                    return Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(widget.adjusted.qualifications![index].intstitution + " | "),
                                              Text(widget.adjusted.qualifications![index].date.year.toString() + " - "),
                                              Text(widget.adjusted.qualifications![index].endo.year.toString()),
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Text(widget.adjusted.qualifications![index].qualification),
                                          const SizedBox(height: 24),
                                        ]
                                      )
                                    );
                                  }),
                                ),
                                const SizedBox(height: 8),
                                Text(widget.data.education_description!)
                              ]
                            ),

                            const SizedBox(height: 48),

                            const Text("Links", style: TextStyle(fontSize: 24, color: Colors.lightGreen,)),
                            const SizedBox(height: 8),
                            Column(
                              children: [
                                ListView.builder(
                                  itemCount: widget.adjusted.links!.length,
                                  itemBuilder: ((context, index) {
                                    return Align(
                                      alignment: Alignment.centerLeft,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 8),
                                          Text(widget.adjusted.links![index].url),
                                          const SizedBox(height: 24),
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