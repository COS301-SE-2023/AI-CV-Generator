import 'package:ai_cv_generator/pages/widgets/policy.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
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
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const Policy(filename: "assets/markdown/Terms_of_use.md");
                        }
                      );
                    }
                  ),
                  const TextSpan(
                    text: "and "
                  ),
                  TextSpan(
                    text: "Privacy Policy.",
                    style: const TextStyle(fontWeight: FontWeight.bold,),
                    recognizer: TapGestureRecognizer()..onTap = () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const Policy(filename: "assets/markdown/Privacy_policy.md");
                        }
                      );
                    }
                  )
                ]
              )
            ),
            const SizedBox(width: 20,),
            Checkbox(
              checkColor: Colors.white,
              activeColor: const Color(0xFFEA6D79),
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