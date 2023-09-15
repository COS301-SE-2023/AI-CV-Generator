import 'package:flutter/material.dart';

class Breadcrumb extends StatelessWidget {
  const Breadcrumb({Key? key, this.title, required this.currentPage, required this.previousPage}) : super(key: key);

  final String? title;
  final String currentPage;
  final String previousPage;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100;
    return Container(
      // height: h*3,
      alignment: Alignment.topLeft,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: const BoxDecoration(),
        child: Row(
          children: [
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/' + previousPage.toLowerCase());
              },
              child: Text(
                previousPage,
                style: const TextStyle(
                  fontSize: 24
                ),
              )
            ),
            Text(
              "/ " + currentPage,
              style: const TextStyle(
                fontSize: 24
              ),
            )
          ],
        )
      );
  }
}