import 'package:flutter/material.dart';
Color backdrop = Colors.grey.withOpacity(0.1);
const double? profileButtonSize = 32.0;
const secondaryColour = Color(0xFFEA6D79);

ThemeData mainTheme = ThemeData(
  primaryColor: Color(0xFFFDA187),
  appBarTheme: AppBarTheme(color: Color(0xFFFDA187)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(secondaryColour),
    ),
  ),
);

class SectionHeading extends StatefulWidget {
  String text;
  Alignment? alignment = Alignment.topLeft;
  SectionHeading({super.key, required this.text,  this.alignment});

  @override
  SectionHeadingState createState() => SectionHeadingState();
}

class SectionHeadingState extends State<SectionHeading> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.alignment != null? widget.alignment!: Alignment.topLeft,
      child: Container(
        child: Column(
          children: [
            Text(
              widget.text,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
          ],
        )
      )
    );
  }
}

class SectionContainer extends StatefulWidget {
  final child;
  SectionContainer({super.key, required this.child});

  @override
  SectionContainerState createState() => SectionContainerState();
}

class SectionContainerState extends State<SectionContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 48, vertical: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: backdrop
      ),
      child: widget.child,
    );
  }
}

class SectionTextFormField extends StatefulWidget {
  final child;
  SectionTextFormField({super.key, required this.child});

  @override
  SectionTextFormFieldState createState() => SectionTextFormFieldState();
}

class SectionTextFormFieldState extends State<SectionTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.child,
    );
  }
}

class SectionHeadingBar extends StatefulWidget {
  List<Widget>? children = [];
  List<Widget>? actions = [];
  SectionHeadingBar({super.key, required this.children, this.actions});

  @override
  SectionHeadingBarState createState() => SectionHeadingBarState();
}

class SectionHeadingBarState extends State<SectionHeadingBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ...widget.children!
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ...widget.actions!
            ],
          )
        ]
      )
    );
  }
}