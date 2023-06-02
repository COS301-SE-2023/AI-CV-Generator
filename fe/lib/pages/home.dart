
import 'package:ai_cv_generator/pages/generatedCV.dart';
import 'package:ai_cv_generator/pages/createPage.dart';
import 'package:flutter/material.dart';
import 'profile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => {

            },
          ),
        actions: [
          IconButton(
            onPressed: () => {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (c)=>  const Profile())
              )
            }, 
            icon: const Icon(Icons.account_circle)
            )
        ],
      ),
      body: const Center(
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
