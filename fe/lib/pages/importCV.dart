import 'package:flutter/material.dart';

class ImportCV extends StatefulWidget {
  @override
  _ImportCVState createState() => _ImportCVState();
}

class _ImportCVState extends State<ImportCV> {

  Map data = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              child: OutlinedButton(
                onPressed: () {}, 
                child: const Text("Upload")
              )
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: OutlinedButton(
                onPressed: () {
                }, 
                child: const Text("Create Manually")
              ) 
            )
          ],
        )
      )
    );
  }
}