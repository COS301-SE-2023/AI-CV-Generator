import 'package:flutter/material.dart';

class Breadcrumb extends StatelessWidget {
  const Breadcrumb({Key? key, this.title, required this.currentPage, required this.previousPage}) : super(key: key);

  final String? title;
  final String currentPage;
  final String previousPage;

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
        ),
        child: Row(
          children: [
            TextButton(onPressed: () {
              Navigator.pushNamed(context, '/' + previousPage.toLowerCase());
            }, child: Text(previousPage, style: TextStyle(fontSize: 24),)),
            Text("/ " + currentPage, style: TextStyle(fontSize: 24),)
          ],
        )
      );
  }
}