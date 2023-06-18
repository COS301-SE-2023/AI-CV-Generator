// ignore_for_file: must_be_immutable

import 'package:ai_cv_generator/pages/strings.dart';
import 'package:flutter/material.dart';

void main () => runApp(CreateEducation());

class EducationDetailsForm extends StatefulWidget {
  const EducationDetailsForm({super.key});

  @override
  EducationDetailsFormState createState() {
    return EducationDetailsFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class EducationDetailsFormState extends State<EducationDetailsForm> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController institution = TextEditingController();
  TextEditingController qualification = TextEditingController();
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();

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
                  controller: institution,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(  
                    icon: Icon(Icons.person),  
                    //hintText: 'Enter your name',  
                    labelText: 'Institution',
                    enabledBorder: OutlineInputBorder(),
                  ), 
                ),
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center (
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(const Size(550,50)),
                child: TextFormField(
                  // The validator receives the text that the user has entered.
                  controller: qualification,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(  
                    icon: Icon(Icons.person),  
                    //hintText: 'Enter your last name',  
                    labelText: 'Qualification', 
                    enabledBorder: OutlineInputBorder(),
                  ), 
                ),
              ),
            ),
          ),


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center (
              child: ConstrainedBox(
              constraints: BoxConstraints.tight(const Size(550,50)),
                child: TextFormField(
                  controller: startDate,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(  
                    icon: Icon(Icons.email),  
                    //hintText: 'Enter your email',  
                    labelText: 'Start Date',
                    enabledBorder: OutlineInputBorder(),  
                  ), 
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center (
              child: ConstrainedBox(
              constraints: BoxConstraints.tight(const Size(550,50)),
                child: TextFormField(
                  controller: endDate,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(  
                    icon: Icon(Icons.email),  
                    //hintText: 'Enter your email',  
                    labelText: 'End Date',
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

  class CreateEducation extends StatelessWidget {

  //titleSection widget
    Widget titleSection=const Column (
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget> [
        Padding (
          padding: EdgeInsets.all(8.0),
            child: Text (
              StringsQualifications.appHeadingTitle,
              style: TextStyle (
                fontSize: 30.0,
            ),
          ),
        ),
        
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

  CreateEducation({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: StringsQualifications.appBarTitle,
        home: Scaffold (
          appBar: AppBar(
            title: const Text(StringsQualifications.appBarTitle),
          ),
          body: ListView(
            children: <Widget>[
              titleSection,
              const EducationDetailsForm(),
            ],
          ),
        ),
      );
  }//MaterialApp
}

