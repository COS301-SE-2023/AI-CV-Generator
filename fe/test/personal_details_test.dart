import 'package:ai_cv_generator/pages/personaldetails2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testWidgets("Add name", (WidgetTester tester) async {
    final addNameField = find.byKey(const ValueKey("Name input"));

    await tester.pumpWidget(MaterialApp(home: PersonalDetails()));
    await tester.enterText(addNameField, "Jane");
    await tester.pump();

    expect(find.text("Jane"), findsOneWidget);
});

testWidgets("Add last name", (WidgetTester tester) async {
    final addLastNameField = find.byKey(const ValueKey("Last Name input"));

    await tester.pumpWidget(MaterialApp(home: PersonalDetails()));
    await tester.enterText(addLastNameField, "Doe");
    await tester.pump();

    expect(find.text("Doe"), findsOneWidget);
});

testWidgets("Add cell", (WidgetTester tester) async {
    final addCellField = find.byKey(const ValueKey("Cell input"));


    await tester.pumpWidget( MaterialApp(home: PersonalDetails()));
    await tester.enterText(addCellField, "123 456 7890");
    await tester.pump();

    expect(find.text("123 456 7890"), findsOneWidget);
});

testWidgets("Add email", (WidgetTester tester) async {
    final addEmailField = find.byKey(const ValueKey("Email input"));

    await tester.pumpWidget( MaterialApp(home: PersonalDetails()));
    await tester.enterText(addEmailField, "abc@gmail.com");
    await tester.pump();

    expect(find.text("abc@gmail.com"), findsOneWidget);
});

testWidgets("Add address", (WidgetTester tester) async {
    final addAddressField = find.byKey(const ValueKey("Address input"));


    await tester.pumpWidget( MaterialApp(home: PersonalDetails()));
    await tester.enterText(addAddressField, "123 Somewhere Str, Anyplace");
    await tester.pump();

    expect(find.text("123 Somewhere Str, Anyplace"), findsOneWidget);
});
}