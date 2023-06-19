// ignore_for_file: must_be_immutable

import 'package:ai_cv_generator/pages/skills.dart';
import 'package:ai_cv_generator/pages/strings.dart';
import 'package:flutter/material.dart';

void main () => runApp(const References());

class References extends StatelessWidget {
  const References({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: StringsReferences.appBarTitle,
      home: ReferencesForm(),
    );
  }
}

class ReferencesForm extends StatefulWidget {
  const ReferencesForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ReferencesFormState();
  }
}

class _ReferencesFormState extends State<ReferencesForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController fullName = TextEditingController();
  TextEditingController relationship = TextEditingController();
  TextEditingController contactDetails = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringsReferences.appBarTitle),
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
              StringsReferences.appsubHeadingTitle,
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
            _buildFullNameField(),
            _buildRelationshipField(),
            _buildContactDetailsField(),
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

  Widget _buildFullNameField() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: fullName,
        decoration: const InputDecoration(
          labelText: 'Full Name',
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

  Widget _buildRelationshipField() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: relationship,
        decoration: const InputDecoration(
          labelText: 'Relationship',
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

  Widget _buildContactDetailsField() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: contactDetails,
        decoration: const InputDecoration(
          labelText: 'Contact Details',
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
          child: const Text('Save & Generate'),
      )
    );
    
  }

  void _submitBack() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Skills()));
  }

  void _submitForm() {
    /*Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ReferencesForm()));*/
  }
}