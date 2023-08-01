
import 'package:ai_cv_generator/pages/util/strings.dart';
import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:ai_cv_generator/pages/widgets/questionaireModal.dart';
import 'package:flutter/material.dart';

import '../screens/home.dart';
import 'employment.dart';

class DescriptionForm extends StatefulWidget {
  const DescriptionForm({super.key});

  @override
  State<StatefulWidget> createState() => DescriptionFormState();
}

class DescriptionFormState extends State<DescriptionForm> {
  TextEditingController descripC = TextEditingController();
  @override
  Widget build(BuildContext context) {
    descripC.text = Home.adjustedModel!.description??"";
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
              child: titleSection,
            ),
            Expanded(
              child:Container (
                padding: const EdgeInsets.all(8.0),
                constraints: BoxConstraints.tight(const Size(550,200)),
                child: TextFormField(
                  maxLines: 6,
                  controller: descripC,
                  decoration: const InputDecoration(
                    // contentPadding: EdgeInsets.all(5.0),
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
            ),
            const SizedBox(height: 200,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    child: const Text('Back'),
                    onPressed: () {
                      updateUser();
                      Navigator.of(context).pop();
                      showQuestionaireModal(context, const EmploymentDetailsForm());
                    },
                  ),
                ),
                const SizedBox(width: 64,),
                SizedBox(
                  height: 50,
                  width: 150,
                  child: ElevatedButton(
                    child: const Text('Save and Proceed'),
                    onPressed: () async {
                      updateUser();
                      Home.ready = true;
                      Navigator.popUntil(context, ModalRoute.withName('/home'));
                    },
                  ),
                ),

            ],
          ),
            const SizedBox(height: 64,),
          ]
        )
      )
    );
  }

  updateUser() {
      Home.adjustedModel!.description = descripC.text;
      
    }

  Widget titleSection=const Column (
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