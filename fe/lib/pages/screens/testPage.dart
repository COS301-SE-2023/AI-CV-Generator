import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:ai_cv_generator/pages/template/Template.dart';
import 'package:ai_cv_generator/pages/util/editor.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<StatefulWidget> createState() => TestPageState();
}

class TestPageState extends State<TestPage> {

  Future<CVData> showCV(CVData data, TemplateOption option) async {
    Editor editor = Editor(data: data, option: option);
    await showDialog(
      barrierColor: const Color(0x01000000),
      context: context, 
      builder: (context) {
        return Container(
          width: 100,
          height: 800,
          child: editor,
        );
      }
    );

    return editor.data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                data = await showCV(data, TemplateOption.templateA);
              }, 
              fontSize: 10
            )
          ],
        ),
      )
    );
  }

}