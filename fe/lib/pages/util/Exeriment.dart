
import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:ai_cv_generator/pages/template/Template.dart';
import 'package:flutter/material.dart';

class Experiment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ExperimentState();

}

class ExperimentState extends State<Experiment> {
  TemplateOption templateOption = TemplateOption.templateB;
  @override
  void initState() {
    super.initState();
  }
  

  void swap() {
    switch (templateOption) {
      case TemplateOption.templateA:
        templateOption = TemplateOption.templateB;
      break;
      case TemplateOption.templateB:
        templateOption = TemplateOption.templateC;
      break;
      case TemplateOption.templateC:
        templateOption = TemplateOption.templateD;
      break;
      default:
        templateOption = TemplateOption.templateA;
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 777,
              width: 555,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                border: Border.all(
                  color: const Color.fromARGB(0, 0, 0, 0),
                ),
                color: Theme.of(context).colorScheme.surface,
              ),
              child: Template(
                option: templateOption, 
                data:  CVData(
                  firstname: "Nathan", 
                  lastname: "Opperman", 
                  email: "email", 
                  phoneNumber: "phonenumber", 
                  location: "location",
                  description: "this is the description!",
                  employmenthistory: [],
                  experience: [],
                  qualifications: [],
                  education_description: "This is the education description!",
                  links: []
                ),
                colA: Colors.lightGreen,
                colB: Colors.amber,
                colC: Colors.blueAccent,
                colD: Colors.green,
              ),
            ),
          ),
          const SizedBox(height: 20,),
          TextButton(
            onPressed: () {
              setState(() {
                swap();
              });
            }, 
            child: const Text("Switch")
          )
        ],
      ),
    );
  }

}