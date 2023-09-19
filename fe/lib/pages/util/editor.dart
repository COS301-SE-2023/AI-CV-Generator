import 'dart:typed_data';

import 'package:ai_cv_generator/models/aimodels/AIEmployment.dart';
import 'package:ai_cv_generator/models/aimodels/AIQualification.dart';
import 'package:ai_cv_generator/models/aimodels/AIReference.dart';
import 'package:ai_cv_generator/models/aimodels/AISkill.dart';
import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:ai_cv_generator/pages/template/Template.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/menuButton.dart';
import 'package:ai_cv_generator/pages/widgets/loadingScreens/loadingScreen.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

enum PageOption {
  main,
  personDetails,
  professionalSummary,
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
  Editor({super.key, required this.data,required this.option});
  CVData data;
  final TemplateOption option;
  @override
  State<StatefulWidget> createState() => EditorState();
}

class EditorState extends State<Editor> {

  bool wait = true;
  late CVData data;
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

  // Text editing controllers for personalDetails
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  // Text editing controllers for professional descriptions
  TextEditingController descriptionController = TextEditingController();
  TextEditingController educationalDescriptionController = TextEditingController();

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
    fnameController.text = data.firstname??'First Name';
    lnameController.text = data.lastname??'Last Name';
    emailController.text = data.email??'Email';
    phoneNumberController.text = data.phoneNumber??'Phone Number';
    locationController.text = data.location??'Location';
    setState(() {
      option = PageOption.personDetails;
    });
  }

  savePersonalDetails() {
    data.firstname = fnameController.text;
    data.lastname = lnameController.text;
    data.email = emailController.text;
    data.phoneNumber = phoneNumberController.text;
    data.location = locationController.text;
    setState(() {
      option = PageOption.main;
    });
    updatePdf();
  }

  selectProfetionalSummary() {
    descriptionController.text = data.description??'Description';
    educationalDescriptionController.text = data.education_description??'Education Description';
    setState(() {
      option = PageOption.professionalSummary;
    });
  }

  saveProfessionalSummary() {
    data.description = descriptionController.text;
    data.education_description = educationalDescriptionController.text;
    setState(() {
      option = PageOption.main;
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
      data.employmenthistory![employmentIndex] = employment!;
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
      data.employmenthistory!.add(newEmployment);
      employment = newEmployment;
      employmentIndex = data.employmenthistory!.indexOf(newEmployment);
      option = PageOption.experience;
    });
    updatePdf();
  }

  deleteExperience(int index) {
    setState(() {
      data.employmenthistory!.removeAt(index);
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
      data.qualifications![qualificationIndex] = qualification!;
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
      data.qualifications!.add(newQualification);
      qualification = newQualification;
      qualificationIndex = data.qualifications!.indexOf(newQualification);
      option = PageOption.qualification;
    });
    updatePdf();
  }

  deleteQualification(int index) {
    setState(() {
      data.qualifications!.removeAt(index);
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
      data.skills![skillIndex] = skill!;
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
      data.skills!.add(newSkill);
      skill = newSkill;
      skillIndex = data.skills!.indexOf(newSkill);
      option = PageOption.skill;
    });
    updatePdf();
  }

  deleteSkill(int index) {
    setState(() {
      data.skills!.removeAt(index);
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
      data.references![referenceIndex] = reference!;
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
      data.references!.add(newReference);
      reference = newReference;
      referenceIndex = data.references!.indexOf(newReference);
      option = PageOption.reference;
    });
    updatePdf();
  }

  deleteReference(int index) {
    setState(() {
      data.references!.removeAt(index);
    });
    updatePdf();
  }

  save() {
    widget.data = data;
    Navigator.pop(context);
  }

  cancel() {
    Navigator.pop(context);
  }

  @override
  void initState() {
    data = widget.data;
    setOffLoadingScreen();
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
    return Container(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: Colors.grey.shade300
          ),
          color: Colors.grey.shade100
        ),
        width: 69*w,
        height: 85*h,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                ), 
                onPressed: () async { 
                  Navigator.pop(context);
                },
              ),
            ),
            body: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(w*1),
                  width: 27*w,
                  height: 85*h,
                  child: SfPdfViewer.asset(
                    'Documents/DocumentTest.pdf',
                    pageSpacing: 8
                  ),
                ),
                SizedBox(width: 2*w,),
                SingleChildScrollView(
                  child: 
                  // Menus
                  switch(option) {
                    PageOption.main => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MenuButton(
                          text: 'Pesonal Details',
                          width: w*30,
                          height: h*10,
                          onTap: () {
                            selectPersonalDetails();
                          },
                          fontSize: 1.2*w,
                        ),
                        const SizedBox(height: 10,),
                        MenuButton(
                          text: 'Professional Summary',
                          width: w*30,
                          height: h*10,
                          onTap: () {
                            selectProfetionalSummary();
                          },
                          fontSize: 1.2*w,
                        ),
                        const SizedBox(height: 10,),
                        MenuButton(
                          text: 'Experience',
                          width: w*30,
                          height: h*10,
                          onTap: () {
                            selectExperienceList();
                          },
                          fontSize: 1.2*w,
                        ),
                        const SizedBox(height: 10,),
                        MenuButton(
                          text: 'Education',
                          width: w*30,
                          height: h*10,
                          onTap: () {
                            selectQualificationList();
                          },
                          fontSize: 1.2*w,
                        ),
                        const SizedBox(height: 10,),
                        MenuButton(
                          text: 'Skills',
                          width: w*30,
                          height: h*10,
                          onTap: () {
                            selectSkillList();
                          },
                          fontSize: 1.2*w,
                        ),
                        const SizedBox(height: 10,),
                        MenuButton(
                          text: 'References',
                          width: w*30,
                          height: h*10,
                          onTap: () {
                            selectReferenceList();
                          },
                          fontSize: 1.2*w,
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomizableButton(
                              text: 'Save', 
                              width: 7*w, 
                              height: 28, 
                              onTap: () {
                                save();
                              }, 
                              fontSize: w*0.8
                            ),
                            SizedBox(width: w*3,),
                            CustomizableButton(
                              text: 'Cancel', 
                              width: 7*w, 
                              height: 28, 
                              onTap: () {
                                cancel();
                              }, 
                              fontSize: w*0.8
                            )
                          ],
                        )
                      ],
                    ),
                    PageOption.personDetails => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'Personal Details',
                            style: TextStyle(fontSize: 1.6*w),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          children: [
                            Container(
                              height: 80,
                              width: w*14.8,
                              padding: EdgeInsets.fromLTRB(0*w, 0, 0.2*w, 0),
                              child: TextFormField(
                                key: const Key('fname'),
                                controller: fnameController,
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(),
                                  labelText: 'First Name',
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field is required';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            Container(
                              height: 80,
                              width: w*14.8,
                              padding: EdgeInsets.fromLTRB(0.2*w, 0, 0*w, 0),
                              child: TextFormField(
                                key: const Key('lname'),
                                controller: lnameController,
                                decoration: const InputDecoration(
                                  enabledBorder: OutlineInputBorder(),
                                  labelText: 'Last Name',
                                ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'This field is required';
                                }
                                return null;
                              },
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 80,
                          width: 30*w,
                          child: TextFormField(
                            key: const Key('email'),
                            controller: emailController,
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                            validator: (value) {
                                if (!RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                .hasMatch(value!)) {
                                return 'This is not a valid email';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          width: 30*w,
                          child: TextFormField(
                            key: const Key('phoneNumber'),
                            controller: phoneNumberController,
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(),
                              labelText: 'Phone Number',
                            ),
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                        SizedBox(
                          height: 80,
                          width: 30*w,
                          child: TextFormField(
                            key: const Key('location'),
                            controller: locationController,
                            decoration: const InputDecoration(
                              enabledBorder: OutlineInputBorder(),
                              labelText: 'Location/Address',
                            ),
                            validator: (value) {
                              return null;
                            },
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomizableButton(
                              text: 'Update', 
                              width: 7*w, 
                              height: 28, 
                              onTap: () {
                                savePersonalDetails();
                              }, 
                              fontSize: w*0.8
                            ),
                            SizedBox(width: w*3,),
                            CustomizableButton(
                              text: 'Cancel', 
                              width: 7*w, 
                              height: 28, 
                              onTap: () {
                                selectMain();
                              }, 
                              fontSize: w*0.8
                            )
                          ],
                        )
                      ],
                    ),
                    PageOption.professionalSummary => Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            'Professional Summary',
                            style: TextStyle(fontSize: 1.6*w),
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Container (
                          constraints: BoxConstraints.tight(Size(30*w,200)),
                          child: TextFormField(
                            key: const Key("Description start"),
                            maxLines: 6,
                            controller: descriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Description',
                              enabledBorder: OutlineInputBorder(),
                              icon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          )
                        ),
                        Container (
                          constraints: BoxConstraints.tight(Size(30*w,200)),
                          child: TextFormField(
                            key: const Key("Educational Description"),
                            maxLines: 6,
                            controller: educationalDescriptionController,
                            decoration: const InputDecoration(
                              labelText: 'Educational Description',
                              enabledBorder: OutlineInputBorder(),
                              icon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter some text';
                              }
                              return null;
                            },
                          )
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CustomizableButton(
                              text: 'Update', 
                              width: 7*w, 
                              height: 28, 
                              onTap: () {
                                saveProfessionalSummary();
                              }, 
                              fontSize: w*0.8
                            ),
                            SizedBox(width: w*3,),
                            CustomizableButton(
                              text: 'Cancel', 
                              width: 7*w, 
                              height: 28, 
                              onTap: () {
                                selectMain();
                              }, 
                              fontSize: w*0.8
                            )
                          ],
                        )
                      ],
                    ),
                    PageOption.experienceList => Column(
                      children: [const Text("Not Ready")],
                    ),
                    PageOption.qualificationList => Column(
                      children: [const Text("Not Ready")],
                    ),
                    PageOption.skillList => Column(
                      children: [const Text("Not Ready")],
                    ),
                    PageOption.referenceList => Column(
                      children: [const Text("Not Ready")],
                    ),
                    PageOption.experience => Column(
                      children: [const Text("Not Ready")],
                    ),
                    PageOption.qualification => Column(
                      children: [const Text("Not Ready")],
                    ),
                    PageOption.skill => Column(
                      children: [const Text("Not Ready")],
                    ),
                    PageOption.reference => Column(
                      children: [const Text("Not Ready")],
                    )
                  }
                )
              ]
            ),
          )
        )
      )
    );
  }

  

}