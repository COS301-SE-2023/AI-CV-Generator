import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AI CV Generator"),
        centerTitle: true,
        backgroundColor: Colors.amber[300],
      ),
      body: Center(
        child: Row (
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                padding: const EdgeInsets.all(30.0),
                color: Colors.blue[100],
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/importCV");
                  },
                  child: const Text("ImportCV page"),
                ),
            ),
            Container(
              padding: const EdgeInsets.all(30.0),
                color: Colors.blue[100],
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Route2"),
                ),
            ),
            Container(
              padding: const EdgeInsets.all(30.0),
                color: Colors.blue[100],
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Route3"),
                ),
            )
          ],
        )
      )
    );
  }
}