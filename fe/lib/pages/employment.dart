// ignore_for_file: must_be_immutable

import 'package:ai_cv_generator/pages/strings.dart';
import 'package:flutter/material.dart';

void main () => runApp(EmploymentSection());

class EmploymentForm extends StatefulWidget {
  const EmploymentForm({super.key});

  @override
  EmploymentFormState createState() {
    return EmploymentFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class EmploymentFormState extends State<EmploymentForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form
  final _formKey = GlobalKey<FormState>();
  TextEditingController company = TextEditingController();
  TextEditingController jobTitle = TextEditingController();
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
                  controller: company,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(  
                    icon: Icon(Icons.work_history),
                    labelText: 'Company',
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
                  controller: jobTitle,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(  
                    icon: Icon(Icons.title),  
                    labelText: 'Job Title',
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
                    icon: Icon(Icons.calendar_month),
                    labelText: 'Employment Start Date',
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
                    icon: Icon(Icons.calendar_month),
                    labelText: 'Employment End Date',
                    enabledBorder: OutlineInputBorder(),
                  ), 
                ),
              ),
            ),
          ),


          Padding (
            padding: const EdgeInsets.all(8.0),
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


class EmploymentSection extends StatelessWidget {

  //titleSection widget
  Widget titleSection=const Column (
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: <Widget> [
      Padding (
        padding: EdgeInsets.all(8.0),
          child: Text (
            StringsEmployment.appHeadingTitle,
            style: TextStyle (
              fontSize: 30.0,
          ),
        ),
      ),
      
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

  EmploymentSection({super.key});
  
    //MaterialApp
}
