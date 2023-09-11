import 'package:ai_cv_generator/models/user/Skill.dart';
import 'package:ai_cv_generator/pages/widgets/skillsView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  group("Test Skills view", () {

    testWidgets('Skills Screen renders correctly test', (WidgetTester tester) async {
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

    testWidgets('Skills Screen test', (WidgetTester tester) async {
      // Create a list of sample skills
      final List<Skill> sampleSkills = [
        Skill(skill: 'Skill 1', reason: 'Reason 1', level: 3, skillid: 1),
        Skill(skill: 'Skill 2', reason: 'Reason 2', level: 4, skillid: 2),
      ];

    // Create a variable to hold the asynchronous operation
    late Future<void> testFuture;

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