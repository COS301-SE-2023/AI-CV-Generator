import 'package:ai_cv_generator/pages/references2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testWidgets("Add name", (WidgetTester tester) async {
    final addNameField = find.byKey(const ValueKey("Name input"));

    await tester.pumpWidget(const MaterialApp(home: ReferencesForm()));
    await tester.enterText(addNameField, "Joe Smith");
    await tester.pump();

    expect(find.text("Joe Smith"), findsOneWidget);
});

testWidgets("Add job title", (WidgetTester tester) async {
    final addJobTitleField = find.byKey(const ValueKey("Job Title input"));

    await tester.pumpWidget(const MaterialApp(home: ReferencesForm()));
    await tester.enterText(addJobTitleField, "Senior Software Engineer");
    await tester.pump();

    expect(find.text("Senior Software Engineer"), findsOneWidget);
});

testWidgets("Add cell", (WidgetTester tester) async {
    final addCellField = find.byKey(const ValueKey("Cell input"));

    await tester.pumpWidget(const MaterialApp(home: ReferencesForm()));
    await tester.enterText(addCellField, "123 456 7890");
    await tester.pump();

    expect(find.text("123 456 7890"), findsOneWidget);
});

testWidgets("Add email", (WidgetTester tester) async {
    final addEmailField = find.byKey(const ValueKey("Email input"));

    await tester.pumpWidget(const MaterialApp(home: ReferencesForm()));
    await tester.enterText(addEmailField, "joe@gmail.com");
    await tester.pump();

    expect(find.text("joe@gmail.com"), findsOneWidget);
});
}