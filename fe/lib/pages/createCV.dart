import 'package:flutter/material.dart';

// Left side is imported cv data that can be edited
// Right side is generated cv data that can also be edited
//side by side for comparison
//must include buttons upload cv and generate cv
//upload cv button will populate text area on left
//generate cv button will populate text area on right
class CreateCV extends StatelessWidget {
  const CreateCV({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      textDirection: TextDirection.ltr,
      children: [
        Expanded(child: TextSpace()),
        Expanded(child: TextSpace()),
      ],
    );
  }
}

class TextSpace extends StatefulWidget {
  const TextSpace({super.key});
  @override
  State<TextSpace> createState() => TextSpaceState();
}

class TextSpaceState extends State<TextSpace> {
  var text = '';

  @override
  Widget build(BuildContext context) {
    return const TextField(
      maxLines: 99999,
    );
  }
}