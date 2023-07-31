import 'dart:typed_data';
import 'package:ai_cv_generator/dio/response/GenerationResponses/MockGenerationResponse.dart';
import 'package:ai_cv_generator/models/generation/CVData.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../widgets/pdf_window.dart';
import 'TemplateA.dart';

// Ui counter part for pdf
class TemplateB extends StatefulWidget {
  const TemplateB({super.key, required this.user, required this.data});
  // final MockGenerationResponse data;
  final UserModel user;
  final   CVData data;
  
  @override
  State<StatefulWidget> createState() => TemplateBState();
}

class TemplateBState extends State<TemplateB> {
  @override
  void initState() {
    UserData.user = widget.user;
    UserData.data = widget.data;
    UserData.set();
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
                color: Colors.blue,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(UserData.user!.fname + " " + UserData.user!.lname, style: TextStyle(fontSize: 32)),
                    SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text((UserData.user!.location??"Please provide Location!") + " | "),
                        Text((UserData.user!.phoneNumber??"Please provide phone number!") + " | "),
                        Text((UserData.user!.email??"Please provide email!")),
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
                        Text(UserData.data!.description!),

                        SizedBox(height: 48),
                        Text("Experience", style: TextStyle(fontSize: 24, color: Colors.lightGreen,)),
                        SizedBox(height: 8),
                        Column(
                          children: [
                            Container(
                              height: 200,
                              child: ListView.builder(
                              // itemCount: UserData.user!.employmenthistory!.length,
                              itemCount: UserData.data!.employmenthis!.length,
                              itemBuilder: ((context, index) {
                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                          // Text(UserData.user!.employmenthistory![index].title + " | "),
                                          // Text(UserData.user!.employmenthistory![index].startdate.year.toString() + " - "),
                                          // Text(UserData.user!.employmenthistory![index].enddate.year.toString()),
                                          Text(UserData.data!.employmenthis![index])
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Text(UserData.user!.employmenthistory![index].company),
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
                            Text(UserData.data!.education_description!),
                            SizedBox(height: 16),
                            Container(
                              height: 100,
                              child:
                            ListView.builder(
                              itemCount: UserData.user!.qualifications!.length,
                              itemBuilder: ((context, index) {
                                return Align(
                                  alignment: Alignment.centerLeft,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(UserData.user!.qualifications![index].intstitution + " | "),
                                          Text(UserData.user!.qualifications![index].date.year.toString() + " - "),
                                          Text(UserData.user!.qualifications![index].endo.year.toString()),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Text(UserData.user!.qualifications![index].qualification),
                                      
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
                                itemCount: UserData.user!.links!.length,
                                itemBuilder: ((context, index) {
                                  return Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 8),
                                        Text(UserData.user!.links![index].url),
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
class TemplateBPdf {
  var pdf = pw.Document();
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
                          pw.Text(UserData.user!.fname + " " + UserData.user!.lname, style: pw.TextStyle(fontSize: 32)),
                          pw.SizedBox(height: 32),
                          pw.Row(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              pw.Text(UserData.user!.location! + " | "),
                              pw.Text(UserData.user!.phoneNumber! + " | "),
                              pw.Text(UserData.user!.email!),
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
                            pw.Text(UserData.user!.description!),

                            pw.SizedBox(height: 48),

                            pw.Text("Experience", style: pw.TextStyle(fontSize: 24, color: PdfColors.lightGreen200,)),
                            pw.SizedBox(height: 8),
                            pw.Column(
                              children: [
                                pw.ListView.builder(
                                  itemCount: UserData.user!.employmenthistory!.length,
                                  itemBuilder: ((context, index) {
                                    return pw.Align(
                                      alignment: pw.Alignment.centerLeft,
                                      child: pw.Column(
                                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                        children: [
                                          pw.Row(
                                            children: [
                                              pw.Text(UserData.user!.employmenthistory![index].title + " | "),
                                              pw.Text(UserData.user!.employmenthistory![index].startdate.year.toString() + " - "),
                                              pw.Text(UserData.user!.employmenthistory![index].enddate.year.toString()),
                                            ],
                                          ),
                                          pw.SizedBox(height: 8),
                                          pw.Text(UserData.user!.employmenthistory![index].company),
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
                                  itemCount: UserData.user!.qualifications!.length,
                                  itemBuilder: ((context, index) {
                                    return pw.Align(
                                      alignment: pw.Alignment.centerLeft,
                                      child: pw.Column(
                                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                        children: [
                                          pw.Row(
                                            children: [
                                              pw.Text(UserData.user!.qualifications![index].intstitution + " | "),
                                              pw.Text(UserData.user!.qualifications![index].date.year.toString() + " - "),
                                              pw.Text(UserData.user!.qualifications![index].endo.year.toString()),
                                            ],
                                          ),
                                          pw.SizedBox(height: 8),
                                          pw.Text(UserData.user!.qualifications![index].qualification),
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
                                  itemCount: UserData.user!.links!.length,
                                  itemBuilder: ((context, index) {
                                    return pw.Align(
                                      alignment: pw.Alignment.centerLeft,
                                      child: pw.Column(
                                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                        children: [
                                          pw.SizedBox(height: 8),
                                          pw.Text(UserData.user!.links![index].url),
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
      pdf = pw.Document();
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