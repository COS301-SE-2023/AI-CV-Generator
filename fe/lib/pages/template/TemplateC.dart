import 'dart:typed_data';
import 'package:ai_cv_generator/models/generation/CVData.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../widgets/pdf_window.dart';

// Ui counter part for pdf
class TemplateC extends StatefulWidget {
  TemplateC({super.key, required this.user, required this.data,});
  // final MockGenerationResponse data;
  final UserModel user;
  final   CVData data;
  
  TextEditingController? fnameC = TextEditingController();
  TextEditingController? lnameC = TextEditingController();
  TextEditingController? emailC = TextEditingController();
  TextEditingController? locationC = TextEditingController();
  TextEditingController? phoneNumberC = TextEditingController();
  
  TextEditingController? nameC = TextEditingController();
  TextEditingController? detailsC = TextEditingController();
  TextEditingController? descriptionHeadingC = TextEditingController();
  TextEditingController? descriptionC = TextEditingController();
  TextEditingController? employmentHeadingC = TextEditingController();
  TextEditingController? employmentC = TextEditingController();
  TextEditingController? qualificationHeadingC = TextEditingController();
  TextEditingController? qualificationC = TextEditingController();
  TextEditingController? linksHeadingC = TextEditingController();
  TextEditingController? linksC = TextEditingController();


  Future<PlatformFile> transform() async {
    var templateCpdf = TemplateCPdf(fname: fnameC!.text, lnameC: lnameC!.text, emailC: emailC!.text, locationC: locationC!.text, phoneNumberC: phoneNumberC!.text, nameC: nameC!.text, detailsC: detailsC!.text, descriptionHeadingC: descriptionHeadingC!.text, descriptionC: descriptionC!.text, employmentHeadingC: employmentHeadingC!.text, employmentC: employmentC!.text, qualificationHeadingC:qualificationHeadingC!.text, qualificationC: qualificationC!.text, linksHeadingC: linksHeadingC!.text, linksC: linksC!.text);
    templateCpdf.writeOnPdf();
    return await templateCpdf!.getPdf();
  }
  
  @override
  State<StatefulWidget> createState() => TemplateCState();
}

class TemplateCState extends State<TemplateC> {
  @override
  void initState() {
    widget.nameC!.text = widget.user!.fname + " " + widget.user!.lname;
    widget.detailsC!.text = (widget.user!.location??"Please provide Location!") + " * " +
    (widget.user!.phoneNumber??"Please provide phone number!") + " * " +
    (widget.user!.email??"Please provide email!");
    widget.descriptionHeadingC!.text = "Professional Summary";
    widget.employmentHeadingC!.text = "Experience";
    widget.qualificationHeadingC!.text = "Qualifications";
    widget.linksHeadingC!.text = "Links";
    widget.descriptionC!.text = widget.data!.description!;
    for(int i = 0; i < widget.user!.employmenthistory!.length; i++) {
      widget.employmentC!.text += widget.user!.employmenthistory![i].company + " | "
      + widget.user!.employmenthistory![i].startdate.year.toString() + " - "
      + widget.user!.employmenthistory![i].enddate.year.toString() + " | " + widget.user!.employmenthistory![i].title + "\n\n" + widget.data!.employmenthis![i] + "\n\n";
    }

    for(int i = 0; i < widget.user!.qualifications!.length; i++) {
      widget.qualificationC!.text += widget.user!.qualifications![i].intstitution + " | "
      + widget.user!.qualifications![i].date.year.toString() + " - "
      + widget.user!.qualifications![i].endo.year.toString() + " | " + widget.user!.qualifications![i].qualification + "\n\n";
    }
    widget.qualificationC!.text += widget.data!.education_description!;
    
    for(int i = 0; i < widget.user!.links!.length; i++) {
      widget.linksC!.text += widget.user!.links![i].url + "\n";
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFieldInput(controller: widget.nameC!, fontSize: 32, textAlign: TextAlign.center,
                    color: Colors.red
                    ),
                    SizedBox(height: 32),
                    TextFieldInput(controller: widget.detailsC!, textAlign: TextAlign.center,),
                      
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
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  TextFieldInput(controller: widget.descriptionHeadingC!, fontSize: 16, textAlign: TextAlign.left, color: Colors.red),
                                  SizedBox(height: 16),
                                  TextFieldInput(controller: widget.descriptionC!, fontSize: 14, textAlign: TextAlign.left, maxLines: 12,),
                                  SizedBox(height: 16),
                                  TextFieldInput(controller: widget.employmentHeadingC!, fontSize: 16, textAlign: TextAlign.left, color: Colors.red,),
                                  SizedBox(height: 16),
                                  TextFieldInput(controller: widget.employmentC!, fontSize: 14, textAlign: TextAlign.left, maxLines: 12,),
                                ],
                              )
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  TextFieldInput(controller: widget.qualificationHeadingC!, fontSize: 16, textAlign: TextAlign.left, color: Colors.red),
                                  SizedBox(height: 16),
                                  TextFieldInput(controller: widget.qualificationC!, fontSize: 14, textAlign: TextAlign.left, maxLines: 12,),
                                  SizedBox(height: 16),
                                  TextFieldInput(controller: widget.linksHeadingC!, fontSize: 16, textAlign: TextAlign.left, color: Colors.red),
                                  SizedBox(height: 16),
                                  TextFieldInput(controller: widget.linksC!, fontSize: 14, textAlign: TextAlign.left, maxLines: 12),
                                ],
                              )
                            ),

                          ],
                        ),
                      ]
                    )
                  )
                )
              ]
            )
          ),
      ],
    );
  }
}

class TextFieldInput extends StatefulWidget {
  TextFieldInput({super.key, required this.controller, this.fontSize, this.textAlign, this.color, this.maxLines});
  TextEditingController controller;
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
class TemplateCPdf {
  final pdf = pw.Document();
  final double fontText = 13;
  final double fontHeading = 24;
  final double fontSubHeading = 16;
  final pw.Widget relatedSpacing = pw.SizedBox(height: 8);
  final pw.Widget unRelatedSpacing = pw.SizedBox(height: 16);

  String fname;
  String lnameC ;
  String emailC ;
  String locationC ;
  String phoneNumberC ;
  
  String nameC ;
  String detailsC ;
  String descriptionHeadingC ;
  String descriptionC ;
  String employmentHeadingC ;
  String employmentC ;
  String qualificationHeadingC ;
  String qualificationC ;
  String linksHeadingC;
  String linksC;

  TemplateCPdf({
    required this.fname,
    required this.lnameC,
    required this.emailC,
    required this.locationC,
    required this.phoneNumberC,
  
    required this.nameC,
    required this.detailsC,
    required this.descriptionHeadingC,
    required this.descriptionC,
    required this.employmentHeadingC,
    required this.employmentC,
    required this.qualificationHeadingC,
    required this.qualificationC,
    required this.linksHeadingC,
    required this.linksC
  });

  void writeOnPdf() async {
    pdf.addPage(
     pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        build: (pw.Context context) {
          return <pw.Widget>[
            pw.Container(
              // height: 777,
                child:  pw.ListView(
                  children: [

                    pw.Center(
                      child: pw.ListView(
                        children: [
                          pw.Text(nameC, style: pw.TextStyle(fontSize: 32, color: PdfColors.red,),),
                          pw.SizedBox(height: 32),
                          pw.Text(detailsC),
                          pw.SizedBox(height: 32),
                        ] 
                      ), 
                    ),

                    pw.Center(
                      child: pw.Row(
                        
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          // alignment: pw.Alignment.centerLeft,
                          child: pw.ListView(
                            children: [
                              pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                descriptionHeadingC,
                                style: pw.TextStyle(fontSize: 16, color: PdfColors.red,)
                                ),
                              ),
                              pw.SizedBox(height: 8),
                              pw.Text(descriptionC, style: pw.TextStyle(fontSize: 12)),
                              pw.SizedBox(height: 16),
                              pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                  employmentHeadingC,
                                  style: pw.TextStyle(fontSize: 16, color: PdfColors.red,)
                                ),
                              ),
                              pw.SizedBox(height: 8),
                              pw.Text(employmentC, style: pw.TextStyle(fontSize: 12)),
                              pw.SizedBox(height: 16),
                            ]
                          ),
                        ),
                      pw.Expanded(
                        child: pw.ListView(
                          children: [
                              pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                  qualificationHeadingC,
                                  style: pw.TextStyle(fontSize: 16, color: PdfColors.red,)
                                ),
                              ),
                              pw.SizedBox(height: 8),
                              pw.Text(qualificationC, style: pw.TextStyle(fontSize: 12)),
                              pw.SizedBox(height: 16),
                              pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                  linksHeadingC,
                                  style: pw.TextStyle(fontSize: 16, color: PdfColors.red,)
                                ),
                              ),
                              pw.SizedBox(height: 8),
                              pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                  linksC,
                                  style: pw.TextStyle(fontSize: 12,)
                                ),
                              ),
                          ]
                        ),
                      ),
                      ]
                    ),
                    ),
                  ]
                ),
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