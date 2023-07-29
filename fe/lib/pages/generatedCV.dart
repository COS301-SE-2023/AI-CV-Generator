
import 'package:ai_cv_generator/dio/client/userApi.dart';
import 'package:ai_cv_generator/pages/pdf_window.dart';
import 'package:ai_cv_generator/pages/personaldetails.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:ai_cv_generator/pages/shareCV.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../models/user/UserModel.dart';
import 'details.dart';
class GeneratedCV extends StatefulWidget {
  const GeneratedCV({super.key});

  @override
  GeneratedCVState createState() => GeneratedCVState();
}

class GeneratedCVState extends State<GeneratedCV> {

  Map data = content;
  UserModel? user;
  final TextEditingController _controller = TextEditingController();
  final pdf = pw.Document();
  void createCV() {
    setState(() {
      data.forEach((key, value) {
      });
    });
    _controller.text = details;
  }
  PlatformFile? file;
  bool saved = false;
  Future savePdf() async {
    if (!saved) {
      Uint8List bytes = await pdf.save();
      file = PlatformFile(name: "gen.pdf", size: bytes.length,bytes: bytes);
      saved = true;
    }
  }
  writeOnPdf(UserModel user) {
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Row(
              children: [

                pw.Expanded(
                  flex: 1,
                  child: pw.Align(
                  alignment: pw.Alignment.topLeft,
                    child: pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        alterText("Contact", fontSubHeading),
                        relatedSpacing,
                        alterText(user.phoneNumber.toString(), fontText),
                        unRelatedSpacing,
                        unRelatedSpacing,
                        alterText("Email", fontSubHeading),
                        relatedSpacing,
                        alterText(user.email!, fontText),
                        unRelatedSpacing,
                        unRelatedSpacing,
                        alterText("Address", fontSubHeading),
                        relatedSpacing,
                        alterText(user.location!, fontText),
                        unRelatedSpacing,
                        unRelatedSpacing,
                        alterText("Education", fontSubHeading),
                        relatedSpacing,
                        alterText("University of X", fontText),
                        relatedSpacing,
                        alterText("2013 - 2015", fontText),
                        relatedSpacing,
                        alterText("BAcc Accounting", fontText),
                        unRelatedSpacing,
                        unRelatedSpacing,
                        alterText("Expertise", fontSubHeading),
                        relatedSpacing,
                        alterText("Tax consulting", fontText),
                        relatedSpacing,
                        alterText("Bookeeping", fontText),
                        relatedSpacing,
                        alterText("Statistics", fontText),
                        relatedSpacing,
                        alterText("Stock Brokering", fontText),
                        unRelatedSpacing,
                        unRelatedSpacing,
                        alterText("Language", fontSubHeading),
                        relatedSpacing,
                        alterText("English", fontText),
                        relatedSpacing,
                        alterText("French", fontText),
                      ]
                    )
                  ),
                ),
                pw.Expanded(
                  flex: 3,
                  child: pw.Container(
                    child: pw.Column(
                      children: [
                        pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              alterText("${user.fname} ${user.lname}", fontHeading),
                              relatedSpacing,
                              alterText("Accountant", fontSubHeading),
                            ]
                          ),
                        ),
                        pw.SizedBox(height: 16),
                        alterText(description, fontText),
                        pw.SizedBox(height: 24),
                        pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              alterText("Experience", fontSubHeading),
                              pw.SizedBox(height: 16),
                              pw.Padding(
                                padding: const pw.EdgeInsets.symmetric(horizontal: 12.0),
                                child: pw.Column(
                                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                                  children: [
                                    alterText('2015 - 2018', 12),
                                    relatedSpacing,
                                    alterText(jobA, fontText),
                                    pw.SizedBox(height: 16),
                                    alterText('2018 - 2020', 12),
                                    relatedSpacing,
                                    alterText(jobB, fontText),
                                    pw.SizedBox(height: 16),
                                  ]
                                )
                              )
                            ],
                          ),
                        ),
                        pw.SizedBox(height: 16),
                        pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: alterText('References', fontSubHeading),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Padding(
                            padding: const pw.EdgeInsets.symmetric(horizontal: 12.0),
                            child: pw.Wrap(
                              crossAxisAlignment: pw.WrapCrossAlignment.start,
                              runSpacing: 16,
                              children: [
                                alterText(refA, fontText),
                                alterText(refB, fontText),
                              ]
                            )
                          )
                        )
                      ]
                    )
                  )
                ),

              ]
            )
          ];
        },
      ),
    );
  }
  final double fontText = 13;
  final double fontHeading = 24;
  final double fontSubHeading = 16;
  final pw.Widget relatedSpacing = pw.SizedBox(height: 8);
  final pw.Widget unRelatedSpacing = pw.SizedBox(height: 16);
  pw.Text alterText(String text, double fontSize) {
    return pw.Text(
      text,
      style: pw.TextStyle(
        fontSize: fontSize
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [

              Container(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: OutlinedButton(
                    onPressed: () async {
                      setState(() {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => const PersonalDetailsForm(user: user)
                        //   ),
                        // );
                        createCV();
                      });
                    },
                    child: const Text("Generate")
                  )
                ),
              ),
              
              Expanded(
                child: Container(
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                      TextFormField(
                        maxLines: null,
                        controller: _controller,
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
          Positioned(
            bottom: 18.0, // Adjust the position of the floating button
            right: 18.0,
            child: FloatingActionButton(
              onPressed: () async {
                if (!saved) {
                  user = await userApi.getUser();
                  writeOnPdf(user!);
                  await savePdf();
                }
                if (file != null) {
                  shareCVModal(context,file);
                }
              },
              child: const Icon(Icons.download),
            ),
          ),
          Positioned(
            bottom: 18.0,
            left: 18.0,
            child: FloatingActionButton(
              onPressed: () async {
                if (!saved) {
                  user = await userApi.getUser();
                  writeOnPdf(user!);
                  await savePdf();
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfWindow(file: file,)
                  ),
                );
              },
              child: const Icon(Icons.save),
            ),
          )
        
        ],
      ),
    );
  }
}