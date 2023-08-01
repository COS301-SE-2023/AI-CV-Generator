import 'package:flutter/material.dart';

showQuestionaireModal(BuildContext context, Widget widget) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: widget
          )
        );
      }
    );
}