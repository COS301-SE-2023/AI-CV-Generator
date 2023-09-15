import 'package:flutter/material.dart';

forceToLogin(BuildContext context) {
  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  } else {
    Navigator.popAndPushNamed(context, "/");
  }
}