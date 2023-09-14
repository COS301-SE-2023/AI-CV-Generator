import 'package:ai_cv_generator/models/user/Skill.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:ai_cv_generator/pages/screens/home.dart';
import 'package:ai_cv_generator/pages/widgets/skillsForm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('SkillsDetailsForm should build correctly', (WidgetTester tester) async {
    final userModel = UserModel(
    fname: 'John',
    lname: 'Doe',
    username: 'jd',
  );

  // Assign the test-specific UserModel instance to Home.adjustedModel
  Home.adjustedModel = userModel;
    
    // Build your SkillsDetailsForm widget
    await tester.pumpWidget(
      MaterialApp(
        home: SkillsDetailsForm()
      ),
    );

    // Verify that the SkillsDetailsForm is displayed
    expect(find.byType(SkillsDetailsForm), findsOneWidget);

    // You can add more specific tests here if needed
  });

  testWidgets('Test input fields in TextMonitorWidget', (WidgetTester tester) async {
    final userModel = UserModel(
      fname: 'John',
      lname: 'Doe',
      username: 'jd',
    );

    // Assign the test-specific UserModel instance to Home.adjustedModel
    Home.adjustedModel = userModel;
    
    // Build your TextMonitorWidget with some initial data
    await tester.pumpWidget(
      MaterialApp(
        home: SkillsDetailsForm(),
      ),
    );

        // Add a skill first
    await tester.tap(find.text('Add'));
    await tester.pump();

    // Find the input fields by their key
    final skillInput = find.byKey(Key('skill input'));
    final reasonInput = find.byKey(Key('reason input'));

    // Enter text into the skill input field
    await tester.enterText(skillInput, 'New Test Skill');
    await tester.enterText(reasonInput, 'New Test Reason');

    // Verify that the entered text is correctly displayed
    expect(find.text('New Test Skill'), findsOneWidget);
    expect(find.text('New Test Reason'), findsOneWidget);
  });

  testWidgets('Delete Skill Test', (WidgetTester tester) async {
    // Build our widget and trigger a frame.
    await tester.pumpWidget(MaterialApp(home: SkillsDetailsForm()));

    // Add a skill first
    await tester.tap(find.byType(ElevatedButton).first);
    await tester.pump();

    // Ensure that the skill has been added
    expect(find.text('Skill'), findsOneWidget);

    // Tap the delete button
    await tester.tap(find.byIcon(Icons.delete).first);
    await tester.pump();

    // Verify that the skill has been deleted
    expect(find.text('Skill'), findsNothing);
  });
}