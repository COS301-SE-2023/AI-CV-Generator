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
    this.waitPeriod = 200
  });
  final String filename;
  final double radius;
  final int waitPeriod;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius)
      ),
      child: SizedBox(
        width: 700,
        height: 600,
        child:
        Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: Future.delayed(Duration(milliseconds: waitPeriod)).then((value) {return rootBundle.loadString(filename);}),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Markdown(
                      data: snapshot.data as String,
                      styleSheet: MarkdownStyleSheet(
                        p: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10
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
      )
    );
  }
}