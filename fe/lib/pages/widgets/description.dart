// internal
import 'package:ai_cv_generator/pages/screens/homeRedo.dart';
import 'package:ai_cv_generator/pages/util/strings.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:ai_cv_generator/pages/widgets/questionaireModal.dart';
import 'package:ai_cv_generator/pages/widgets/skillsForm.dart';

// external
import 'package:flutter/material.dart';

class DescriptionFormTest extends StatefulWidget{
  DescriptionFormTest({super.key});

  @override
  State<StatefulWidget> createState() => DescriptionFormTestState();
}

class DescriptionFormTestState extends State<DescriptionFormTest> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: DescriptionForm(),
    );
  }
}

class DescriptionForm extends StatefulWidget {
   const DescriptionForm({super.key});

  @override
  State<StatefulWidget> createState() => DescriptionFormState();
}

class DescriptionFormState extends State<DescriptionForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController descripC = TextEditingController();

  back() {
     Navigator.of(context).pop();
    showQuestionaireModal(context, const SkillsDetailsForm());
  }

  toNext() {
    Home.ready = true;
    Navigator.popUntil(context, ModalRoute.withName('/home'));
  }

  @override
  Widget build(BuildContext context) {
    descripC.text = Home.adjustedModel!.description??"";
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100; 
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.close,
          ), 
          onPressed: () async { 
            Navigator.popUntil(context, ModalRoute.withName('/home'));
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: titleSection(w,h),
            ),
            Expanded(
              child:Container (
                padding: const EdgeInsets.all(8.0),
                constraints: BoxConstraints.tight(const Size(550,200)),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    key: const Key("Description start"),
                    maxLines: 6,
                    controller: descripC,
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
                )
              ),
            ),
            const SizedBox(height: 200,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                CustomizableButton(
                  text: 'Back',
                  width: w*8,
                  height: h*5,
                  onTap: () {
                    updateUser();
                    back();
                  },
                  fontSize: w*h*0.1,
                ),
                SizedBox(width: 6.4*w,),
                CustomizableButton(
                  text: 'Save and Proceed',
                  width: w*8,
                  height: h*5,
                  onTap: () {
                    if(updateUser() == false) {
                      return;
                    }
                    toNext();
                  },
                  fontSize: w*h*0.1,
                ),
              ],
            ),
            SizedBox(height: 4*h,),
          ]
        )
      )
    );
  }

  bool updateUser() {
    Home.adjustedModel!.description = descripC.text;
    return _formKey.currentState!.validate();
  }

  Widget titleSection(double w,double h) {
    return Column (
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget> [
        Padding (
          padding: EdgeInsets.all(0.8*w),
            child: Text (
              StringsDescription.appsubHeadingTitle,
              style: TextStyle (
                fontSize: w*h*0.2
              ),
          ),
        ),
      ],
    );
  }
}