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
  TemplateA({super.key, required this.user, required this.data,});
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
    print(" updata "+nameC!.text);
    var templateApdf = TemplateAPdf(fname: fnameC!.text, lnameC: lnameC!.text, emailC: emailC!.text, locationC: locationC!.text, phoneNumberC: phoneNumberC!.text, nameC: nameC!.text, detailsC: detailsC!.text, descriptionHeadingC: descriptionHeadingC!.text, descriptionC: descriptionC!.text, employmentHeadingC: employmentC!.text, employmentC: employmentC!.text, qualificationHeadingC:qualificationHeadingC!.text, qualificationC: qualificationC!.text, linksHeadingC: linksHeadingC!.text, linksC: linksC!.text);
    templateApdf.writeOnPdf();
    return await templateApdf!.getPdf();
  }
  
  @override
  State<StatefulWidget> createState() => TemplateAState();
}

class TemplateAState extends State<TemplateA> {
  @override
  void initState() {
    widget.nameC!.text = widget.user!.fname + " " + widget.user!.lname;
    widget.detailsC!.text = (widget.user!.location??"Please provide Location!") + " | " +
    (widget.user!.phoneNumber??"Please provide phone number!") + " | " +
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
                color: Colors.lightGreenAccent,
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
              height: 777,
              child: pw.Center(
                child:  pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  children: [
                    pw.Text(fname, style: pw.TextStyle(fontSize: 32)),
                    pw.SizedBox(height: 32),
                    pw.Text(detailsC),
                    pw.Text(descriptionHeadingC, style: pw.TextStyle(fontSize: 24, color: PdfColors.lightGreen200,)),
                    pw.SizedBox(height: 8),
                    pw.Text(descriptionC),
                  ]
                ),
              )
            ),
            // pw.Expanded(child: 
            //   pw.Row(
            //     children: [
            //       pw.Expanded(
            //         child: pw.Container(
            //           color: PdfColors.lightGreen50,
            //           child: pw.Column(
            //             mainAxisAlignment: pw.MainAxisAlignment.center,
            //             children: [
            //               pw.Text(fname, style: pw.TextStyle(fontSize: 32)),
            //               pw.SizedBox(height: 32),
            //               pw.Text(detailsC)
            //             ]
            //           )
            //           )
            //       )
            //     ]
            //   )
            // ),
            // pw.Expanded(
            //   flex: 5,
            //   child: pw.Padding(
            //     padding: pw.EdgeInsets.all(32),
            //     child: pw.Row(
            //       children: [
            //         pw.Expanded( child:
            //           pw.Container(
            //             alignment: pw.Alignment.topLeft,
            //             child: pw.Wrap(
            //               //crossAxisAlignment: pw.CrossAxisAlignment.start,
            //               children: [
            //                 pw.Text(descriptionHeadingC, style: pw.TextStyle(fontSize: 24, color: PdfColors.lightGreen200,)),
            //                 pw.SizedBox(height: 8),
            //                 pw.Text(descriptionC),

            //                 pw.SizedBox(height: 48),

            //                 pw.Text(employmentHeadingC, style: pw.TextStyle(fontSize: 24, color: PdfColors.lightGreen200,)),
            //                 pw.SizedBox(height: 8),
            //                 pw.Text(employmentC),

            //                 pw.SizedBox(height: 48),

            //                 pw.Text(qualificationHeadingC, style: pw.TextStyle(fontSize: 24, color: PdfColors.lightGreen200,)),
            //                 pw.SizedBox(height: 8),
            //                 pw.Column(
            //                   children: [
            //                     pw.Text(qualificationC)
            //                   ]
            //                 ),

            //                 pw.SizedBox(height: 48),

            //                 pw.Text(linksC, style: pw.TextStyle(fontSize: 24, color: PdfColors.lightGreen200,)),
            //                 pw.SizedBox(height: 8),
            //                 pw.Text(linksC)
            //               ]
            //             )
            //           )
            //         )
            //       ]
            //     )
            //   )
            // ),
            

            pw.SizedBox(height: 48),

            pw.Text(employmentHeadingC, style: pw.TextStyle(fontSize: 24, color: PdfColors.lightGreen200,)),
            pw.SizedBox(height: 8),
            pw.Text(employmentC),

            pw.SizedBox(height: 48),

            pw.Text(qualificationHeadingC, style: pw.TextStyle(fontSize: 24, color: PdfColors.lightGreen200,)),
            pw.SizedBox(height: 8),
            pw.Column(
              children: [
                pw.Text(qualificationC)
              ]
            ),

            pw.SizedBox(height: 48),

            pw.Text(linksC, style: pw.TextStyle(fontSize: 24, color: PdfColors.lightGreen200,)),
            pw.SizedBox(height: 8),
            pw.Text(linksC)
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