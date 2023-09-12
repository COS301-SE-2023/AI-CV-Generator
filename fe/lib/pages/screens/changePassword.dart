import 'package:ai_cv_generator/pages/screens/underContruction.dart';
import 'package:flutter/cupertino.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key, this.code});
  final String? code;

  @override
  State<StatefulWidget> createState() => ChangePasswordState();
}

class ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    return const UnderContruction();
  }
}