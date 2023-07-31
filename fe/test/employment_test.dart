import 'package:ai_cv_generator/pages/employment2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testWidgets("Add company", (WidgetTester tester) async {
    final addCompanyField = find.byKey(const ValueKey("Company input"));

    await tester.pumpWidget(const MaterialApp(home: EmploymentDetailsForm()));
    await tester.enterText(addCompanyField, "DVT");
    await tester.pump();

    expect(find.text("DVT"), findsOneWidget);
});

testWidgets("Add job title", (WidgetTester tester) async {
    final addJobTitleField = find.byKey(const ValueKey("Job Title input"));

    await tester.pumpWidget(const MaterialApp(home: EmploymentDetailsForm()));
    await tester.enterText(addJobTitleField, "Junior Software Engineer");
    await tester.pump();

    expect(find.text("Junior Software Engineer"), findsOneWidget);
});
}