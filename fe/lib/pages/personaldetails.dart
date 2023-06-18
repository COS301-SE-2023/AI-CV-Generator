// ignore_for_file: must_be_immutable

import 'package:ai_cv_generator/pages/qualifications.dart';
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
  TextEditingController name = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController cell = TextEditingController();
  TextEditingController address= TextEditingController();

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
                  controller: name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(  
                    icon: Icon(Icons.person),  
                    labelText: 'First Name',
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
                  controller: lname,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(  
                    icon: Icon(Icons.person),  
                    labelText: 'Last Name', 
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
                  controller: email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(  
                    icon: Icon(Icons.email),
                    labelText: 'Email',
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
                  controller: cell,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(  
                    icon: Icon(Icons.phone),
                    labelText: 'Contact Number',  
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
                  controller: address,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  
                  decoration: const InputDecoration(  
                    icon: Icon(Icons.home),
                    labelText: 'Address',  
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


class Create extends StatelessWidget {

  //titleSection widget
    Widget titleSection=const Column (
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget> [
        Padding (
          padding: EdgeInsets.all(8.0),
            child: Text (
              StringsPersonal.appHeadingTitle,
              style: TextStyle (
                fontSize: 30.0,
            ),
          ),
        ),
        
        Padding (
          padding: EdgeInsets.all(8.0),
            child: Text (
              StringsPersonal.appsubHeadingTitle,
              style: TextStyle (
                fontSize: 20.0,
              ),
          ),
        ),
        
      ],
    );

  Create({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: StringsPersonal.appBarTitle,
        home: Scaffold (
          appBar: AppBar(
            title: const Text(StringsPersonal.appBarTitle),
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
