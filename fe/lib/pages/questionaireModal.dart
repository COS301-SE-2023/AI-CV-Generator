import 'package:flutter/material.dart';

showQuestionaireModal(BuildContext context, Widget widget) {
  return showDialog(
      context: context, 
      builder: (BuildContext context) {
        return Dialog(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: widget
          )
        );
      }
    );
}