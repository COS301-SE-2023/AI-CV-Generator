import 'package:ai_cv_generator/pages/qualifications2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testWidgets("Add institution", (WidgetTester tester) async {
    final addInstitutionField = find.byKey(const ValueKey("Institution input"));

    await tester.pumpWidget(const MaterialApp(home: QualificationsDetailsForm()));
    await tester.enterText(addInstitutionField, "University of Pretoria");
    await tester.pump();

    expect(find.text("University of Pretoria"), findsOneWidget);
});

testWidgets("Add qualification", (WidgetTester tester) async {
    final addQualificationField = find.byKey(const ValueKey("Qualification input"));

    await tester.pumpWidget(const MaterialApp(home: QualificationsDetailsForm()));
    await tester.enterText(addQualificationField, "University of Pretoria");
    await tester.pump();

    expect(find.text("University of Pretoria"), findsOneWidget);
});

/*testWidgets("Add graduation", (WidgetTester tester) async {
    final addGraduationField = find.byKey(const ValueKey("Graduation input"));

    await tester.pumpWidget(const MaterialApp(home: QualificationsDetails()));
    await tester.enterText(addGraduationField, "15/04/2024");
    await tester.pump();

    expect(find.text("15/04/2024"), findsOneWidget);
});*/
}