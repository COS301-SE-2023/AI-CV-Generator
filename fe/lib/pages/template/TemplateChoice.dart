
import 'dart:typed_data';

import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:ai_cv_generator/pages/template/templateBRedo.dart';
import 'package:ai_cv_generator/pages/template/templateCRedo.dart';
import 'package:ai_cv_generator/pages/template/templateDRedo.dart';
import 'package:ai_cv_generator/pages/template/templateARedo.dart';
import 'package:ai_cv_generator/pages/template/templateERedo.dart';
import 'package:ai_cv_generator/pages/template/templateFRework.dart';
import 'package:ai_cv_generator/pages/template/templateGRework.dart';
import 'package:flutter/material.dart';

// All logic for template choices are here

enum TemplateOption {
  templateA,
  templateB,
  templateC,
  templateD,
  templateE,
  templateF,
  templateG
}

class ColorSet {
  Color? colA;
  Color? colB;
  Color? colC;
  Color? colD;
  Color? colE;
  Color? colF;
  Color? colG;


  ColorSet({
    this.colA,
    this.colB,
    this.colC,
    this.colD,
    this.colE,
    this.colF,
    this.colG
  });

  setColorSetTemplateChoice(TemplateOption option) {
    switch (option) {
      case TemplateOption.templateA:
      setColorSetA();
      break;
      case TemplateOption.templateB:
      setColorSetB();
      break;
      case TemplateOption.templateC:
      setColorSetC();
      break;
      case TemplateOption.templateD:
      setColorSetD();
      break;
      case TemplateOption.templateE:
      setColorSetE();
      break;
      case TemplateOption.templateF:
      setColorSetF();
      break;
      case TemplateOption.templateG:
      setColorSetG();
      break;
    }
  }

  setColorSetA() {
    colA = Colors.blue.shade900;
    colB = Colors.white;
    colC = Colors.white;
    colD = Colors.black;
    colE = Colors.yellow;
    colF = null;
    colG = null;
  }

  setColorSetB() {
    colA = Colors.blue.shade900;
    colB = Colors.white;
    colC = Colors.white;
    colD = Colors.white;
    colE = Colors.black;
    colF = Colors.black;
    colG = Colors.grey;
  }

  setColorSetC() {
    colA = const Color(0xFFEA6D79);
    colB = Colors.white;
    colC = const Color(0xFFEA6D79);
    colD = Colors.black;
    colE = null;
    colE = null;
    colF = null;
    colG = null;
  }

  setColorSetD() {
    colA = const Color.fromRGBO(56, 92, 100,1);
    colB = const Color.fromRGBO(85, 144, 157,1);
    colC = const Color.fromRGBO(250, 250, 250, 1);
    colD = null;
    colE = null;
    colE = null;
    colF = null;
    colG = null;
  }

  setColorSetE() {
    colA = Colors.green.shade900;
    colB = Colors.white;
    colC = Colors.black;
    colD = null;
    colE = null;
    colE = null;
    colF = null;
    colG = null;
  }

  setColorSetF() {
    colA = Colors.blue.shade900;
    colB = Colors.white;
    colC = Colors.white;
    colD = Colors.blue.shade900;
    colE = Colors.blue.shade900;
    colF = Colors.black;
    colG = Colors.grey;
  }

  setColorSetG() {
    colA = Colors.blue.shade900;
    colB = Colors.white;
    colC = Colors.white;
    colD = Colors.black;
    colE = Colors.yellow;
    colF = null;
    colG = null;
  }


  getAmount() {
    int count = 0;
    if (colA != null) count++;
    if (colB != null) count++;
    if (colC != null) count++;
    if (colD != null) count++;
    if (colE != null) count++;
    if (colF != null) count++;
    if (colG != null) count++;
    return count;
  }
}

Future<Uint8List> templateChoice(CVData data, TemplateOption option, ColorSet colors) async {
  switch(option) {
    case TemplateOption.templateA:
    return TemplateA().templateA(data,colors);
    case TemplateOption.templateB:
    return TemplateB().templateB(data,colors);
    case TemplateOption.templateC:
    return TemplateC().templateC(data,colors);
    case TemplateOption.templateD:
    return TemplateD().templateD(data,colors);
    case TemplateOption.templateE:
    return TemplateE().templateE(data,colors);
    case TemplateOption.templateF:
    return TemplateF().templateF(data, colors);
    case TemplateOption.templateG:
    return TemplateG().templateG(data, colors);
  }
}
