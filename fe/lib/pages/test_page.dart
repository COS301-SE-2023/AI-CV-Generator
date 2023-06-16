import 'package:ai_cv_generator/dio/client/shareClient.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({Key? key}) : super(key:key);
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Testing page",
      home: Scaffold(
        body: TestPageState(),
      ),
    );
  }
}

class TestPageState extends StatefulWidget {
  const TestPageState({Key? key}) : super(key: key);
 
  @override
  State<TestPageState> createState() => _TestPageState();
}

class _TestPageState extends State<TestPageState> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center(
        child: Container(
          child: ElevatedButton(
            child: const Text("Test Button"),
            onPressed: () {
              ShareApi.retrieveFile(uuid: "6195626f-998a-4df1-bdfb-12c1a4bb20d3");
            },
          ),
        ),
      ),
    );
  }
}