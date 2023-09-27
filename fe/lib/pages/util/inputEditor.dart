import 'dart:typed_data';

import 'package:ai_cv_generator/models/aimodels/AIEmployment.dart';
import 'package:ai_cv_generator/models/aimodels/AIInput.dart';
import 'package:ai_cv_generator/models/aimodels/AILink.dart';
import 'package:ai_cv_generator/models/aimodels/AIQualification.dart';
import 'package:ai_cv_generator/models/aimodels/AIReference.dart';
import 'package:ai_cv_generator/models/aimodels/AISkill.dart';
import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:ai_cv_generator/pages/template/TemplateChoice.dart';
import 'package:ai_cv_generator/pages/util/colourPickBox.dart';
import 'package:ai_cv_generator/pages/util/templatePicker.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/deletableMenuButton.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/menuButton.dart';
import 'package:ai_cv_generator/pages/widgets/loadingscreens/loadingScreen.dart';
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
  linkList,
  experience,
  qualification,
  skill,
  reference,
  link
}

// ignore: must_be_immutable
class InputEditor extends StatefulWidget {
  InputEditor({
    super.key, 
    required this.data,
    required this.bytes
  });
  AIInput? data;
  final Uint8List bytes;
  @override
  State<StatefulWidget> createState() => InputEditorState();
}

class InputEditorState extends State<InputEditor> {

  // CV variables
  late AIInput data;
  bool wait = true;
  Uint8List? bytes;

  // Menu Management variables
  PageOption option = PageOption.main;
  int employmentIndex = 0;
  AIEmployment? employment;
  List<Widget> employmentList = [];
  int qualificationIndex = 0;
  AIQualification? qualification;
  List<Widget> qualificationList = [];
  int skillIndex = 0;
  AISkill? skill;
  List<Widget> skillList = [];
  int referenceIndex = 0;
  AIReference? reference;
  List<Widget> referenceList = [];
  int linkIndex = 0;
  AILink? link;
  List<Widget> linkList = [];

  // Text editing controllers for personalDetails
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  // Text editing controllers for professional descriptions
  TextEditingController descriptionController = TextEditingController();
  TextEditingController educationalDescriptionController = TextEditingController();

  // Text editing controllers for experience
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();

  // Text editing controllers for qualification
  TextEditingController qualificationController = TextEditingController();
  TextEditingController institutionController = TextEditingController();
  TextEditingController startDateQuaController = TextEditingController();
  TextEditingController endDateQuaController = TextEditingController();

  // Text editing controllers for skill
  TextEditingController skillController = TextEditingController();
  TextEditingController reasonController = TextEditingController();
  TextEditingController levelController = TextEditingController();

  final List<String> _dropdownItems = [
    '0',
    '1',
    '2',
    '3',
    '4',
    '5'
  ];

  // Text editing controllers for reference
  TextEditingController contactController = TextEditingController();
  TextEditingController descriptionRefController = TextEditingController();

  // Text editing controllers for link
  TextEditingController urlController = TextEditingController();


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
  }

  selectProfetionalSummary() {
    descriptionController.text = data.description??'Description';
    setState(() {
      option = PageOption.professionalSummary;
    });
  }

  saveProfessionalSummary() {
    data.description = descriptionController.text;
    setState(() {
      option = PageOption.main;
    });
  }

  updateEmploymentList() {
    employmentList = [];
    for (AIEmployment emp in data.experience) {
      employmentList.add(
        experienceButton(
          emp, 
          data.experience.indexOf(emp), 
        )
      );
    }
  }

  selectExperienceList() {
    updateEmploymentList();
    setState(() {
      option = PageOption.experienceList;
    });
  }

  updateQualificationList() {
    qualificationList = [];
    for (AIQualification qua in data.qualifications) {
      qualificationList.add(
        qualificationButton(
          qua, 
          data.qualifications.indexOf(qua)
        )
      );
    }
  }

  selectQualificationList() {
    updateQualificationList();
    setState(() {
      option = PageOption.qualificationList;
    });
  }

  updateSkillList() {
    skillList = [];
    for (AISkill skill in data.skills) {
      skillList.add(
        skillButton(
          skill, 
          data.skills.indexOf(skill)
        )
      );
    }
  }

  selectSkillList() {
    updateSkillList();
    setState(() {
      option = PageOption.skillList;
    });
  }

  updateReferenceList() {
    referenceList = [];
    for (AIReference ref in data.references) {
      referenceList.add(
        referenceButton(
          ref, 
          data.references.indexOf(ref)
        )
      );
    }
  }

  selectReferenceList() {
    updateReferenceList();
    setState(() {
      option = PageOption.referenceList;
    });
  }

  updateLinkList() {
    linkList = [];
    for (AILink lin in data.links) {
      linkList.add(
        linkButton(
          lin, 
          data.links.indexOf(lin)
        )
      );
    }
  }

  selectLinkList() {
    updateLinkList();
    setState(() {
      option = PageOption.linkList;
    });
  }

  selectExperience(AIEmployment employment, int employmentIndex) {
    companyController.text = data.experience[employmentIndex].company??'Company';
    jobTitleController.text = data.experience[employmentIndex].jobTitle??'Job Title';
    startDateController.text = data.experience[employmentIndex].startDate??'Start Date';
    endDateController.text = data.experience[employmentIndex].endDate??'End Date';
    setState(() {
      this.employment = employment;
      this.employmentIndex = employmentIndex;
      option = PageOption.experience;
    });
  }

  saveExperience() {
    employment!.company = companyController.text;
    employment!.jobTitle = jobTitleController.text;
    employment!.startDate = startDateController.text;
    employment!.endDate = endDateController.text;
    setState(() {
      data.experience[employmentIndex] = employment!;
      option = PageOption.experienceList;
    });
    updateEmploymentList();
  }

  addExperience() {
    AIEmployment newEmployment = AIEmployment(
      company: 'Company',
      jobTitle: 'JobTitle',
      startDate: '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}',
      endDate: '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}'
    );
    companyController.text = newEmployment.company!;
    jobTitleController.text = newEmployment.jobTitle!;
    startDateController.text = newEmployment.startDate!;
    endDateController.text = newEmployment.endDate!;
    setState(() {
      data.experience.add(newEmployment);
    });
    updateEmploymentList();
  }

  deleteExperience(int index) {
    setState(() {
      data.experience.removeAt(index);
    });
    updateEmploymentList();
    
  }

  selectQualification(AIQualification qualification, int qualificationIndex) {
    qualificationController.text = qualification.qualification??'Qualification';
    institutionController.text = qualification.institution??'Instatution';
    startDateQuaController.text = qualification.startDate??'Start Date';
    endDateQuaController.text = qualification.endDate??'End Date';
    setState(() {
      this.qualification = qualification;
      this.qualificationIndex = qualificationIndex;
      option = PageOption.qualification;
    });
  }

  saveQualification() {
    qualification!.qualification = qualificationController.text;
    qualification!.institution = institutionController.text;
    qualification!.startDate = startDateQuaController.text;
    qualification!.endDate = endDateQuaController.text;
    setState(() {
      data.qualifications[qualificationIndex] = qualification!;
      option = PageOption.qualificationList;
    });
    updateQualificationList();
    
  }

  addQualification() {
    AIQualification newQualification = AIQualification(
      qualification: 'Qualification',
      institution: 'Institution',
      startDate: '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}',
      endDate: '${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}'
    );
    qualificationController.text = newQualification.qualification!;
    institutionController.text = newQualification.institution!;
    startDateQuaController.text = newQualification.startDate!;
    endDateQuaController.text = newQualification.endDate!;
    setState(() {
      data.qualifications.add(newQualification);
    });
    updateQualificationList();
    
  }

  deleteQualification(int index) {
    setState(() {
      data.qualifications.removeAt(index);
    });
    updateQualificationList();
    
  }

  selectSkill(AISkill skill,int skillIndex) {
    skillController.text = skill.skill??'Skill';
    reasonController.text = skill.reason??'Reason';
    levelController.text = skill.level??'5';
    setState(() {
      this.skill = skill;
      this.skillIndex = skillIndex;
      option = PageOption.skill;
    });
  }

  saveSkill() {
    skill!.skill = skillController.text;
    skill!.reason = reasonController.text;
    skill!.level = levelController.text;
    setState(() {
      data.skills[skillIndex] = skill!;
      option = PageOption.skillList;
    });
    updateSkillList();
    
  }

  addSkill() {
    AISkill newSkill = AISkill(
      skill: 'Skill',
      level: 5.toString(),
      reason: 'Reason'
    );
    skillController.text = newSkill.skill!;
    reasonController.text = newSkill.reason!;
    levelController.text = newSkill.level!;
    setState(() {
      data.skills.add(newSkill);
    });
    updateSkillList();
    
  }

  deleteSkill(int index) {
    setState(() {
      data.skills.removeAt(index);
    });
    updateSkillList();
    
  } 

  selectReference(AIReference reference, int referenceIndex) {
    contactController.text = reference.contact??'Contact';
    descriptionRefController.text = reference.description??'Description';
    setState(() {
      this.reference = reference;
      this.referenceIndex = referenceIndex;
      option = PageOption.reference;
    });
  }

  saveReference() {
    reference!.contact = contactController.text;
    reference!.description = descriptionRefController.text;
    setState(() {
      data.references[referenceIndex] = reference!;
      option = PageOption.referenceList;
    });
    updateReferenceList();
    
  }

  addReference() {
    AIReference newReference = AIReference(
      description: 'Description',
      contact: 'Contact'
    );
    contactController.text = newReference.contact!;
    descriptionRefController.text = newReference.description!;
    setState(() {
      data.references.add(newReference);
    });
    updateReferenceList();
    
  }

  deleteReference(int index) {
    setState(() {
      data.references.removeAt(index);
    });
    updateReferenceList();
  }

  selectLink(AILink link, int linkIndex) {
    urlController.text = link.url??'Url';
    setState(() {
      this.link = link;
      this.linkIndex = linkIndex;
      option = PageOption.link;
    });
  }

  saveLink() {
    link!.url = urlController.text;
    setState(() {
      data.links[linkIndex] = link!;
      option = PageOption.linkList;
    });
    updateLinkList();
    
  }

  addLink() {
    AILink newLink = AILink(
      url: 'Url '
    );
    urlController.text = newLink.url!;
    setState(() {
      data.links.add(newLink);
    });
    updateLinkList();
    
  }

  deleteLink(int index) {
    setState(() {
      data.links.removeAt(index);
    });
    updateLinkList();
    
  }

  save() {
    widget.data = data;
    Navigator.pop(context);
  }

  cancel() {
    widget.data = null;
    Navigator.pop(context);
  }

  updateBank() {

  }

  undo() {

  }

  Widget experienceButton(AIEmployment employmentOp,int index) {
    return Container(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5
      ),
      child: DeletableMenuButton(
        text: '${employmentOp.jobTitle??'Job Title'} / ${employmentOp.company??'Company'}',
        onTap: () {
          selectExperience(employmentOp, index);
        },
        onDeletePressed: () {
          deleteExperience(index);
        }
      ),
    );
  }

  Widget qualificationButton(AIQualification qualificationOp,int index) {
    return Container(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5
      ),
      child: DeletableMenuButton(
        text: '${qualificationOp.qualification??'Qualification'} / ${qualificationOp.institution??'Instatution'}',
        onTap: () {
          selectQualification(qualificationOp, index);
        },
        onDeletePressed: () {
          deleteQualification(index);
        }
      ),
    );
  }

  Widget skillButton(AISkill skillOp,int index) {
    return Container(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5
      ),
      child: DeletableMenuButton(
        text: '${skillOp.skill??'Skill'} / ${skillOp.reason??'Reason'}',
        onTap: () {
          selectSkill(skillOp, index);
        },
        onDeletePressed: () {
          deleteSkill(index);
        }
      ),
    );
  }

  Widget referenceButton(AIReference referenceOp,int index) {
    return Container(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5
      ),
      child: DeletableMenuButton(
        text: '${referenceOp.contact??'Contact'} / ${referenceOp.description??'Description'}',
        onTap: () {
          selectReference(referenceOp, index);
        },
        onDeletePressed: () {
          deleteReference(index);
        }
      ),
    );
  }

  Widget linkButton(AILink linkOp,int index) {
    return Container(
      padding: const EdgeInsets.only(
        top: 5,
        bottom: 5
      ),
      child: DeletableMenuButton(
        text: linkOp.url??'Url',
        onTap: () {
          selectLink(linkOp, index);
        },
        onDeletePressed: () {
          deleteLink(index);
        }
      ),
    );
  }

  @override
  void initState() {
    data = widget.data!;
    bytes = widget.bytes;
    setState(() {
      wait = false;
    });
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
        width: 70*w,
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
                  child: SfPdfViewer.memory(
                    bytes!,
                  )
                ),
                SizedBox(width: 2*w,),
                SingleChildScrollView(
                  child: 
                  // Menus
                  switch(option) {
                    PageOption.main => mainMenu(w,h),
                    PageOption.personDetails => personalDetailMenu(w, h),
                    PageOption.professionalSummary => professionalSummaryMenu(w, h),
                    PageOption.experienceList => experienceListMenu(w, h),
                    PageOption.qualificationList => qualificationListMenu(w, h),
                    PageOption.skillList => skillListMenu(w, h),
                    PageOption.referenceList => referenceListMenu(w, h),
                    PageOption.linkList => linkListMenu(w, h),
                    PageOption.experience => experienceMenu(w, h),
                    PageOption.qualification => qualificationMenu(w, h),
                    PageOption.skill => skillMenu(w, h),
                    PageOption.reference => referenceMenu(w, h),
                    PageOption.link => linkMenu(w, h)
                  }
                )
              ]
            ),
          )
        )
      )
    );
  }

  // Menus
  // Main Menu
  Widget mainMenu(double w, double h) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        MenuButton(
          text: 'Pesonal Details',
          width: w*30,
          height: h*8,
          onTap: () {
            selectPersonalDetails();
          },
          fontSize: 1.2*w,
        ),
        const SizedBox(height: 10,),
        MenuButton(
          text: 'Professional Summary',
          width: w*30,
          height: h*8,
          onTap: () {
            selectProfetionalSummary();
          },
          fontSize: 1.2*w,
        ),
        const SizedBox(height: 10,),
        MenuButton(
          text: 'Experience',
          width: w*30,
          height: h*8,
          onTap: () {
            selectExperienceList();
          },
          fontSize: 1.2*w,
        ),
        const SizedBox(height: 10,),
        MenuButton(
          text: 'Qualifications / Certifications',
          width: w*30,
          height: h*8,
          onTap: () {
            selectQualificationList();
          },
          fontSize: 1.2*w,
        ),
        const SizedBox(height: 10,),
        MenuButton(
          text: 'Skills',
          width: w*30,
          height: h*8,
          onTap: () {
            selectSkillList();
          },
          fontSize: 1.2*w,
        ),
        const SizedBox(height: 10,),
        MenuButton(
          text: 'References',
          width: w*30,
          height: h*8,
          onTap: () {
            selectReferenceList();
          },
          fontSize: 1.2*w,
        ),
        const SizedBox(height: 10,),
        MenuButton(
          text: 'Links',
          width: w*30,
          height: h*8,
          onTap: () {
            selectLinkList();
          },
          fontSize: 1.2*w,
        ),
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomizableButton(
              text: 'Continue', 
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
    );
  }


  // Personal Details Menu
  Widget personalDetailMenu(double w, double h) {
    return Column(
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
                maxLength: 50,
                key: const Key('fname'),
                controller: fnameController,
                decoration: const InputDecoration(
                  counterText: "",
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
                maxLength: 50,
                key: const Key('lname'),
                controller: lnameController,
                decoration: const InputDecoration(
                  counterText: "",
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
            maxLength: 50,
            key: const Key('email'),
            controller: emailController,
            decoration: const InputDecoration(
              counterText: "",
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
            maxLength: 20,
            key: const Key('phoneNumber'),
            controller: phoneNumberController,
            decoration: const InputDecoration(
              counterText: "",
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
            maxLength: 50,
            key: const Key('location'),
            controller: locationController,
            decoration: const InputDecoration(
              counterText: "",
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
    );
  }

  Widget professionalSummaryMenu(double w, double h) {
    return Column(
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
    );
  }

  Widget experienceListMenu(double w, double h) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10,),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Experience',
            style: TextStyle(fontSize: 1.6*w),
          ),
        ),
        const SizedBox(height: 20,),
        if (employmentList.isNotEmpty)
        ...employmentList,
        if (employmentList.isEmpty) 
        SizedBox(
          width: w*30,
          height: 300,
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cases_rounded,color: Colors.grey,size: 100,),
                SizedBox(height: 20),
                Text(
                  "No Work Experience...", 
                  style: TextStyle(
                    color: Colors.grey
                  )
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomizableButton(
              text: 'Back', 
              width: 7*w, 
              height: 28, 
              onTap: () {
                selectMain();
              }, 
              fontSize: w*0.8
            ),
            SizedBox(width: w*3,),
            CustomizableButton(
              text: 'Add', 
              width: 7*w, 
              height: 28, 
              onTap: () {
                addExperience();
              }, 
              fontSize: w*0.8
            )
          ],
        )
      ],
    );
  }

  Widget qualificationListMenu(double w, double h) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10,),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Qualifications / Certifications',
            style: TextStyle(fontSize: 1.6*w),
          ),
        ),
        const SizedBox(height: 20,),
        if (qualificationList.isNotEmpty)
        ...qualificationList,
        if (qualificationList.isEmpty) 
        SizedBox(
          width: w*30,
          height: 300,
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.school,color: Colors.grey,size: 100,),
                SizedBox(height: 20),
                Text(
                  "No Qualifications...", 
                  style: TextStyle(
                    color: Colors.grey
                  )
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomizableButton(
              text: 'Back', 
              width: 7*w, 
              height: 28, 
              onTap: () {
                selectMain();
              }, 
              fontSize: w*0.8
            ),
            SizedBox(width: w*3,),
            CustomizableButton(
              text: 'Add', 
              width: 7*w, 
              height: 28, 
              onTap: () {
                addQualification();
              }, 
              fontSize: w*0.8
            )
          ],
        )
      ],
    );
  }

  Widget skillListMenu(double w, double h) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10,),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Skills',
            style: TextStyle(fontSize: 1.6*w),
          ),
        ),
        const SizedBox(height: 20,),
        if (skillList.isNotEmpty)
        ...skillList,
        if (skillList.isEmpty) 
        SizedBox(
          width: w*30,
          height: 300,
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.flag,color: Colors.grey,size: 100,),
                SizedBox(height: 20),
                Text(
                  "No Skills...", 
                  style: TextStyle(
                    color: Colors.grey
                  )
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomizableButton(
              text: 'Back', 
              width: 7*w, 
              height: 28, 
              onTap: () {
                selectMain();
              }, 
              fontSize: w*0.8
            ),
            SizedBox(width: w*3,),
            CustomizableButton(
              text: 'Add', 
              width: 7*w, 
              height: 28, 
              onTap: () {
                addSkill();
              }, 
              fontSize: w*0.8
            )
          ],
        )
      ],
    );
  }

  Widget referenceListMenu(double w, double h) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10,),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            'References',
            style: TextStyle(fontSize: 1.6*w),
          ),
        ),
        const SizedBox(height: 20,),
        if (referenceList.isNotEmpty)
        ...referenceList,
        if (referenceList.isEmpty) 
        SizedBox(
          width: w*30,
          height: 300,
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.people,color: Colors.grey,size: 100,),
                SizedBox(height: 20),
                Text(
                  "No References...", 
                  style: TextStyle(
                    color: Colors.grey
                  )
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomizableButton(
              text: 'Back', 
              width: 7*w, 
              height: 28, 
              onTap: () {
                selectMain();
              }, 
              fontSize: w*0.8
            ),
            SizedBox(width: w*3,),
            CustomizableButton(
              text: 'Add', 
              width: 7*w, 
              height: 28, 
              onTap: () {
                addReference();
              }, 
              fontSize: w*0.8
            )
          ],
        )
      ],
    );
  }

  Widget linkListMenu(double w, double h) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10,),
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Links',
            style: TextStyle(fontSize: 1.6*w),
          ),
        ),
        const SizedBox(height: 20,),
        if (linkList.isNotEmpty)
        ...linkList,
        if (linkList.isEmpty) 
        SizedBox(
          width: w*30,
          height: 300,
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.link,color: Colors.grey,size: 100,),
                SizedBox(height: 20),
                Text(
                  "No Links...", 
                  style: TextStyle(
                    color: Colors.grey
                  )
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomizableButton(
              text: 'Back', 
              width: 7*w, 
              height: 28, 
              onTap: () {
                selectMain();
              }, 
              fontSize: w*0.8
            ),
            SizedBox(width: w*3,),
            CustomizableButton(
              text: 'Add', 
              width: 7*w, 
              height: 28, 
              onTap: () {
                addLink();
              }, 
              fontSize: w*0.8
            )
          ],
        )
      ],
    );
  }

  Widget experienceMenu(double w, double h) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Experience',
            style: TextStyle(fontSize: 1.6*w),
          ),
        ),
        const SizedBox(height: 20,),
        SizedBox(
          height: 80,
          width: 30*w,
          child: TextFormField(
            key: const Key('jobTtitle'),
            maxLength: 50,
            controller: jobTitleController,
            decoration: const InputDecoration(
              counterText: "",
              enabledBorder: OutlineInputBorder(),
              labelText: 'Job Title',
            ),
            validator: (value) {
              return null;
            },
          ),
        ),
        const SizedBox(height: 20,),
        SizedBox(
          height: 80,
          width: 30*w,
          child: TextFormField(
            maxLength: 50,
            key: const Key('company'),
            controller: companyController,
            decoration: const InputDecoration(
              counterText: "",
              enabledBorder: OutlineInputBorder(),
              labelText: 'Company/Instatution',
            ),
            validator: (value) {
              return null;
            },
          ),
        ),
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  setState(() {
                    datePicker(context).then((value) {
                      if(value != null) {
                        startDateController.text = '${value.year}/${value.month}/${value.day}';
                      }
                    });
                  });
                });
              },
              child: SizedBox(
                height: 80,
                width: 14*w,
                child: TextFormField(
                  enabled: false,
                  key: const Key('startDate'),
                  controller: startDateController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    labelText: 'Start Date',
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(width: 2*w,),
            GestureDetector(
              onTap: () {
                setState(() {
                  setState(() {
                    datePicker(context).then((value) {
                      if(value != null) {
                        endDateController.text = '${value.year}/${value.month}/${value.day}';
                      }
                    });
                  });
                });
              },
              child: SizedBox(
                height: 80,
                width: 14*w,
                child: TextFormField(
                  enabled: false,
                  key: const Key('endDate'),
                  controller: endDateController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    labelText: 'End Date',
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
              ),
            )
          ],
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
                saveExperience();
              }, 
              fontSize: w*0.8
            ),
            SizedBox(width: w*3,),
            CustomizableButton(
              text: 'Cancel', 
              width: 7*w, 
              height: 28, 
              onTap: () {
                selectExperienceList();
              }, 
              fontSize: w*0.8
            )
          ],
        )
      ],
    );
  }

  Widget qualificationMenu(double w, double h) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Qualification',
            style: TextStyle(fontSize: 1.6*w),
          ),
        ),
        const SizedBox(height: 20,),
        SizedBox(
          height: 80,
          width: 30*w,
          child: TextFormField(
            maxLength: 50,
            key: const Key('qualification'),
            controller: qualificationController,
            decoration: const InputDecoration(
              counterText: "",
              enabledBorder: OutlineInputBorder(),
              labelText: 'Qualification',
            ),
            validator: (value) {
              return null;
            },
          ),
        ),
        const SizedBox(height: 20,),
        SizedBox(
          height: 80,
          width: 30*w,
          child: TextFormField(
            maxLength: 50,
            key: const Key('instatution'),
            controller: institutionController,
            decoration: const InputDecoration(
              counterText: "",
              enabledBorder: OutlineInputBorder(),
              labelText: 'Instatution/School',
            ),
            validator: (value) {
              return null;
            },
          ),
        ),
        const SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  setState(() {
                    datePicker(context).then((value) {
                      if(value != null) {
                        startDateQuaController.text = '${value.year}/${value.month}/${value.day}';
                      }
                    });
                  });
                });
              },
              child: SizedBox(
                height: 80,
                width: 14*w,
                child: TextFormField(
                  enabled: false,
                  key: const Key('startDate'),
                  controller: startDateQuaController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    labelText: 'Start Date',
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
              ),
            ),
            SizedBox(width: 2*w,),
            GestureDetector(
              onTap: () {
                setState(() {
                  setState(() {
                    datePicker(context).then((value) {
                      if(value != null) {
                        endDateQuaController.text = '${value.year}/${value.month}/${value.day}';
                      }
                    });
                  });
                });
              },
              child: SizedBox(
                height: 80,
                width: 14*w,
                child: TextFormField(
                  enabled: false,
                  key: const Key('endDate'),
                  controller: endDateQuaController,
                  decoration: const InputDecoration(
                    enabledBorder: OutlineInputBorder(),
                    labelText: 'End Date',
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
              ),
            )
          ],
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
                saveQualification();
              }, 
              fontSize: w*0.8
            ),
            SizedBox(width: w*3,),
            CustomizableButton(
              text: 'Cancel', 
              width: 7*w, 
              height: 28, 
              onTap: () {
                selectQualificationList();
              }, 
              fontSize: w*0.8
            )
          ],
        )
      ],
    );
  }

  Widget skillMenu(double w, double h) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Skill',
            style: TextStyle(fontSize: 1.6*w),
          ),
        ),
        const SizedBox(height: 20,),
        SizedBox(
          height: 80,
          width: 30*w,
          child: TextFormField(
            maxLength: 50,
            key: const Key('skill'),
            controller: skillController,
            decoration: const InputDecoration(
              counterText: "",
              enabledBorder: OutlineInputBorder(),
              labelText: 'Skill',
            ),
            validator: (value) {
              return null;
            },
          ),
        ),
        const SizedBox(height: 20,),
        SizedBox(
          height: 80,
          width: 30*w,
          child: TextFormField(
            maxLength: 50,
            key: const Key('reason'),
            controller: reasonController,
            decoration: const InputDecoration(
              counterText: "",
              enabledBorder: OutlineInputBorder(),
              labelText: 'Reason',
            ),
            validator: (value) {
              return null;
            },
          ),
        ),
        const SizedBox(height: 20,),
        Container(
          width: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey.shade100
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Level: '),
              DropdownButton<String>(
                value: levelController.text,
                onChanged: (String? newValue) {
                  levelController.text = newValue??'0';
                  setState(() {});
                },
                items: _dropdownItems.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
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
                saveSkill();
              }, 
              fontSize: w*0.8
            ),
            SizedBox(width: w*3,),
            CustomizableButton(
              text: 'Cancel', 
              width: 7*w, 
              height: 28, 
              onTap: () {
                selectSkillList();
              }, 
              fontSize: w*0.8
            )
          ],
        )
      ],
    );
  }

  Widget referenceMenu(double w, double h) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Reference',
            style: TextStyle(fontSize: 1.6*w),
          ),
        ),
        const SizedBox(height: 20,),
        SizedBox(
          height: 80,
          width: 30*w,
          child: TextFormField(
            maxLength: 50,
            key: const Key('contact'),
            controller: contactController,
            decoration: const InputDecoration(
              counterText: "",
              enabledBorder: OutlineInputBorder(),
              labelText: 'Contact',
            ),
            validator: (value) {
              return null;
            },
          ),
        ),
        const SizedBox(height: 20,),
        SizedBox(
          height: 80,
          width: 30*w,
          child: TextFormField(
            maxLength: 50,
            key: const Key('description'),
            controller: descriptionRefController,
            decoration: const InputDecoration(
              counterText: "",
              enabledBorder: OutlineInputBorder(),
              labelText: 'Description',
            ),
            validator: (value) {
              return null;
            },
          ),
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
                saveReference();
              }, 
              fontSize: w*0.8
            ),
            SizedBox(width: w*3,),
            CustomizableButton(
              text: 'Cancel', 
              width: 7*w, 
              height: 28, 
              onTap: () {
                selectReferenceList();
              }, 
              fontSize: w*0.8
            )
          ],
        )
      ],
    );
  }

  Widget linkMenu(double w, double h) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Text(
            'Link',
            style: TextStyle(fontSize: 1.6*w),
          ),
        ),
        const SizedBox(height: 20,),
        SizedBox(
          height: 80,
          width: 30*w,
          child: TextFormField(
            maxLength: 200,
            key: const Key('url'),
            controller: urlController,
            decoration: const InputDecoration(
              counterText: "",
              enabledBorder: OutlineInputBorder(),
              labelText: 'Url',
            ),
            validator: (value) {
              return null;
            },
          ),
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
                saveLink();
              }, 
              fontSize: w*0.8
            ),
            SizedBox(width: w*3,),
            CustomizableButton(
              text: 'Cancel', 
              width: 7*w, 
              height: 28, 
              onTap: () {
                selectLinkList();
              }, 
              fontSize: w*0.8
            )
          ],
        )
      ],
    );
  }

  Future<DateTime?> datePicker(BuildContext context) async {
    return showDatePicker(
        context: context, 
        initialEntryMode: DatePickerEntryMode.input, 
        firstDate: DateTime.now().subtract(const Duration(days:365*100)), 
        initialDate: DateTime.now(),
        lastDate: DateTime.now()
      );
  }
}