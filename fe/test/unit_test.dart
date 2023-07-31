import 'package:ai_cv_generator/pages/employment2.dart';
import 'package:ai_cv_generator/pages/qualifications2.dart';
import 'package:ai_cv_generator/pages/skills2.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ai_cv_generator/pages/personaldetails2.dart';

void main() {

  group('Add personal details to CV', () {
    test('Add details', () {
      PersonalDetails details = const PersonalDetails();
      bool result = details.addDetails("Jane", "Doe", "jd@gmail.com", 0123456789, "12 Anywhere Street, Somewhere");
      expect(result, true);
    });
  });

  group('Add qualification to CV', () {
    test('Add qualification 1', () {
      QualificationsDetails qualification1 = const QualificationsDetails();
      bool result = qualification1.addQualification("University of Pretoria", "BSc Computer Science", "04/04/2024");
      expect(result, true);
    });
  });

  group('Add employment history to CV', () {
    test('Add employment 1', () {
      EmploymentDetails employment1 = const EmploymentDetails();
      bool result = employment1.addQualification("Dynamic Visual Technologies", "Junior Software Engineer", "04/04/2024", "Current");
      expect(result, true);
    });
  });

  group('Add skills to CV', () {
      test('Add skill1', () {
      Skills skillForm = const Skills();
      String skill1 = "Web Development";

      bool result = skillForm.submitAdd(skill1);

      expect(result, true);
    });

    test('Add skill2', () {
      Skills skillForm = const Skills();
      String skill2 = "NOSQL Databases";

      bool result = skillForm.submitAdd(skill2);

      expect(result, true);
    });

    test('Add skill3', () {
      Skills skillForm = const Skills();
      String skill3 = "Cloud Development";

      bool result = skillForm.submitAdd(skill3);

      expect(result, true);
    });
  });
}