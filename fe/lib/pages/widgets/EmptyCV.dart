import 'package:flutter/material.dart';

class   EmptyCVScreen extends StatelessWidget {
  const EmptyCVScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100; 
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.emoji_emotions_outlined,color: Colors.grey,size: w*h*1,),
          SizedBox(height: h*w*0.2),
          Text("Create CV !!!", style: TextStyle(
            color: Colors.grey
          )),
        ],
      ),
    );
  }
}