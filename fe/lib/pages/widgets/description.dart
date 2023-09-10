// internal
import 'package:ai_cv_generator/pages/screens/home.dart';
import 'package:ai_cv_generator/pages/util/strings.dart';
import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:ai_cv_generator/pages/widgets/questionaireModal.dart';
import 'package:ai_cv_generator/pages/widgets/skillsForm.dart';

// external
import 'package:flutter/material.dart';


class DescriptionForm extends StatefulWidget {
   DescriptionForm({super.key});

  @override
  State<StatefulWidget> createState() => DescriptionFormState();
}

class DescriptionFormState extends State<DescriptionForm> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController descripC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    descripC.text = Home.adjustedModel!.description??"";
    return Scaffold(
      drawer:  NavDrawer(),
      appBar: AppBar(
        leading: IconButton(
          icon:  Icon(
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
              child: titleSection,
            ),
            Expanded(
              child:Container (
                padding:  EdgeInsets.all(8.0),
                constraints: BoxConstraints.tight( Size(550,200)),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    key:  Key("Description start"),
                    maxLines: 6,
                    controller: descripC,
                    decoration:  InputDecoration(
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
             SizedBox(height: 200,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    child:  Text('Back'),
                    onPressed: () {
                      updateUser();
                      Navigator.of(context).pop();
                      showQuestionaireModal(context,  SkillsDetailsForm());
                    },
                  ),
                ),
                 SizedBox(width: 64,),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    child:  Text('Save and Proceed'),
                    onPressed: () async {
                      if(updateUser() == false) {
                        return;
                      }
                      Home.ready = true;
                      Navigator.popUntil(context, ModalRoute.withName('/home'));
                    },
                  ),
                ),

            ],
          ),
             SizedBox(height: 64,),
          ]
        )
      )
    );
  }

  bool updateUser() {
    Home.adjustedModel!.description = descripC.text;
    return _formKey.currentState!.validate();
  }

  Widget titleSection= Column (
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget> [
        Padding (
          padding: EdgeInsets.all(8.0),
            child: Text (
              StringsDescription.appsubHeadingTitle,
              style: TextStyle (
                fontSize: 20.0,
              ),
          ),
        ),
      ],
    );

}