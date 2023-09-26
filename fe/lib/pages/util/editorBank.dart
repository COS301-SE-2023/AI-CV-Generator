import 'package:ai_cv_generator/models/aimodels/CVData.dart';
import 'package:ai_cv_generator/pages/template/TemplateChoice.dart';

class EditorModel {
  final CVData data;
  final TemplateOption templateOption;
  final ColorSet colors;

  EditorModel({
    required this.data,
    required this.templateOption,
    required this.colors
  });
}

class EditorBank {
  List<EditorModel> past = [];
  int currentSize = 0;
  final int max;
  
  add(EditorModel model) {
    if (currentSize == max) {
      past.removeAt(0);
      currentSize--;
    }
    past.add(model);
    currentSize++;
  }

  EditorModel undo() {
    if (currentSize == 0) {
      return past.first;
    }
    return past.removeAt(currentSize--);
  }
  
  EditorBank({
    required this.past,
    required this.max
  });
}