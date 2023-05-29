import 'package:ai_cv_generator/pages/generatedCV.dart';
import 'package:ai_cv_generator/pages/createPage.dart';
import 'package:flutter/material.dart';
import 'createPage.dart';
import 'createCV.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 1;
  Map data = {};

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => {

            },
          ),
        actions: [
          IconButton(
            onPressed: () => {

            }, 
            icon: Icon(Icons.account_circle)
            )
        ],
      ),
      body: Center(
        child: Row(
          children: [
            Expanded(child: ImportCV()),
            Expanded(child: generatedCV())
          ],
        ),
      ),
    );
  }
}
