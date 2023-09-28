import 'package:ai_cv_generator/models/aimodels/AIEmployment.dart';
import 'package:ai_cv_generator/models/aimodels/AIInput.dart';
import 'package:ai_cv_generator/models/aimodels/AILink.dart';
import 'package:ai_cv_generator/models/aimodels/AIQualification.dart';
import 'package:ai_cv_generator/models/aimodels/AIReference.dart';
import 'package:ai_cv_generator/models/aimodels/AISkill.dart';
import 'package:ai_cv_generator/pages/elements/elements.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ExtractionView {
  Map controllers = {};

  AIInput update(AIInput aiInput) {
    aiInput.firstname = controllers["firstname"].text;
    aiInput.lastname = controllers["lastname"].text;
    aiInput.email = controllers["email"].text;
    aiInput.phoneNumber = controllers["phoneNumber"].text;
    aiInput.location = controllers["location"].text;
    aiInput.description = controllers["description"].text;

    List<AIEmployment> aiEmploymentList = [];
    for(int i = 0; i < controllers["experience"].length; i++) {
      aiEmploymentList.add(
        AIEmployment(
          company: controllers["experience"][i]["company"].text,
          jobTitle: controllers["experience"][i]["jobTitle"].text,
          startDate: controllers["experience"][i]["startDate"].text,
          endDate: controllers["experience"][i]["endDate"].text,
        )
      );
    }
    aiInput.experience = aiEmploymentList;

    List<AIQualification> aiQualificationList = [];
    for(int i = 0; i < controllers["qualifications"].length; i++) {
      aiQualificationList.add(
        AIQualification(
          qualification: controllers["qualifications"][i]["qualification"].text,
          institution: controllers["qualifications"][i]["institution"].text,
          startDate: controllers["qualifications"][i]["startDate"].text,
          endDate: controllers["qualifications"][i]["endDate"].text,
        )
      );
    }
    aiInput.qualifications = aiQualificationList;

    List<AILink> ailinksList = [];
    for(int i = 0; i < controllers["links"].length; i++) {
      ailinksList.add(
        AILink(
          url: controllers["links"][i]["url"].text,
        )
      );
    }
    aiInput.links = ailinksList;

    List<AIReference> aiReferenceList = [];
    for(int i = 0; i < controllers["references"].length; i++) {
      aiReferenceList.add(
        AIReference(
          description: controllers["references"][i]["description"].text,
          contact: controllers["references"][i]["contact"].text,
        )
      );
    }
    aiInput.references = aiReferenceList;

    List<AISkill> aiskillsList = [];
    for(int i = 0; i < controllers["skills"].length; i++) {
      aiskillsList.add(
        AISkill(
          skill: controllers["skills"][i]["skill"].text,
          level: controllers["skills"][i]["level"].text,
          reason: controllers["skills"][i]["reason"].text,
        )
      );
    }
    aiInput.skills = aiskillsList;
    return aiInput;
  }

  Future<bool> showModal(BuildContext context, PlatformFile file, AIInput aiInput) async {
    bool proceed = false;
    await showDialog(
      context: context,
      builder: (context) {
        // Window Resizing
        Size screenSize = MediaQuery.of(context).size;
        double w = screenSize.width/100;
        double h = screenSize.height/100; 
        return Dialog(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2)
            ),
            width: w*82,
            child:Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    right: w*2
                  ),
                  width: w*40,
                  child: SfPdfViewer.memory(
                    file.bytes!
                  )
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 2*w
                  ),
                  height: 640,
                  width: 40*w,
                  child: SectionContainer(
                    child: Column(
                      children: [
                        Expanded(
                          flex: 10,
                          child: ListView(
                            padding: const EdgeInsets.only(right: 16),
                            children: [
                              ...extractedData(aiInput.toJson())
                            ],
                          ),
                        ),
                        const SizedBox(height: 16,),
                        Expanded(
                          child: CustomizableButton(
                            onTap: () {
                              try {
                              update(aiInput);
                                
                              } catch (e){
                                print(e);
                              }
                              proceed = true;
                              Navigator.pop(context);
                            },
                            text: "Save and Proceed",
                            width: 10*w,
                            height: 5*h,
                            fontSize: 0.1*w*h,
                          )
                        )
                      ],
                    )
                  )
                ),
              ],
            ),
          )
        );
    });
    return proceed;
  }

  int calculateLines(String text) {
    int lines = (text.split(" ").length/10).toInt();
    lines < 1 ? lines = 1 : lines;
    return lines;
  }

  List<Widget> extractedData(Map aiInput) {
    List<Widget> widgets = [];
    aiInput.forEach((key, value) {
      widgets.add(SectionHeading(text: key.toString().toUpperCase()));
      if(value is List) {
        controllers[key] = [];
        for(int i = 0; i < value.length; i++) {
          controllers[key].add({});
          value[i].toJson().forEach((listKey, data) {
            if(data!= null) {
              TextEditingController controller = TextEditingController();
              controllers[key][i][listKey] = controller;
              controller.text = data;

              widgets.add(TextField(controller: controller, maxLines: calculateLines(data),));
            }
          });
          if(i != value.length-1) {
            widgets.add(const SizedBox(height: 8,));
          }
        }
      }
      else {
        TextEditingController controller = TextEditingController();
        controllers[key] = controller;
        controller.text = value;
        widgets.add(TextField(controller: controller, maxLines: calculateLines(value),));
      }
      
      widgets.add(const SizedBox(height: 24,));
    });
    return widgets;
  }
      
}