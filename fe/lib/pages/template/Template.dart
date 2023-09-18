import 'package:ai_cv_generator/dio/client/fileApi.dart';
import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:ai_cv_generator/pages/template/TemplateA.dart';
import 'package:ai_cv_generator/pages/template/TemplateB.dart';
import 'package:ai_cv_generator/pages/template/TemplateC.dart';
import 'package:ai_cv_generator/pages/widgets/loadingScreens/loadingScreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pdf_render/pdf_render.dart';

// Option enum for template Picking
enum TemplateOption {templateA,templateB,templateC,templateD}
class Template extends StatefulWidget{

  Template({
    super.key, 
    required this.option, 
    required this.data, 
    this.colA, 
    this.colB, 
    this.colC,
    this.colD
  });

  /*

    Template A Default
    colA: lightGreen

    Template B Default
    colA: blueaccent
    colB: blue
    colC: blue.shade100
    colD: grey.shade300

    Template C Default
    colA: red

  */

  final CVData data;
  final Color? colA;
  final Color? colB;
  final Color? colC;
  final Color? colD;
  final TemplateOption option;
  final TextEditingController? fnameC = TextEditingController();
  final TextEditingController? lnameC = TextEditingController();
  final TextEditingController? emailC = TextEditingController();
  final TextEditingController? locationC = TextEditingController();
  final TextEditingController? phoneNumberC = TextEditingController();
  final TextEditingController? nameC = TextEditingController();
  final TextEditingController? detailsC = TextEditingController();
  final TextEditingController? descriptionHeadingC = TextEditingController();
  final TextEditingController? descriptionC = TextEditingController();
  final TextEditingController? employmentHeadingC = TextEditingController();
  final TextEditingController? employmentC = TextEditingController();
  final TextEditingController? qualificationHeadingC = TextEditingController();
  final TextEditingController? qualificationC = TextEditingController();
  final TextEditingController? linksHeadingC = TextEditingController();
  final TextEditingController? linksC = TextEditingController();

  Future<PlatformFile?> transform() async {
    switch(option) {
      case TemplateOption.templateA:
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
        return await templateApdf.getPdf();
      case TemplateOption.templateB:
        var templateBpdf = TemplateBPdf(
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
        await templateBpdf.writeOnPdf();
        return await templateBpdf.getPdf();
      case TemplateOption.templateC:
      break;
      case TemplateOption.templateD:
        var templateCpdf = TemplateCPdf(
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
        templateCpdf.writeOnPdf();
        return await templateCpdf.getPdf();
    }
    return null;
  }
  @override
  State<StatefulWidget> createState() {

    return TemplateState();
  }
}

class TemplateState extends State<Template> {
  
  @override
  void initState() {
    FileApi.getProfileImage().then((value) {
      img = value;
    });
    super.initState();
  }

  Image? img;

  @override
  Widget build(BuildContext context) {
    if (widget.data.description == null) {
        return const LoadingScreen();
    }
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
    switch (widget.option) {
      case TemplateOption.templateA:
        return templateA();
      case TemplateOption.templateB:
        return templateB();
      case TemplateOption.templateC:
        return templateC();
      case TemplateOption.templateD:
        return templateD();
      default:
        return templateA();
    }
  }

  void templateAInitialize() {

  }

  void templateBInitialize() {

  }

  void templateCInitialize() {

  }

  Widget templateA() {
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
                    TextFieldInput(controller: widget.nameC!, fontSize: 32, textAlign: TextAlign.center,),
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
                      TextFieldInput(controller: widget.descriptionHeadingC!, fontSize: 24, textAlign: TextAlign.left, color: widget.colA),
                      const SizedBox(height: 16),
                      TextFieldInput(controller: widget.descriptionC!, fontSize: 14, textAlign: TextAlign.left, maxLines: 6,),
                      const SizedBox(height: 48),
                      TextFieldInput(controller: widget.employmentHeadingC!, fontSize: 24, textAlign: TextAlign.left, color: widget.colA,),
                      const SizedBox(height: 16),
                      TextFieldInput(controller: widget.employmentC!, fontSize: 14, textAlign: TextAlign.left, maxLines: 6,),
                      const SizedBox(height: 48),
                      TextFieldInput(controller: widget.qualificationHeadingC!, fontSize: 24, textAlign: TextAlign.left, color: widget.colA),
                      const SizedBox(height: 16),
                      TextFieldInput(controller: widget.qualificationC!, fontSize: 14, textAlign: TextAlign.left, maxLines: 6,),
                      const SizedBox(height: 16),
                      TextFieldInput(controller: widget.linksHeadingC!, fontSize: 24, textAlign: TextAlign.left, color: widget.colA),
                      const SizedBox(height: 8),
                      TextFieldInput(controller: widget.linksC!, fontSize: 14, textAlign: TextAlign.left, maxLines: 6,),
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

  Widget templateB() {
    if (img == null) {
      return const LoadingScreen();
    }
    return ListView(
      children: [
        Row(
          children: [
            Expanded(
              child:Container(
                height: 555,
                color: widget.colA,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(image: img!.image, height: 170,width: 170,),
                    const SizedBox(height: 40,),
                    TextFieldInput(
                      controller: widget.nameC!, 
                      fontSize: 32, 
                      textAlign: TextAlign.center,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 32),
                    TextFieldInput(
                      controller: widget.detailsC!, 
                      textAlign: TextAlign.center,
                      color: Colors.white
                    ),
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
                      TextFieldInput(controller: widget.descriptionHeadingC!, fontSize: 24, textAlign: TextAlign.center, color: widget.colB),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: widget.colC??Colors.white
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: widget.colD
                        ),
                        child:TextFieldInput(controller: widget.descriptionC!, fontSize: 14, textAlign: TextAlign.left, maxLines: 6,),
                      ),
                      const SizedBox(height: 48),
                      TextFieldInput(controller: widget.employmentHeadingC!, fontSize: 24, textAlign: TextAlign.left, color: widget.colB,),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: widget.colC??Colors.white
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: widget.colD
                        ),
                        child: TextFieldInput(controller: widget.employmentC!, fontSize: 14, textAlign: TextAlign.left, maxLines: 6,),
                      ),
                      const SizedBox(height: 48),
                      TextFieldInput(controller: widget.qualificationHeadingC!, fontSize: 24, textAlign: TextAlign.left, color: widget.colB),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: widget.colC??Colors.white
                          ),
                          borderRadius: BorderRadius.circular(20),
                          color: widget.colD
                        ),
                        child: TextFieldInput(controller: widget.qualificationC!, fontSize: 14, textAlign: TextAlign.left, maxLines: 6,),
                      ),
                      const SizedBox(height: 16),
                      TextFieldInput(controller: widget.linksHeadingC!, fontSize: 24, textAlign: TextAlign.left, color: widget.colB),
                      const SizedBox(height: 8),
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

  Widget templateC() {
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
                    color: widget.colA
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
                                TextFieldInput(controller: widget.descriptionHeadingC!, fontSize: 16, textAlign: TextAlign.left, color: widget.colA),
                                const SizedBox(height: 16),
                                TextFieldInput(controller: widget.descriptionC!, fontSize: 14, textAlign: TextAlign.left, maxLines: 12,),
                                const SizedBox(height: 16),
                                TextFieldInput(controller: widget.employmentHeadingC!, fontSize: 16, textAlign: TextAlign.left, color: widget.colA,),
                                const SizedBox(height: 16),
                                TextFieldInput(controller: widget.employmentC!, fontSize: 14, textAlign: TextAlign.left, maxLines: 12,),
                              ],
                            )
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                TextFieldInput(controller: widget.qualificationHeadingC!, fontSize: 16, textAlign: TextAlign.left, color: widget.colA),
                                const SizedBox(height: 16),
                                TextFieldInput(controller: widget.qualificationC!, fontSize: 14, textAlign: TextAlign.left, maxLines: 12,),
                                const SizedBox(height: 16),
                                TextFieldInput(controller: widget.linksHeadingC!, fontSize: 16, textAlign: TextAlign.left, color: widget.colA),
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

  Widget templateD() {
    if (img == null) {
      return const LoadingScreen();
    }
    return ListView();
  }
}

class TextFieldInput extends StatefulWidget {
  const TextFieldInput({
    super.key, 
    required this.controller, 
    this.fontSize, 
    this.textAlign, 
    this.color, 
    this.maxLines
  });

  final TextEditingController controller;
  final double? fontSize;
  final TextAlign? textAlign;
  final Color? color;
  final int? maxLines;

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