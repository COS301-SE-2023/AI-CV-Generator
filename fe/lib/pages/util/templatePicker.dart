
import 'package:ai_cv_generator/pages/template/TemplateChoice.dart';
import 'package:ai_cv_generator/pages/widgets/buttons/customizableButton.dart';
import 'package:flutter/material.dart';


// ignore: must_be_immutable
class TemplatePicker extends StatefulWidget {
  TemplatePicker({super.key, required this.option, required this.colors});
  TemplateOption option;
  ColorSet colors;
  @override
  State<StatefulWidget> createState() => TemplatePickerState();

}

class TemplatePickerState extends State<TemplatePicker> {
  late TemplateOption option;
  late ColorSet colors;
  @override
  void initState() {
    option = widget.option;
    colors = widget.colors;
    super.initState();
  }

  save() {
    widget.option = option;
    widget.colors = colors;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // Window Resizing
    Size screenSize = MediaQuery.of(context).size;
    double w = screenSize.width/100;
    double h = screenSize.height/100; 
    Widget templateChoices(TemplateOption pick, String assetPath) {
      Color isPicked = Colors.transparent;
      if (option == pick) isPicked = Colors.blue;
      return Container(
        width: 200,
        padding: EdgeInsets.only(
          bottom: h*0.2
        ),
        decoration: BoxDecoration(
          border: Border.all(
            color: isPicked,
            width: 3
          )
        ),
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              colors.setColorSetTemplateChoice(pick);
              setState(() {
                option = pick;
              });
            },
            child: FittedBox(
              child: Image.asset(
                assetPath,
                width: MediaQuery.of(context).size.width * 1.25,
                fit: BoxFit.cover,
              ),
            ),
          )
        )
      );
    }

    return Container(
      alignment: Alignment.center,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          border: Border.all(
            color: Colors.grey.shade300
          ),
          color: Colors.grey.shade100
        ),
        width: 800,
        height: 425,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Scaffold(
            body: Column(
              children: [
                SizedBox(height: 2*h,),
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    "TEMPLATES",
                    style: TextStyle(
                      fontSize: 3.2*h,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 2*h,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:[
                        templateChoices(TemplateOption.templateA, "assets/images/templateARework.png"),
                        templateChoices(TemplateOption.templateB, "assets/images/TemplateBAsset.png"),
                        templateChoices(TemplateOption.templateC, "assets/images/TemplateCAsset.jpg")
                      ],
                    )
                  ),
                ),
                SizedBox(height: 2*h,),
                CustomizableButton(
                  text: 'Save', 
                  width: 7*w, 
                  height: 28, 
                  onTap: () {
                    save();
                  }, 
                  fontSize: 0.7*w
                )
              ],
            ),
          ),
        )
      )
    );
  }
}