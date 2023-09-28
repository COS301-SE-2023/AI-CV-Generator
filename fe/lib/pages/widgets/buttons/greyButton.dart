import 'package:flutter/material.dart';

class GreyButton extends StatefulWidget {
  const GreyButton({
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
  State<StatefulWidget> createState() => GreyButtonState();
  
}

class GreyButtonState extends State<GreyButton> {
  Color color = Colors.grey.withOpacity(0.1);
  Color hoverColor = Colors.grey.withOpacity(0.3);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: InkWell(
        hoverColor: Colors.transparent,
        borderRadius: BorderRadius.circular(36.0),
        onTap: widget.onTap,
        onHover: (value) {
          Color temp = color;
          color = hoverColor;
          hoverColor = temp;
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
                  color: color,
                  borderRadius: BorderRadius.circular(36.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.text,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFFEA6D79),
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