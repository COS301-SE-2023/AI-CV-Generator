import 'dart:typed_data';
import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../widgets/pdf_window.dart';

// Ui counter part for pdf
class TemplateA extends StatefulWidget {
  TemplateA({super.key,required this.data,});
  // final MockGenerationResponse data;
  final CVData data;
  
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
    var templateApdf = TemplateAPdf(
      fname: fnameC!.text, 
      lnameC: lnameC!.text, 
      emailC: emailC!.text, 
      locationC: locationC!.text, 
      phoneNumberC: phoneNumberC!.text, 
      nameC: nameC!.text, 
      detailsC: detailsC!.text, 
      descriptionHeadingC: descriptionHeadingC!.text, 
      descriptionC: descriptionC!.text, 
      employmentHeadingC: employmentHeadingC!.text, 
      employmentC: employmentC!.text, 
      qualificationHeadingC:qualificationHeadingC!.text, 
      qualificationC: qualificationC!.text, 
      linksHeadingC: linksHeadingC!.text, 
      linksC: linksC!.text
    );
    templateApdf.writeOnPdf();
    return await templateApdf!.getPdf();
  }
  
  @override
  State<StatefulWidget> createState() => TemplateAState();
}

class TemplateAState extends State<TemplateA> {
  @override
  void initState() {
    widget.nameC!.text = widget.data!.firstname + " " + widget.data.lastname;
    widget.detailsC!.text = (widget.data!.location??"Please provide Location!") + " | " +
    (widget.data!.phoneNumber??"Please provide phone number!") + " | " +
    (widget.data!.email??"Please provide email!");
    widget.descriptionHeadingC!.text = "Professional Summary";
    widget.employmentHeadingC!.text = "Experience";
    widget.qualificationHeadingC!.text = "Qualifications";
    widget.linksHeadingC!.text = "Links";
    widget.descriptionC!.text = widget.data!.description!;
    for(int i = 0; i < widget.data.employmenthistory!.length; i++) {
      widget.employmentC!.text += widget.data!.employmenthistory![i].company + " | "
      + widget.data!.employmenthistory![i].startDate + " - "
      + widget.data!.employmenthistory![i].endDate + " | " + widget.data!.employmenthistory![i].jobTitle + "\n\n" + widget.data!.experience![i] + "\n\n";
    }

    for(int i = 0; i < widget.data!.qualifications!.length; i++) {
      widget.qualificationC!.text += widget.data!.qualifications![i].institution + " | "
      + widget.data!.qualifications![i].startDate + " - "
      + widget.data!.qualifications![i].endDate + " | " + widget.data!.qualifications![i].qualification + "\n\n";
    }
    widget.qualificationC!.text += widget.data!.education_description!;
    
    for(int i = 0; i < widget.data!.links!.length; i++) {
      widget.linksC!.text += widget.data!.links![i].url + "\n";
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
                // color: Colors.lightGreenAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFieldInput(controller: widget.nameC!, fontSize: 32, textAlign: TextAlign.center,
                    
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
                        TextFieldInput(controller: widget.descriptionHeadingC!, fontSize: 24, textAlign: TextAlign.left, color: Colors.lightGreen),
                        SizedBox(height: 16),
                        TextFieldInput(controller: widget.descriptionC!, fontSize: 14, textAlign: TextAlign.left, maxLines: 6,),
                        
                        SizedBox(height: 48),
                        TextFieldInput(controller: widget.employmentHeadingC!, fontSize: 24, textAlign: TextAlign.left, color: Colors.lightGreen,),
                        SizedBox(height: 16),
                        TextFieldInput(controller: widget.employmentC!, fontSize: 14, textAlign: TextAlign.left, maxLines: 6,),

                        SizedBox(height: 48),
                        TextFieldInput(controller: widget.qualificationHeadingC!, fontSize: 24, textAlign: TextAlign.left, color: Colors.lightGreen),
                        SizedBox(height: 16),
                        TextFieldInput(controller: widget.qualificationC!, fontSize: 14, textAlign: TextAlign.left, maxLines: 6,),

                        SizedBox(height: 16),
                        TextFieldInput(controller: widget.linksHeadingC!, fontSize: 24, textAlign: TextAlign.left, color: Colors.lightGreen),
                        SizedBox(height: 8),
                        TextFieldInput(controller: widget.linksC!, fontSize: 14, textAlign: TextAlign.left, maxLines: 6,),
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
class TemplateAPdf {
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

  TemplateAPdf({
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
              child: pw.Center(
                child:  pw.ListView(
                  children: [

                    pw.Container(
                      // color: PdfColors.lightGreen200,
                      child: pw.ListView(
                        children: [
                          pw.Text(nameC, style: pw.TextStyle(fontSize: 32)),
                          pw.SizedBox(height: 32),
                          pw.Text(detailsC),
                          pw.SizedBox(height: 32),
                        ] 
                      )
                    ),

                    pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        descriptionHeadingC,
                        style: pw.TextStyle(fontSize: 24, color: PdfColors.lightGreen200,)
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text(descriptionC, style: pw.TextStyle(fontSize: 16)),
                    pw.SizedBox(height: 16),
                    pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        employmentHeadingC,
                        style: pw.TextStyle(fontSize: 24, color: PdfColors.lightGreen200,)
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text(employmentC, style: pw.TextStyle(fontSize: 16)),

                    pw.SizedBox(height: 116),
                    pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        qualificationHeadingC,
                        style: pw.TextStyle(fontSize: 24, color: PdfColors.lightGreen200,)
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Text(qualificationC, style: pw.TextStyle(fontSize: 16)),
                    pw.SizedBox(height: 16),
                    pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        linksHeadingC,
                        style: pw.TextStyle(fontSize: 24, color: PdfColors.lightGreen200,)
                      ),
                    ),
                    pw.SizedBox(height: 8),
                    pw.Align(
                      alignment: pw.Alignment.centerLeft,
                      child: pw.Text(
                        linksC,
                        style: pw.TextStyle(fontSize: 16,)
                      ),
                    ),
                  ]
                ),
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