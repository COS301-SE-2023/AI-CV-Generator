// internal
import 'package:ai_cv_generator/pages/widgets/loadingscreens/loadingScreen.dart';

// external
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class HelpDescription extends StatelessWidget {
  const HelpDescription({
    super.key,
    required this.filename,
    this.radius = 10,
    this.waitPeriod = 200,
    required this.height
  });
  final String filename;
  final double radius;
  final int waitPeriod;
  final double height;
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16)
      ),
      width: 60*w,
      child: Column(
        children: [
          SizedBox(
            width: 60*w,
            height: height,
            child: FutureBuilder(
              future: Future.delayed(Duration(milliseconds: waitPeriod)).then((value) {return rootBundle.loadString(filename);}),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Markdown(
                    data: snapshot.data as String,
                    styleSheet: MarkdownStyleSheet(
                      p: const TextStyle(
                        color: Colors.grey,
                        fontSize: 13
                      ),
                      h1: const TextStyle(
                        color: Colors.grey,
                        fontSize: 30,
                        fontWeight: FontWeight.bold
                      ),
                      h2: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                      h3: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15
                      ),
                      blockSpacing: 10
                    ),
                  );
                }
                return const LoadingScreen();
              }
            )
          )
        ],
      ),
    );
  }
}