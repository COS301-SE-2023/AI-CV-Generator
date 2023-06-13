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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center (
              child: ConstrainedBox(
                constraints: BoxConstraints.tight(const Size(550,50)),
                child: TextFormField(
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(  
                    icon: Icon(Icons.person),  
                    hintText: 'Enter your name',  
                    labelText: 'Name',
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(  
                    icon: Icon(Icons.person),  
                    hintText: 'Enter your last name',  
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
                  // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(  
                    icon: Icon(Icons.email),  
                    hintText: 'Enter your email',  
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
                // The validator receives the text that the user has entered.
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(  
                    icon: Icon(Icons.phone),  
                    hintText: 'Enter your contact number',  
                    labelText: 'Contact Number',  
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
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }

                  Navigator.push(
                  context,
                    MaterialPageRoute(builder: (context) => const QualificationsForm()),
                  );
                },
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
