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

  //MaterialApp
}

