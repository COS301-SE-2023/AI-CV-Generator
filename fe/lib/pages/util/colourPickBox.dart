
import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class ColourBox extends StatelessWidget {
  const ColourBox({super.key, required this.color, required this.h,required this.w, required this.onTap});

  final Color color;
  final double h;
  final double w;
  final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color
        ),
        width: w*5,
        height: h*5,
      )
    );
  }
}

Future<Color> pickColour(BuildContext context, Color colour) async {
      Size screenSize = MediaQuery.of(context).size;
      double w = screenSize.width/100;
      double h = screenSize.height/100; 
      await showDialog(
        context: context, 
        builder: (context) => Dialog(
          backgroundColor: Colors.white,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(w*1, h*1, w*1, h*1),
              width: 50*w,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    ColorPicker(
                      pickerColor: colour, 
                      onColorChanged: (color) => colour = color
                    ),
                    SizedBox(height: h*2,),
                    CustomizableButton(
                      text: "Select", 
                      width: w*10, 
                      height: h*5, 
                      onTap: () {
                        Navigator.of(context).pop();
                      }, 
                      fontSize: w*h*0.1
                    ),
                ],
              ),
            ),
          )
        )
      );

      return colour;
    }