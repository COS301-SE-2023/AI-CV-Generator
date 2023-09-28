import 'package:ai_cv_generator/api/downloadService.dart';
import 'package:ai_cv_generator/api/pdfApi.dart';
import 'package:ai_cv_generator/models/aimodels/AIEmployment.dart';
import 'package:ai_cv_generator/models/aimodels/AIInput.dart';
import 'package:ai_cv_generator/models/aimodels/AILink.dart';
import 'package:ai_cv_generator/models/aimodels/AIQualification.dart';
import 'package:ai_cv_generator/models/aimodels/AIReference.dart';
import 'package:ai_cv_generator/models/aimodels/AISkill.dart';
import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:ai_cv_generator/pages/template/TemplateChoice.dart';
import 'package:ai_cv_generator/pages/template/templateERedo.dart';
import 'package:ai_cv_generator/pages/util/editor.dart';
import 'package:ai_cv_generator/pages/util/inputEditor.dart';
import 'package:ai_cv_generator/pages/util/namePromt.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
import 'package:file_picker/file_picker.dart';
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

  Future<AIInput?> showInput(AIInput data) async {
    ColorSet set = ColorSet();
    PlatformFile? file = await pdfAPI.pick_cvfile();
    InputEditor editor = InputEditor(data: data, bytes: file!.bytes!);
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

  nullSafeInputData(AIInput input) {
    input.description ??= 'Description';
    input.email ??= 'Email';
    input.firstname ??='First Name';
    input.lastname ??='Last Name';
    input.location ??='Location';
    input.phoneNumber ??='Phone Number';
    for (AIEmployment emp in  input.experience) {
      emp.company ??= 'Company';
      emp.jobTitle ??= 'Job Title';
      emp.endDate ??= 'End Date';
      emp.startDate ??= 'Start Date';
    }
    for (AIQualification qua in input.qualifications) {
      qua.qualification ??= 'Qualification';
      qua.institution ??= 'Instatution';
      qua.endDate ??= 'End Date';
      qua.startDate ??= 'Start Date';
    }
    for (AISkill skill in input.skills) {
      skill.skill ??= 'Skill';
      skill.reason ??= 'Reason';
      skill.level ??= '5';
      if (skill.level != '1'||skill.level != '1'||skill.level != '1'||skill.level != '1'||skill.level != '1') {
        skill.level = '5';
      }
    }
    for (AILink lin in input.links) {
      lin.url ??= 'Url';
    }
    for (AIReference ref in input.references) {
      ref.contact ??= 'Contact';
      ref.description ??= 'Description';
    }
    return input;
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
                  AIInput input = AIInput(
                    experience: [], 
                    qualifications: [], 
                    links: [], 
                    references: [], 
                    skills: [
                      AISkill(
                        level: 'Level'
                      )
                    ]
                  );
                  await showInput(nullSafeInputData(input));
                  //print(await promptName());
                  toHelpPage();
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