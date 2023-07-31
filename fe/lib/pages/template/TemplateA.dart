import 'dart:typed_data';

import 'package:ai_cv_generator/dio/response/GenerationResponses/MockGenerationResponse.dart';
import 'package:ai_cv_generator/models/generation/CVData.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../widgets/pdf_window.dart';

TextEditingController fnameC = TextEditingController();
TextEditingController lnameC = TextEditingController();
TextEditingController emailC = TextEditingController();
TextEditingController locationC = TextEditingController();
TextEditingController phoneNumberC = TextEditingController();
UserModel? user;
CVData? data;

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
    user = widget.user;
    data = widget.data;
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
                    Text(user!.fname + " " + user!.lname, style: TextStyle(fontSize: 32)),
                    SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text((user!.location??"Please provide Location!") + " | "),
                        Text((user!.phoneNumber??"Please provide phone number!") + " | "),
                        Text((user!.email??"Please provide email!")),
                      ]
                    ),
                      
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
                        Text("Professional Summary", style: TextStyle(fontSize: 24, color: Colors.lightGreen)),
                        SizedBox(height: 8),
                        Text(data!.description!),

                        SizedBox(height: 48),
                        Text("Experience", style: TextStyle(fontSize: 24, color: Colors.lightGreen,)),
                        SizedBox(height: 8),
                        Column(
                          children: [
                            Container(
                              height: 200,
                              child: ListView.builder(
                              // itemCount: user!.employmenthistory!.length,
                              itemCount: data!.employmenthis!.length,
                              itemBuilder: ((context, index) {
                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          // Text(user!.employmenthistory![index].title + " | "),
                                          // Text(user!.employmenthistory![index].startdate.year.toString() + " - "),
                                          // Text(user!.employmenthistory![index].enddate.year.toString()),
                                          Text(data!.employmenthis![index])
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Text(user!.employmenthistory![index].company),
                                      SizedBox(height: 24),
                                    ]
                                  )
                                );
                              }),
                            ),
                            ),
                          ]
                        ),

                        SizedBox(height: 8),

                        Text("Qualifications", style: TextStyle(fontSize: 24, color: Colors.lightGreen,)),
                        SizedBox(height: 8),
                        Column(
                          children: [
                            Text(data!.education_description!),
                            SizedBox(height: 16),
                            Container(
                              height: 100,
                              child:
                            ListView.builder(
                              itemCount: user!.qualifications!.length,
                              itemBuilder: ((context, index) {
                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(user!.qualifications![index].intstitution + " | "),
                                          Text(user!.qualifications![index].date.year.toString() + " - "),
                                          Text(user!.qualifications![index].endo.year.toString()),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Text(user!.qualifications![index].qualification),
                                      
                                    ]
                                  )
                                );
                              }),
                            )
                          ),

                          SizedBox(height: 8),
                          
                          ]
                        ),

                        SizedBox(height: 16),

                        Text("Links", style: TextStyle(fontSize: 24, color: Colors.lightGreen,)),
                        SizedBox(height: 8),
                        Column(
                          children: [
                            Container(
                              height: 200,
                              child: ListView.builder(
                                itemCount: user!.links!.length,
                                itemBuilder: ((context, index) {
                                  return Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 8),
                                        Text(user!.links![index].url),
                                        SizedBox(height: 24),
                                      ]
                                    )
                                  );
                                }),
                              )
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
      ],
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

  void writeOnPdf(UserModel user) async {
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
                          pw.Text(user!.fname + " " + user!.lname, style: pw.TextStyle(fontSize: 32)),
                          pw.SizedBox(height: 32),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text(user!.location! + " | "),
                              pw.Text(user!.phoneNumber! + " | "),
                              pw.Text(user!.email!),
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
                            pw.Text(user.description!),

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
                                          pw.Row(
                                            children: [
                                              pw.Text(user.employmenthistory![index].title + " | "),
                                              pw.Text(user.employmenthistory![index].startdate.year.toString() + " - "),
                                              pw.Text(user.employmenthistory![index].enddate.year.toString()),
                                            ],
                                          ),
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
                                )
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