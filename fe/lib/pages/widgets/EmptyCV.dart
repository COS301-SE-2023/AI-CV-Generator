import 'package:flutter/material.dart';

class   EmptyCVScreen extends StatelessWidget {
  const EmptyCVScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.emoji_emotions_outlined,color: Colors.grey,size: 100,),
          SizedBox(height: 20),
          Text("Create CV !!!", style: TextStyle(
            color: Colors.grey
          )),
        ],
      ),
    );
  }
}