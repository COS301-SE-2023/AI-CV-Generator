import 'package:flutter_test/flutter_test.dart';
import 'package:ai_cv_generator/pages/create_CV.dart';

void main() {

  test('Test populate fields', () {
      TextSpaceState field = TextSpaceState();

     String result = field.populateField();

    expect(result, "0000");
  });
}