import 'dart:typed_data';

import 'package:ai_cv_generator/models/aimodels/AIEmployment.dart';
import 'package:ai_cv_generator/models/aimodels/AIQualification.dart';
import 'package:ai_cv_generator/models/aimodels/AIReference.dart';
import 'package:ai_cv_generator/models/aimodels/AISkill.dart';
import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:ai_cv_generator/pages/template/Template.dart';
import 'package:ai_cv_generator/pages/widgets/loadingScreens/loadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

enum PageOption {
  main,
  personDetails,
  experienceList,
  qualificationList,
  skillList,
  referenceList,
  experience,
  qualification,
  skill,
  reference
}

class Editor extends StatefulWidget {
  const Editor({super.key, required this.data,required this.option});
  final CVData data;
  final TemplateOption option;
  @override
  State<StatefulWidget> createState() => EditableTextState();
}

class EditorState extends State<Editor> {

  bool wait = true;
  Uint8List? bytes;
  PageOption option = PageOption.main;
  int employmentIndex = 0;
  AIEmployment? employment;
  int qualificationIndex = 0;
  AIQualification? qualification;
  int skillIndex = 0;
  AISkill? skill;
  int referenceIndex = 0;
  AIReference? reference;

  // Will regenerate the PDF with changes
  updatePdf() {
    setState(() {
      
    });
  }


  setOnLoadingScreen() {
    setState(() {
      wait = true;
    });
  }

  setOffLoadingScreen() {
    setState(() {
      wait = false;
    });
  }

  selectMain() {
    setState(() {
      option = PageOption.main;
    });
  }

  selectPersonalDetails() {
    setState(() {
      option = PageOption.personDetails;
    });
  }

  selectExperienceList() {
    setState(() {
      option = PageOption.experienceList;
    });
  }

  selectQualificationList() {
    setState(() {
      option = PageOption.qualificationList;
    });
  }

  selectSkillList() {
    setState(() {
      option = PageOption.skillList;
    });
  }

  selectReferenceList() {
    setState(() {
      option = PageOption.referenceList;
    });
  }

  selectExperience(AIEmployment employment, int employmentIndex) {
    setState(() {
      this.employment = employment;
      this.employmentIndex = employmentIndex;
      option = PageOption.experience;
    });
  }

  saveExperience() {
    setState(() {
      widget.data.employmenthistory!.insert(employmentIndex, employment!);
      option = PageOption.experienceList;
    });
    updatePdf();
  }

  addExperience() {
    AIEmployment newEmployment = AIEmployment(
      company: 'Company',
      jobTitle: 'JobTitle',
      startDate: DateTime.now().toString(),
      endDate: DateTime.now().toString()
    );
    setState(() {
      widget.data.employmenthistory!.add(newEmployment);
      employment = newEmployment;
      employmentIndex = widget.data.employmenthistory!.indexOf(newEmployment);
      option = PageOption.experience;
    });
    updatePdf();
  }

  deleteExperience(int index) {
    setState(() {
      widget.data.employmenthistory!.removeAt(index);
    });
    updatePdf();
  }

  selectQualification(AIQualification qualification, int qualificationIndex) {
    setState(() {
      this.qualification = qualification;
      this.qualificationIndex = qualificationIndex;
      option = PageOption.qualification;
    });
  }

  saveQualification() {
    setState(() {
      widget.data.qualifications!.insert(qualificationIndex, qualification!);
      option = PageOption.qualificationList;
    });
    updatePdf();
  }

  addQualification() {
    AIQualification newQualification = AIQualification(
      qualification: 'Qualification',
      institution: 'Institution',
      startDate: DateTime.now().toString(),
      endDate: DateTime.now().toString()
    );
    setState(() {
      widget.data.qualifications!.add(newQualification);
      qualification = newQualification;
      qualificationIndex = widget.data.qualifications!.indexOf(newQualification);
      option = PageOption.qualification;
    });
    updatePdf();
  }

  deleteQualification(int index) {
    setState(() {
      widget.data.qualifications!.removeAt(index);
    });
    updatePdf();
  }

  selectSkill(AISkill skill,int skillIndex) {
    setState(() {
      this.skill = skill;
      this.skillIndex = skillIndex;
      option = PageOption.skill;
    });
  }

  saveSkill() {
    setState(() {
      widget.data.skills!.insert(skillIndex, skill!);
      option = PageOption.skillList;
    });
    updatePdf();
  }

  addSkill() {
    AISkill newSkill = AISkill(
      skill: 'Skill',
      level: 5.toString(),
      reason: 'Reason'
    );
    setState(() {
      widget.data.skills!.add(newSkill);
      skill = newSkill;
      skillIndex = widget.data.skills!.indexOf(newSkill);
      option = PageOption.skill;
    });
    updatePdf();
  }

  deleteSkill(int index) {
    setState(() {
      widget.data.skills!.removeAt(index);
    });
    updatePdf();
  } 

  selectReference(AIReference reference, int referenceIndex) {
    setState(() {
      this.reference = reference;
      this.referenceIndex = referenceIndex;
      option = PageOption.reference;
    });
  }

  saveReference() {
    setState(() {
      widget.data.references!.insert(referenceIndex, reference!);
      option = PageOption.referenceList;
    });
    updatePdf();
  }

  addReference() {
    AIReference newReference = AIReference(
      description: 'Description',
      contact: 'Contact'
    );
    setState(() {
      widget.data.references!.add(newReference);
      reference = newReference;
      referenceIndex = widget.data.references!.indexOf(newReference);
      option = PageOption.reference;
    });
    updatePdf();
  }

  deleteReference(int index) {
    setState(() {
      widget.data.references!.removeAt(index);
    });
    updatePdf();
  }

  @override
  void initState() {
    // create pdf
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (wait) {
      return const LoadingScreen();
    }
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100;
    return SizedBox(
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(w*1),
            width: 32*w,
            height: 85*h,
            child: SfPdfViewer.memory(
              bytes!,
              pageSpacing: 8
            ),
          ),
          Container(
            child: 
            // Menus
            switch(option) {
              PageOption.main => Column(
                children: [],
              ),
              PageOption.personDetails => Column(
                children: [],
              ),
              PageOption.experienceList => Column(
                children: [],
              ),
              PageOption.qualificationList => Column(
                children: [],
              ),
              PageOption.skillList => Column(
                children: [],
              ),
              PageOption.referenceList => Column(
                children: [],
              ),
              PageOption.experience => Column(
                children: [],
              ),
              PageOption.qualification => Column(
                children: [],
              ),
              PageOption.skill => Column(
                children: [],
              ),
              PageOption.reference => Column(
                children: [],
              )
            }
          )
        ]
      ),
    );
  }

  

}