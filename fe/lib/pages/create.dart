import 'package:ai_cv_generator/pages/education.dart';
import 'package:ai_cv_generator/pages/strings.dart';
import 'package:flutter/material.dart';

void main () => runApp(Create());

class PersonalDetailsForm extends StatefulWidget {
  const PersonalDetailsForm({super.key});

  @override
  PersonalDetailsFormState createState() {
    return PersonalDetailsFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class PersonalDetailsFormState extends State<PersonalDetailsForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget> [
          //form fields
        ],
      ),
    );
  }
}


class Create extends StatelessWidget {

  //titleSection widget
    Widget titleSection=Container(
    child:Column (
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget> [
        Padding (
          padding: const EdgeInsets.all(8.0),
            child: Text (
              StringsPersonal.appHeadingTitle,
              style: const TextStyle (
                fontSize: 30.0,
            ),
          ),
        ),
        
        Padding (
          padding: const EdgeInsets.all(8.0),
            child: Text (
              StringsPersonal.appsubHeadingTitle,
              style: const TextStyle (
                fontSize: 20.0,
              ),
          ),
        ),
        
      ],
    ),
  );

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: StringsPersonal.appBarTitle,
        home: Scaffold (
          appBar: AppBar(
            title: Text(StringsPersonal.appBarTitle),
          ),
          body: ListView(
            children: <Widget>[
              titleSection,
              const PersonalDetailsForm(),
            ],
          ),
        ),
      );
  }//MaterialApp
}
