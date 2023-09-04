import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatefulWidget {
  TermsAndConditions({super.key, required this.accepted});
  bool accepted;
  
  @override
  State<StatefulWidget> createState() => TermsAndConditionsState();
}

class TermsAndConditionsState extends State<TermsAndConditions> {
  bool agreed = false;
  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.grey;
      }
      return Color(0xFFEA6D79);
    }
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Center (
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RichText(
              text: TextSpan(
                text: "Yes, I agree to the ",
                style: const TextStyle(color: Colors.grey),
                children: [
                  TextSpan(
                    text: "Terms of Service ",
                    style: const TextStyle(fontWeight: FontWeight.bold,),
                    recognizer: TapGestureRecognizer()..onTap = () {

                    }
                  ),
                  const TextSpan(
                    text: "and "
                  ),
                  TextSpan(
                    text: "Privacy Policy.",
                    style: const TextStyle(fontWeight: FontWeight.bold,),
                    recognizer: TapGestureRecognizer()..onTap = () {

                    }
                  )
                ]
              )
            ),
            const SizedBox(width: 20,),
            Checkbox(
              checkColor: Colors.white,
              fillColor: MaterialStateProperty.resolveWith(getColor),
              value: agreed,
              onChanged: (bool? value) {
                setState(() {
                  agreed = value!;
                  widget.accepted = agreed;
                });
              }
            )
          ],
        )
      )
    );
  }
}