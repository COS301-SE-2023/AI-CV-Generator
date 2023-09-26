import 'package:ai_cv_generator/api/downloadService.dart';
import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:ai_cv_generator/pages/template/TemplateChoice.dart';
import 'package:ai_cv_generator/pages/template/templateCRedo.dart';
import 'package:ai_cv_generator/pages/template/templateERedo.dart';
import 'package:ai_cv_generator/pages/template/templateFRework.dart';
import 'package:ai_cv_generator/pages/util/editor.dart';
import 'package:ai_cv_generator/pages/util/namePromt.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<StatefulWidget> createState() => TestPageState();
}

class TestPageState extends State<TestPage> {

  Future<CVData> showCV(CVData data, TemplateOption option) async {
    ColorSet set = ColorSet();
    set.setColorSetTemplateChoice(option);
    Editor editor = Editor(data: data, option: option,colors: set,);
    await showDialog(
      barrierColor: const Color(0x01000000),
      context: context, 
      builder: (context) {
        return Container(
          child: editor,
        );
      }
    );

    return editor.data;
  }

  Future<String?> promptName() async {
    NamePrompt prompt = NamePrompt();
    await showDialog(
      context: context, 
      builder: (context) {
        return Container(
          child: prompt,
        );
      }
    );

    return prompt.name;
  }

  toHelpPage() {
    Navigator.pushNamed(context,'/help');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomizableButton(
                text: 'Test', 
                width: 40, 
                height: 28, 
                onTap: () async {
                  CVData data = CVData(
                    description: 'This is my description',
                    employmenthistory: [],
                    qualifications: [],
                    skills: [],
                    references: [],
                    links: []
                  );
                  data = await showCV(data, TemplateOption.templateE);
                  ColorSet set = ColorSet();
                  set.setColorSetTemplateChoice(TemplateOption.templateE);
                  PdfDocument doc = PdfDocument(inputBytes: await TemplateE().templateE(data, set));
                  DownloadService.download(await TemplateE().templateE(data, set), downloadName: 'templateE.pdf');
                  //print(await promptName());
                  // toHelpPage();
                }, 
                fontSize: 10
              )
            ],
          ),
        ),
      )
    );
  }

}