// ignore_for_file: must_be_immutable

import 'package:ai_cv_generator/pages/qualifications.dart';
import 'package:ai_cv_generator/pages/skills.dart';
import 'package:ai_cv_generator/pages/strings.dart';
import 'package:flutter/material.dart';

void main () => runApp(const EmploymentDetails());

class EmploymentDetails extends StatelessWidget {
  const EmploymentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: StringsEmployment.appBarTitle,
      home: EmploymentDetailsForm(),
    );
  }
}

class EmploymentDetailsForm extends StatefulWidget {
  const EmploymentDetailsForm({super.key});

  @override
  State<StatefulWidget> createState() {
    return _EmploymentDetailsFormState();
  }
}

class _EmploymentDetailsFormState extends State<EmploymentDetailsForm> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController company = TextEditingController();
  TextEditingController jobTitle = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringsEmployment.appBarTitle),
      ),
      body: Center ( 
        child: SizedBox(
            width: 650,
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 3,
              child: _buildForm(),
            ),
          ),
        ),
      ),
    );
  }

  Widget titleSection=const Column (
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget> [
        Padding (
          padding: EdgeInsets.all(8.0),
            child: Text (
              StringsEmployment.appsubHeadingTitle,
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
            _buildCompanyField(),
            _buildJobTitleField(),
            _buildStartDField(),
            _buildEndDField(),
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

  Widget _buildCompanyField() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: company,
        decoration: const InputDecoration(
          labelText: 'Company',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.work),
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

  Widget _buildJobTitleField() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: jobTitle,
        decoration: const InputDecoration(
          labelText: 'Job Title',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.person),
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

  Widget _buildStartDField() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: startDate,
        decoration: const InputDecoration(
          labelText: 'Start Date',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.calendar_month),
        ),
        // ignore: body_might_complete_normally_nullable
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a date';
          }
          return null;
        },
      )
    );
  }

Widget _buildEndDField() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: endDate,
        decoration: const InputDecoration(
          labelText: 'End Date',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.calendar_month),
        ),
        // ignore: body_might_complete_normally_nullable
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a date';
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
        builder: (context) => const QualificationsDetails()));
  }

  void _submitForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Skills()));
  }
}