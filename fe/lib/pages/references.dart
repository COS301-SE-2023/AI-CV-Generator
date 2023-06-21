// ignore_for_file: must_be_immutable

import 'package:ai_cv_generator/pages/preview.dart';
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

  TextEditingController fullName1 = TextEditingController();
  TextEditingController relationship1 = TextEditingController();
  TextEditingController contactDetails1 = TextEditingController();
  TextEditingController fullName2 = TextEditingController();
  TextEditingController relationship2 = TextEditingController();
  TextEditingController contactDetails2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringsReferences.appBarTitle),
      ),
      body: ListView(
        children: [
          titleSection,
          Center ( 
            child: Container ( 
            padding: const EdgeInsets.all(25.0),
            child: _buildForm(),
            ),
        ),
        Center (
          child: Container ( 
            padding: const EdgeInsets.all(20.0),
            child: _buildAddButton(),
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget> [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: _buildBackButton(),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: _buildSubmitButton(),
            ),
          ],
        ),
        ],
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
            _buildFullNameField1(),
            _buildRelationshipField1(),
            _buildContactDetailsField1(),
            _buildSeparator(),
            _buildFullNameField2(),
            _buildRelationshipField2(),
            _buildContactDetailsField2(),
          ],
        ));
  }

  Widget _buildSeparator() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,25)),
    );
  }

  Widget _buildFullNameField1() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: fullName1,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
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
  Widget _buildFullNameField2() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: fullName2,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
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

  Widget _buildRelationshipField1() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: relationship1,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
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
  Widget _buildRelationshipField2() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: relationship2,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
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

  Widget _buildContactDetailsField1() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: contactDetails1,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Contact Number',
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
  Widget _buildContactDetailsField2() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: contactDetails2,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Contact Number',
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

  Widget _buildAddButton() {
    return ElevatedButton(
        onPressed: () {
            _submitAdd();
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.all(10.0),
          ),
          child: const Icon(Icons.add),
      );
  }


  Widget _buildBackButton() {
    return SizedBox(
      width: 140,
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
      width: 140,
      height: 30,
      child: ElevatedButton(
        onPressed: () {
            _submitForm();
          },
          child: const Text('Save & Generate'),
      )
    );
    
  }

  void _submitAdd() {
    //
  }

  void _submitBack() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Skills()));
  }

  void _submitForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Preview()));
  }
}