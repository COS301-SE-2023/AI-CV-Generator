// ignore_for_file: must_be_immutable

import 'package:ai_cv_generator/pages/strings.dart';
import 'package:flutter/material.dart';

void main () => runApp(SkillSection());

class SkillForm extends StatefulWidget {
  const SkillForm({super.key});

  @override
  SkillFormState createState() {
    return SkillFormState();
  }
}

class SkillFormState extends State<SkillForm> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController skill = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center (
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(const Size(550,50)),
                child: TextFormField(
                  // The validator receives the text that the user has entered.
                  controller: skill,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(  
                    icon: Icon(Icons.settings),  
                    //hintText: 'Enter your name',  
                    labelText: 'Skill',
                    enabledBorder: OutlineInputBorder(),
                  ), 
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center (
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Save & Proceed'),
              ),
            ),
          ),
        
        ],
      ),
    );
  }
}


class SkillSection extends StatelessWidget {

  //titleSection widget
    Widget titleSection=const Column (
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget> [
        Padding (
          padding: EdgeInsets.all(8.0),
            child: Text (
              StringsSkill.appHeadingTitle,
              style: TextStyle (
                fontSize: 30.0,
            ),
          ),
        ),
        
        Padding (
          padding: EdgeInsets.all(8.0),
            child: Text (
              StringsSkill.appsubHeadingTitle,
              style: TextStyle (
                fontSize: 20.0,
              ),
          ),
        ),
        
      ],
    );

  SkillSection({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: StringsSkill.appBarTitle,
        home: Scaffold (
          appBar: AppBar(
            title: const Text(StringsSkill.appBarTitle),
          ),
          body: ListView(
            children: <Widget>[
              titleSection,
              const SkillForm(),
            ],
          ),
        ),
      );
  }//MaterialApp
}

