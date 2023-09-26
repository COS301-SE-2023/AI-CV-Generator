import 'package:flutter/material.dart';

class CustomizableButton extends StatefulWidget {
  const CustomizableButton({
    super.key, 
    required this.text, 
    required this.width, 
    required this.height,
    required this.onTap,
    required this.fontSize
  });
  final String text;
  final double width;
  final double height;
  final GestureTapCallback onTap;
  final double fontSize;
  
  @override
  State<StatefulWidget> createState() => CustomizableButtonState();
  
}

class CustomizableButtonState extends State<CustomizableButton> {
  Alignment begin = Alignment.topLeft;
  Alignment end = Alignment.bottomRight;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: InkWell(
        hoverColor: Colors.transparent,
        borderRadius: BorderRadius.circular(16.0),
        onTap: widget.onTap,
        onHover: (value) {
          Alignment temp = begin;
          begin = end;
          end = temp;
          setState(() {
            value = ! value;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: widget.height,
                width: widget.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: begin,
                      end: end,
                      colors: const [
                        Color(0xFFFDA187),
                        Color(0xFFEA6D79),
                      ]
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.text,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontSize: widget.fontSize,
                        overflow: TextOverflow.fade
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}