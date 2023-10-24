import 'package:ai_cv_generator/pages/widgets/loadingscreens/AILoadingScreen.dart';
import 'package:ai_cv_generator/pages/widgets/loadingscreens/ErrorScreen.dart';
import 'package:ai_cv_generator/pages/widgets/loadingscreens/extractionLoadingScreen.dart';
import 'package:flutter/material.dart';

enum ScreenStatus {loading, error, empty,extarction}
class   EmptyCVScreen extends StatelessWidget {
  const EmptyCVScreen({super.key,required this.status});
  final ScreenStatus status;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100; 
    switch (status) {
      case ScreenStatus.empty:
        return Center(
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
        );
      case ScreenStatus.loading:
        return const AILoadingScreen();
      case ScreenStatus.extarction:
        return const ExtractionLoadingScreen();
      case ScreenStatus.error:
        return const ErrorScreen(errormsg: "Rate Limit Exceeded");

    }
  }
}