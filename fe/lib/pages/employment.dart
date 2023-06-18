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

  //MaterialApp
}
