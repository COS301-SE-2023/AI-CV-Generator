import 'package:ai_cv_generator/pages/widgets/loadingscreens/AILoadingScreen.dart';
import 'package:flutter/material.dart';

class   EmptyCVScreen extends StatelessWidget {
  const EmptyCVScreen({super.key,required this.loading});
  final bool loading;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100; 
    return 
    !loading?
    Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.emoji_emotions_outlined,color: Colors.grey,size: w*h*1,),
          SizedBox(height: h*w*0.2),
          const Text("Create CV !!!", style: TextStyle(
            color: Colors.grey
          )),
        ],
      ),
    ) :
    const AILoadingScreen();
  }
}