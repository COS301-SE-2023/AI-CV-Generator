import 'package:ai_cv_generator/models/user/Reference.dart';
import 'package:ai_cv_generator/models/user/Skill.dart';
import 'package:ai_cv_generator/pages/widgets/referenceView.dart';
import 'package:ai_cv_generator/pages/widgets/skillsView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){

  group("Test Qualifications view", () {
    testWidgets('Qualifications view screen renders correctly test', (WidgetTester tester) async {
      // Create an empty list of references
      final List<Reference> emptyReferences = [];

      // Build the ReferenceSection widget with the empty list
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReferenceSection(reference: emptyReferences),
          ),
        ),
      );

      // Verify that the ReferenceSection widget is displayed
      expect(find.byType(ReferenceSection), findsOneWidget);

      // Verify that there is a message indicating no references
      expect(find.text("No References..."), findsOneWidget);
    });

    testWidgets('Skills view screen input test', (WidgetTester tester) async {
      // Create a list of sample references
      final List<Reference> sampleReferences = [
        Reference(description: 'Reference 1', contact: 'Contact 1', refid: 1),
        Reference(description: 'Reference 2', contact: 'Contact 2', refid: 2),
      ];

      // Build the ReferenceSection widget with the sample references
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ReferenceSection(reference: sampleReferences),
          ),
        ),
      );

      // Verify that the ReferenceSection widget is displayed
      expect(find.byType(ReferenceSection), findsOneWidget);

      // Verify that the sample references are displayed in the widget
      expect(find.text('Reference 1'), findsOneWidget);
      expect(find.text('Reference 2'), findsOneWidget);
      expect(find.text('Contact 1'), findsOneWidget);
      expect(find.text('Contact 2'), findsOneWidget);
    });

    testWidgets('Adding references field displayed', (WidgetTester tester) async {
      await tester.runAsync(() async {
        // Create an empty list of references
        final List<Reference> emptyReferences = [];

        // Build the ReferenceSection widget with the empty list
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ReferenceSection(reference: emptyReferences),
            ),
          ),
        );
        
        // Tap the "Add" button
        await tester.tap(find.byIcon(Icons.add));
        await tester.pump();

        // Verify that the ReferenceSection widget is displayed
        expect(find.byType(ReferenceSection), findsOneWidget);
      });
    });

    testWidgets('Editing References', (WidgetTester tester) async {
      await tester.runAsync(() async {
        // Create a list of sample references
        final List<Reference> sampleReferences = [
          Reference(description: 'Desc 1', contact: 'Contact 1', refid: 1),
        ];

        // Build the ReferenceSection widget with the sample list
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ReferenceSection(reference: sampleReferences),
            ),
          ),
        );

        // Verify that there is a reference field with the initial data
        expect(find.widgetWithText(ReferenceField, 'Desc 1'), findsOneWidget);

        // Tap the "Edit" button
        await tester.tap(find.byIcon(Icons.edit));
        await tester.pump();

        // Verify that editing mode is enabled
        expect(find.byIcon(Icons.delete), findsOneWidget);

        // Tap the "Remove" button for the reference
        await tester.tap(find.byIcon(Icons.delete));
        await tester.pump();

        // Verify that the reference is removed
        expect(find.widgetWithText(ReferenceField, 'Desc 1'), findsNothing);

        // Verify that editing mode is disabled
        expect(find.byIcon(Icons.delete), findsNothing);
      });
    });

    testWidgets('Removing References', (WidgetTester tester) async {
      await tester.runAsync(() async {
        // Create a list of sample references
        final List<Reference> sampleReferences = [
          Reference(description: 'Desc 1', contact: 'Contact 1', refid: 1),
          Reference(description: 'Desc 2', contact: 'Contact 2', refid: 2),
        ];

        // Build the ReferenceSection widget with the sample list
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ReferenceSection(reference: sampleReferences),
            ),
          ),
        );

        // Verify that there are two references initially
        expect(find.widgetWithText(ReferenceField, 'Desc 1'), findsOneWidget);
        expect(find.widgetWithText(ReferenceField, 'Desc 2'), findsOneWidget);

        // Tap the "Edit" button
        await tester.tap(find.byIcon(Icons.edit));
        await tester.pump();

        // Tap the "Remove" button for the first reference
        await tester.tap(find.byIcon(Icons.delete).first);
        await tester.pump();

        // Verify that the first reference is removed
        expect(find.widgetWithText(ReferenceField, 'Desc 1'), findsNothing);
        expect(find.widgetWithText(ReferenceField, 'Desc 2'), findsOneWidget);
      });
    });
  });

  group("Test Skills view", () {

    testWidgets('Skills screen renders correctly test', (WidgetTester tester) async {
      // Create a list of sample skills
      final List<Skill> sampleSkills = [
        Skill(skill: 'Skill 1', reason: 'Reason 1', level: 3, skillid: 1),
        Skill(skill: 'Skill 2', reason: 'Reason 2', level: 4, skillid: 2),
      ];
      
      // Build the SkillSection widget with the sample skills
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SkillSection(skill: sampleSkills),
          ),
        ),
      );

    // Verify that the SkillSection widget is displayed
    expect(find.byType(SkillSection), findsOneWidget);

    // Verify that the skills are displayed in the widget
    expect(find.text('Skill 1'), findsOneWidget);
    expect(find.text('Skill 2'), findsOneWidget);
    expect(find.text('Reason 1'), findsOneWidget);
    expect(find.text('Reason 2'), findsOneWidget);
    expect(find.text('3'), findsOneWidget); // Level value
    expect(find.text('4'), findsOneWidget); // Level value

    });

    testWidgets('Skills screen  test', (WidgetTester tester) async {
      // Create a list of sample skills
      final List<Skill> sampleSkills = [
        Skill(skill: 'Skill 1', reason: 'Reason 1', level: 3, skillid: 1),
        Skill(skill: 'Skill 2', reason: 'Reason 2', level: 4, skillid: 2),
      ];

    // Build the SkillSection widget with the sample skills
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SkillSection(skill: sampleSkills),
        ),
      ),
    );

    await tester.runAsync(() async {
      // Tap the "Add" button
      await tester.tap(find.byIcon(Icons.add));
      await tester.pump();

      // Verify that a new skill input field is added
      expect(find.byType(TextField), findsNWidgets(4));

      // Tap the "Edit" button
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pump();

      // Verify that editing mode is enabled
      expect(find.byIcon(Icons.delete), findsNWidgets(2));

      // Tap the "Remove" button of the first skill
      await tester.tap(find.byIcon(Icons.delete).first);
      await tester.pump();

      // Verify that the first skill is removed
      expect(find.text('Skill 1'), findsNothing);
      expect(find.text('Reason 1'), findsNothing);

      // Tap the "Edit" button again to exit editing mode
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pump();

      // Verify that editing mode is disabled
      expect(find.byIcon(Icons.delete), findsNothing);
      });

    });
  });

}