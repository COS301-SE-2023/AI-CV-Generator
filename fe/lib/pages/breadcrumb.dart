import 'package:flutter/material.dart';

class Breadcrumb extends StatelessWidget {
  Breadcrumb({Key? key, this.title, required this.currentPage, required this.previousPage}) : super(key: key);

  final String? title;
  final String currentPage;
  final String previousPage;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 48.0,
      left: 148.0,
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: RichText(
          text: TextSpan(
            text: previousPage + " / ",
            style: TextStyle(
              fontSize: 32,
            ),
            children: <TextSpan>[
              TextSpan(
                text: currentPage,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold
                ),
              )
            ]
          ),
        )
      ),
    );
  }
}