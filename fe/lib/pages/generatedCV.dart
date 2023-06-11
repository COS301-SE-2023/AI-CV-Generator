import 'package:flutter/material.dart';
import 'details.dart';


class generatedCV extends StatefulWidget {
  const generatedCV({super.key});

  @override
  _generatedCVState createState() => _generatedCVState();
}

class _generatedCVState extends State<generatedCV> {

  Map data = content;
  final TextEditingController _controller = TextEditingController();

  void createCV() {
    String response = '';
    setState(() {
      data.forEach((key, value) {
        response += '$key\n';
        response += '$value\n\n';
      });
    });
    _controller.text = response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [

              Container(
                padding: const EdgeInsets.all(10.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: OutlinedButton(
                    onPressed: () async {
                      setState(() {
                        createCV();
                      });
                    },
                    child: const Text("Generate")
                  )
                ),
              ),
              
              Expanded(
                child: Container(
                  // decoration: BoxDecoration(
                  // border: Border.all(
                  //   color: Colors.grey,
                  //   width: 1.0,
                  // ),
                // ),
                  child: ListView(
                    padding: EdgeInsets.all(16.0),
                    children: [
                      TextFormField(
                        maxLines: null,
                        controller: _controller,
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
          Positioned(
            bottom: 18.0, // Adjust the position of the floating button
            right: 18.0,
            child: FloatingActionButton(
              onPressed: () {
                // Floating button on press logic
              },
              child: Icon(Icons.download),
            ),
          ),
        
        ],
      ),
    );
  }
}