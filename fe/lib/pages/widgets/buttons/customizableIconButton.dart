import 'package:flutter/material.dart';

class CustomizableIconButton extends StatefulWidget {
  const CustomizableIconButton({
    super.key, 
    required this.icon, 
    required this.width, 
    required this.height,
    required this.onTap,
    required this.iconSize
  });
  final IconData icon;
  final double width;
  final double height;
  final GestureTapCallback onTap;
  final double iconSize;
  
  @override
  State<StatefulWidget> createState() => CustomizableIconButtonState();
  
}

class CustomizableIconButtonState extends State<CustomizableIconButton> {
  Alignment begin = Alignment.topLeft;
  Alignment end = Alignment.bottomRight;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: InkWell(
        borderRadius: BorderRadius.circular(50),
        hoverColor: Colors.transparent,
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
                      ]),
                  shape: BoxShape.circle
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      widget.icon,
                      size: widget.iconSize,
                      color: Colors.white,
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