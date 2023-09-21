
import 'dart:typed_data';

import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:ai_cv_generator/pages/template/TemplateD.dart';
import 'package:flutter/material.dart';

enum TemplateOption {
  templateA,
  templateB,
  templateC,
  templateD,
  templateE
}

class ColorSet {
  Color? colA;
  Color? colB;
  Color? colC;
  Color? colD;
  Color? colE;

  ColorSet({
    this.colA,
    this.colB,
    this.colC,
    this.colD,
    this.colE
  });

  setColorSetTemplateChoice(TemplateOption option) {
    switch (option) {
      case TemplateOption.templateA:
      setColorSetA();
      case TemplateOption.templateB:
      setColorSetB();
      case TemplateOption.templateC:
      setColorSetC();
      case TemplateOption.templateD:
      setColorSetD();
      case TemplateOption.templateE:
      setColorSetE();
    }
  }

  setColorSetA() {
    colA = Colors.blue;
    colB = Colors.green;
  }

  setColorSetB() {

  }

  setColorSetC() {

  }

  setColorSetD() {
    colA = const Color.fromRGBO(56, 92, 100,1);
    colB = const Color.fromRGBO(85, 144, 157,1);
    colC = const Color.fromRGBO(250, 250, 250, 1);
    colD = null;
    colE = null;
  }

  setColorSetE() {

  }

  getAmount() {
    int count = 0;
    if (colA != null) count++;
    if (colB != null) count++;
    if (colC != null) count++;
    if (colD != null) count++;
    if (colE != null) count++;
    return count;
  }
}

Future<Uint8List> templateChoice(CVData data, TemplateOption option, ColorSet colors) async {
  switch(option) {
    case TemplateOption.templateA:
    return TemplateD().templateD(data,colors);
    case TemplateOption.templateB:
    return TemplateD().templateD(data,colors);
    case TemplateOption.templateC:
    return TemplateD().templateD(data,colors);
    case TemplateOption.templateD:
    return TemplateD().templateD(data,colors);
    case TemplateOption.templateE:
    return TemplateD().templateD(data,colors);
  }
}
