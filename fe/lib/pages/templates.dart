import 'dart:typed_data';
import 'package:ai_cv_generator/pages/util/fileView.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'details.dart';

class Templates {
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
                        alterText("0829876453", fontText),
                        unRelatedSpacing,
                        unRelatedSpacing,
                        alterText("Email", fontSubHeading),
                        relatedSpacing,
                        alterText("averyq@gmail.com", fontText),
                        unRelatedSpacing,
                        unRelatedSpacing,
                        alterText("Address", fontSubHeading),
                        relatedSpacing,
                        alterText("Pretoria, Gauteng", fontText),
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
                              alterText("Avery Quinn", fontHeading),
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
            child: FileView(file: file,)
          );
        });
    },);
  }

  pw.Text alterText(String text, double fontSize) {
    return pw.Text(
      text,
      style: pw.TextStyle(
        fontSize: fontSize
      ),
    );
  }
}