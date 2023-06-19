// ignore_for_file: must_be_immutable

import 'package:ai_cv_generator/pages/employment.dart';
import 'package:ai_cv_generator/pages/references.dart';
import 'package:ai_cv_generator/pages/strings.dart';
import 'package:flutter/material.dart';

void main () => runApp(const Skills());

class Skills extends StatelessWidget {
  const Skills({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: StringsSkill.appBarTitle,
      home: SkillsForm(),
    );
  }
}

class SkillsForm extends StatefulWidget {
  const SkillsForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SkillsFormState();
  }
}

class _SkillsFormState extends State<SkillsForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController skill = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringsSkill.appBarTitle),
      ),
      body: Center (
        child: _buildForm(),
      )
    );
  }

  Widget titleSection=const Column (
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget> [
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


  Widget _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            titleSection,
            _buildSkillField(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget> [
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildBackButton(),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: _buildSubmitButton(),
                ),
              ],
            ),
          ],
        ));
  }

  Widget _buildSkillField() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: skill,
        decoration: const InputDecoration(
          labelText: 'Skill',
          enabledBorder: OutlineInputBorder(),
        ),
        // ignore: body_might_complete_normally_nullable
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }
          return null;
        },
      )
    );
  }


  Widget _buildBackButton() {
    return SizedBox(
      width: 150,
      height: 30,
      child: ElevatedButton(
        onPressed: () {
            _submitBack();
          },
          child: const Text('Back'),
      )
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: 150,
      height: 30,
      child: ElevatedButton(
        onPressed: () {
            _submitForm();
          },
          child: const Text('Save & Proceed'),
      )
    );
    
  }

  void _submitBack() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmploymentDetails()));
  }

  void _submitForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const References()));
  }
}