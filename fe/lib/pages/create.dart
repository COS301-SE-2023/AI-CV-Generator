//import 'package:ai_cv_generator/pages/education.dart';
import 'package:ai_cv_generator/pages/strings.dart';
import 'package:flutter/material.dart';

void main () => runApp(Create());



class Create extends StatelessWidget {

  //titleSection widget
    
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
