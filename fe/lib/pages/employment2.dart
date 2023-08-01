// ignore_for_file: must_be_immutable
import 'package:ai_cv_generator/pages/widgets/navdrawer.dart';
import 'package:date_field/date_field.dart';
import 'package:ai_cv_generator/pages/qualifications2.dart';
import 'package:ai_cv_generator/pages/skills2.dart';
import 'package:ai_cv_generator/pages/util/strings.dart';
import 'package:flutter/material.dart';

void main () => runApp(const EmploymentDetails());

class EmploymentDetails extends StatelessWidget {
  const EmploymentDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: EmploymentDetailsForm(),
    );
  }

  bool addQualification(String s, String t, String u, String v) 
  {
    return true;
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
  final TextEditingController _timeController = TextEditingController();
  
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
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text(StringsEmployment.appHeadingTitle),
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
                          builder: (context) => const QualificationsDetailsForm()));
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
                          builder: (context) => const Skills()
                          )
                        );
                    },
                    child: const Text('Save & Proceed'),
                )
              ),
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
            _buildCompanyField(),
            _buildJobTitleField(),
            _buildStartField(),
            _buildEndField(),
            //_buildAddButton()
            ],
        ));
  }

  Widget _buildCompanyField() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        key: const Key("Company input"),
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
  
  Widget _buildJobTitleField() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: TextFormField(
        key: const Key("Job Title input"),
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
  
  Widget _buildStartField() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: DateTimeFormField(
        //controller: _timeController1,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Employment Start Date',
          enabledBorder: OutlineInputBorder(),
          icon: Icon(Icons.date_range),
        ),
        mode: DateTimeFieldPickerMode.date,
      )
    );
  }
  Widget _buildEndField() {
    return Container (
      padding: const EdgeInsets.all(8.0),
      constraints: BoxConstraints.tight(const Size(550,65)),
      child: DateTimeFormField(
        //controller: _timeController2,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.all(5.0),
          labelText: 'Employment End Date',
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