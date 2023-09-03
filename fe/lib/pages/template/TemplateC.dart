import 'dart:typed_data';
import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../widgets/pdf_window.dart';

// Ui counter part for pdf
class TemplateC extends StatefulWidget {
  TemplateC({super.key,required this.data,});
  // final MockGenerationResponse data;
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
    return await templateCpdf.getPdf();
  }
  
  @override
  State<StatefulWidget> createState() => TemplateCState();
}

class TemplateCState extends State<TemplateC> {
  @override
  void initState() {
    widget.nameC!.text = "${widget.data.firstname} ${widget.data.lastname}";
    widget.detailsC!.text = "${widget.data.location??"Please provide Location!"} | ${widget.data.phoneNumber??"Please provide phone number!"} | ${widget.data.email??"Please provide email!"}";
    widget.descriptionHeadingC!.text = "Professional Summary";
    widget.employmentHeadingC!.text = "Experience";
    widget.qualificationHeadingC!.text = "Qualifications";
    widget.linksHeadingC!.text = "Links";
    widget.descriptionC!.text = widget.data.description!;
    for(int i = 0; i < widget.data.employmenthistory!.length; i++) {
      widget.employmentC!.text += "${widget.data.employmenthistory![i].company} | ${widget.data.employmenthistory![i].startDate} - ${widget.data.employmenthistory![i].endDate} | ${widget.data.employmenthistory![i].jobTitle}\n\n${widget.data.experience![i]}\n\n";
    }

    for(int i = 0; i < widget.data.qualifications!.length; i++) {
      widget.qualificationC!.text += "${widget.data.qualifications![i].institution} | ${widget.data.qualifications![i].startDate} - ${widget.data.qualifications![i].endDate} | ${widget.data.qualifications![i].qualification}\n\n";
    }
    widget.qualificationC!.text += widget.data.education_description!;
    
    for(int i = 0; i < widget.data.links!.length; i++) {
      widget.linksC!.text += "${widget.data.links![i].url}\n";
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
              child:SizedBox(
                height: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFieldInput(controller: widget.nameC!, fontSize: 32, textAlign: TextAlign.center,
                    color: Colors.red
                    ),
                    const SizedBox(height: 32),
                    TextFieldInput(controller: widget.detailsC!, textAlign: TextAlign.center,),
                      
                  ]
                )
              )
            ),

          ],
        ),
          Padding(
            padding: const EdgeInsets.all(32),
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
                                  const SizedBox(height: 16),
                                  TextFieldInput(controller: widget.descriptionC!, fontSize: 14, textAlign: TextAlign.left, maxLines: 12,),
                                  const SizedBox(height: 16),
                                  TextFieldInput(controller: widget.employmentHeadingC!, fontSize: 16, textAlign: TextAlign.left, color: Colors.red,),
                                  const SizedBox(height: 16),
                                  TextFieldInput(controller: widget.employmentC!, fontSize: 14, textAlign: TextAlign.left, maxLines: 12,),
                                ],
                              )
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  TextFieldInput(controller: widget.qualificationHeadingC!, fontSize: 16, textAlign: TextAlign.left, color: Colors.red),
                                  const SizedBox(height: 16),
                                  TextFieldInput(controller: widget.qualificationC!, fontSize: 14, textAlign: TextAlign.left, maxLines: 12,),
                                  const SizedBox(height: 16),
                                  TextFieldInput(controller: widget.linksHeadingC!, fontSize: 16, textAlign: TextAlign.left, color: Colors.red),
                                  const SizedBox(height: 16),
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
      const InputDecoration(
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
                          pw.Text(nameC, style: const pw.TextStyle(fontSize: 32, color: PdfColors.red,),),
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
                                style: const pw.TextStyle(fontSize: 16, color: PdfColors.red,)
                                ),
                              ),
                              pw.SizedBox(height: 8),
                              pw.Text(descriptionC, style: const pw.TextStyle(fontSize: 12)),
                              pw.SizedBox(height: 16),
                              pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                  employmentHeadingC,
                                  style: const pw.TextStyle(fontSize: 16, color: PdfColors.red,)
                                ),
                              ),
                              pw.SizedBox(height: 8),
                              pw.Text(employmentC, style: const pw.TextStyle(fontSize: 12)),
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
                                  style: const pw.TextStyle(fontSize: 16, color: PdfColors.red,)
                                ),
                              ),
                              pw.SizedBox(height: 8),
                              pw.Text(qualificationC, style: const pw.TextStyle(fontSize: 12)),
                              pw.SizedBox(height: 16),
                              pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                  linksHeadingC,
                                  style: const pw.TextStyle(fontSize: 16, color: PdfColors.red,)
                                ),
                              ),
                              pw.SizedBox(height: 8),
                              pw.Align(
                                alignment: pw.Alignment.centerLeft,
                                child: pw.Text(
                                  linksC,
                                  style: const pw.TextStyle(fontSize: 12,)
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