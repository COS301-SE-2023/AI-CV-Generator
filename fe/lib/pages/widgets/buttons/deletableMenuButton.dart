import 'package:flutter/material.dart';

class DeletableMenuButton extends StatefulWidget {
  const DeletableMenuButton({
    super.key, 
    required this.text,
    required this.onTap,
    required this.onDeletePressed
  });
  final String text;
  final GestureTapCallback onTap;
  final VoidCallback onDeletePressed;
  
  @override
  State<StatefulWidget> createState() => DeletableMenuButtonState();
  
}

class DeletableMenuButtonState extends State<DeletableMenuButton> {
  Color color = Colors.grey.withOpacity(0.1);
  Color hoverColor = Colors.grey.withOpacity(0.3);
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100;
    return SizedBox(
      width: w*30,
      height: h*10,
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
                height: h*10,
                width: w*30,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: w*30*0.7,
                      padding: const EdgeInsets.only(
                        left: 10
                      ),
                      child: Text(
                        widget.text,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFEA6D79),
                            fontSize: w*1.2
                          ),
                      ),
                    ),
                    SizedBox(
                      width: w*30*0.1,
                    ),
                    SizedBox(
                      width: w*30*0.2,
                      height: h*10,
                      child: IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.grey,
                          size: w*30*0.06,
                        ),
                        onPressed: widget.onDeletePressed,
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