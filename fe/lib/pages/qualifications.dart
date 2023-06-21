// ignore_for_file: must_be_immutable

import 'package:ai_cv_generator/pages/employment.dart';
import 'package:ai_cv_generator/pages/personaldetails.dart';
import 'package:ai_cv_generator/pages/strings.dart';
import 'package:flutter/material.dart';

void main () => runApp(const QualificationsDetails());

class QualificationsDetails extends StatelessWidget {
  const QualificationsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: StringsQualifications.appBarTitle,
      home: QualificationsDetailsForm(),
    );
  }
}

class QualificationsDetailsForm extends StatefulWidget {
  const QualificationsDetailsForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QualificationsDetailsFormState();
  }
}

class _QualificationsDetailsFormState extends State<QualificationsDetailsForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController institution1 = TextEditingController();
  TextEditingController institution2 = TextEditingController();
  TextEditingController qualification1 = TextEditingController();
  TextEditingController qualification2 = TextEditingController();
  TextEditingController gradDate1 = TextEditingController();
  TextEditingController gradDate2 = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringsQualifications.appBarTitle),
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
              StringsQualifications.appsubHeadingTitle,
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
            _buildInstitutionField1(),
            _buildQualificationField1(),
            _buildGraduationField1(),
            _buildSeparator(),
            _buildInstitution2Field(),
            _buildQualification2Field(),
            _buildGraduationField2(),
            //_buildStartDField(),
            //_buildEndDField(),
          ],
        ));
  }

  Widget _buildSeparator() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,25)),
    );
  }


  Widget _buildInstitutionField1() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: institution1,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Institution 1',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.school),
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
  Widget _buildInstitution2Field() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: institution2,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Institution 2',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.school),
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

  Widget _buildQualificationField1() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: qualification1,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Qualification 1',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.article),
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
  Widget _buildQualification2Field() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: qualification2,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Qualification 2',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.article),
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
  

  Widget _buildGraduationField1() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: gradDate1,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Date Obtained',
          hintText: 'DD/MM/YYYY',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.date_range),
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
  Widget _buildGraduationField2() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: gradDate2,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Date Obtained',
          hintText: 'DD/MM/YYYY',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.date_range),
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
          child: const Text('Save & Proceed'),
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
        builder: (context) => const PersonalDetailsForm()));
  }

  void _submitForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const EmploymentDetails()));
  }
}