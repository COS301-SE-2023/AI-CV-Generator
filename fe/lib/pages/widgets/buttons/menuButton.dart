import 'package:flutter/material.dart';

class MenuButton extends StatefulWidget {
  const MenuButton({
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
  State<StatefulWidget> createState() => MenuButtonState();
  
}

class MenuButtonState extends State<MenuButton> {
  Color color = Colors.grey.withOpacity(0.1);
  Color hoverColor = Colors.grey.withOpacity(0.3);
  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: InkWell(
        hoverColor: Colors.transparent,
        onHover: (value) {
          Color temp = color;
          color = hoverColor;
          hoverColor = temp;
          setState(() {
            value = ! value;
          });
        },
        onTap: widget.onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: widget.height,
                width: widget.width,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        left: 10
                      ),
                      child: Text(
                        widget.text,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFEA6D79),
                            fontSize: widget.fontSize
                          ),
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