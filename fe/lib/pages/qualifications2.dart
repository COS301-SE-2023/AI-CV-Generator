// ignore_for_file: must_be_immutable

import 'package:ai_cv_generator/pages/employment2.dart';
import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:ai_cv_generator/pages/personaldetails2.dart';
import 'package:ai_cv_generator/pages/util/strings.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';

void main () => runApp(const QualificationsDetails());

class QualificationsDetails extends StatelessWidget {
  const QualificationsDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringsQualifications.appBarTitle)
      ),
      body:const QualificationsDetailsForm(),
    );
  }

  bool addQualification(String s, String t, String u) 
  {
    return true;
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
  TextEditingController qualification1 = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text(StringsQualifications.appHeadingTitle),
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
              child: SizedBox(
                width: 140,
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                      Navigator.pushReplacement(
                        context,
                          MaterialPageRoute(
                          builder: (context) =>  const PersonalDetails())
                        );
                    },
                    child: const Text('Back'),
                )
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                width: 140,
                height: 30,
                child: ElevatedButton(
                  onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EmploymentDetails())
                        );
                    },
                    child: const Text('Save & Proceed'),
                )
              )
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
            _buildInstitutionField(),
            _buildQualificationField(),
            _buildGraduationField(),
          ],
        ));
  }

  Widget _buildInstitutionField() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        key: const Key("Institution input"),
        controller: institution1,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Institution',
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

  Widget _buildQualificationField() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        key: const Key("Qualification input"),
        controller: qualification1,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Qualification',
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
  

  Widget _buildGraduationField() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: DateTimeFormField(
        key: const Key("Graduation input"),
        //controller: _timeController1,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Date Obtained',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.date_range),
        ),
        mode: DateTimeFieldPickerMode.date,
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