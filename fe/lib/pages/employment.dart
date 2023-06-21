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

  TextEditingController company1 = TextEditingController();
  TextEditingController jobTitle1 = TextEditingController();
  TextEditingController company2 = TextEditingController();
  TextEditingController jobTitle2 = TextEditingController();
  TextEditingController duration1 = TextEditingController();
  TextEditingController duration2 = TextEditingController();
  
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringsEmployment.appBarTitle),
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




  Widget _buildForm() {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _buildCompanyField1(),
            _buildJobTitleField1(),
            _buildDurationField1(),
            _buildSeparator(),
            _buildCompanyField2(),
            _buildJobTitleField2(),
            _buildDurationField2(),
            //_buildAddButton()
            ],
        ));
  }

  Widget _buildSeparator() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,25)),
    );
  }


  Widget _buildCompanyField1() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: company1,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
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
  Widget _buildCompanyField2() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: company2,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
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

  Widget _buildJobTitleField1() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: jobTitle1,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
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
  Widget _buildJobTitleField2() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: jobTitle2,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
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

  Widget _buildDurationField1() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: duration1,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Employment Duration',
          hintText: 'MM/DD/YYYY - MM/DD/YYYY',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.date_range),
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
  Widget _buildDurationField2() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        controller: duration2,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Employment Duration',
          hintText: 'MM/DD/YYYY - MM/DD/YYYY',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.date_range),
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


  Widget _buildAddButton() {
    return ElevatedButton(
        onPressed: () {
            _submitAdd();
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.all(8.0),
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
        builder: (context) => const QualificationsDetails()));
  }

  void _submitForm() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Skills()));
  }
}