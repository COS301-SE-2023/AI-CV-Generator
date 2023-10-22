import 'package:ai_cv_generator/models/user/Qualification.dart';
import 'package:ai_cv_generator/models/user/Reference.dart';
import 'package:ai_cv_generator/models/user/Skill.dart';
import 'package:ai_cv_generator/pages/widgets/chatBotView.dart';
import 'package:ai_cv_generator/pages/widgets/linksView.dart';
import 'package:ai_cv_generator/pages/widgets/qualificationsView.dart';
import 'package:ai_cv_generator/pages/widgets/referenceView.dart';
import 'package:ai_cv_generator/pages/widgets/skillsView.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

class MockQualificationsField extends StatelessWidget {
  final TextEditingController qualificationC;
  final TextEditingController intstitutionC;

  const MockQualificationsField({
    Key? key,
    required this.qualificationC,
    required this.intstitutionC,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
      child: Column(
        children: [
          TextFormField(
            key: const Key('Institution input'),
            style: const TextStyle(fontSize: 20),
            controller: intstitutionC,
            textAlign: TextAlign.right,
            decoration: const InputDecoration(
              hintText: "INSTITUTION NAME",
              border: InputBorder.none,
            ),
          ),
          const SizedBox(width: 8),
          TextFormField(
            key: const Key('Qualification input'),
            controller: qualificationC,
            textAlign: TextAlign.right,
            decoration: const InputDecoration(
              hintText: "QUALIFICATION NAME",
              hintStyle: TextStyle(fontSize: 15),
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}

void main(){

  group("Test chatbot", () {
    testWidgets('Chatbot window', (WidgetTester tester) async {
      await tester.runAsync(() async {
        await tester.pumpWidget(
        const MaterialApp(
            home: Scaffold(
              body: ChatBotView(),
            ),
          ),
        );

        //await tester.pump(Duration(seconds: 1));
        await tester.pumpAndSettle();

        // Verify that the initial state is as expected
        expect(find.text("AI Assistant"), findsOneWidget);
        expect(find.text("Type a message"), findsOneWidget);

        expect(find.text("Resume photo?"), findsOneWidget);
        expect(find.text("Creating a CV?"), findsOneWidget);
        expect(find.text("Accessing my details?"), findsOneWidget);
        expect(find.text("Resume length?"), findsOneWidget);
        expect(find.text("Including a cover letter?"), findsOneWidget);
        expect(find.text("Looking for jobs?"), findsOneWidget);

        expect(find.byIcon(Icons.send_rounded), findsOneWidget);
        expect(find.byIcon(Icons.close), findsOneWidget);
      });
    });

    testWidgets('Message input', (WidgetTester tester) async {
      await tester.runAsync(() async {

        const String message = "Hello";
        bool isSender = true;
        
        await tester.pumpWidget(
           MaterialApp(
            home: Scaffold(
              body: Message(
                message: const Text(message), 
                isSender: isSender),
            ),
          ),
        );

        expect(find.byKey(const Key('Message input')), findsOneWidget);
        //await tester.pump();

      });
    });
});

  group("Test Qualifications view", () {
    testWidgets('Qualifications view screen renders correctly', (WidgetTester tester) async {
      // Create an empty list of references
      final List<Qualification> emptyQualifications = [];

      // Build the ReferenceSection widget with the empty list
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: QualificationsSection(qualifications: emptyQualifications),
          ),
        ),
      );

      // Verify that the ReferenceSection widget is displayed
      expect(find.byType(QualificationsSection), findsOneWidget);

      // Verify that there is a message indicating no references
      expect(find.text("No Qualifications..."), findsOneWidget);
    });

    testWidgets('Qualifications input', (WidgetTester tester) async {
      // Create a TextEditingController for each input field
      final TextEditingController qualificationController = TextEditingController();
      final TextEditingController institutionController = TextEditingController();

      // Build the QualificationsField widget with the controllers
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MockQualificationsField(
              qualificationC: qualificationController,
              intstitutionC: institutionController,
            ),
          ),
        ),
      );

      // Enter text into the qualification field
      await tester.enterText(find.byKey(const Key('Qualification input')), 'BSc Computer Science');
      // Verify that the text was entered correctly
      expect(qualificationController.text, 'BSc Computer Science');

      // Enter text into the institution field
      await tester.enterText(find.byKey(const Key('Institution input')), 'University of XYZ');
      // Verify that the text was entered correctly
      expect(institutionController.text, 'University of XYZ');

      //Date pickers test

      // Clean up the controllers
      qualificationController.dispose();
      institutionController.dispose();
    });
});

  group("Test References view", () {
    testWidgets('References view screen renders correctly', (WidgetTester tester) async {
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

    testWidgets('Skills view screen input', (WidgetTester tester) async {
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

        await tester.pump(Duration(seconds: 1));
        await tester.pumpAndSettle();
        
        // Tap the "Add" button
        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();

        // Verify that the ReferenceSection widget is displayed
        expect(find.byType(ReferenceSection), findsOneWidget);
    });

    testWidgets('Editing References', (WidgetTester tester) async {
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

        await tester.pump(Duration(seconds: 1));
        await tester.pumpAndSettle();

        // Verify that there is a reference field with the initial data
        expect(find.widgetWithText(ReferenceField, 'Desc 1'), findsOneWidget);

        // Tap the "Edit" button
        await tester.tap(find.byIcon(Icons.edit));
        await tester.pumpAndSettle();

        // Verify that editing mode is enabled
        expect(find.byIcon(Icons.delete), findsOneWidget);

        // Tap the "Remove" button for the reference
        await tester.tap(find.byIcon(Icons.delete));
        await tester.pumpAndSettle();

        // Verify that the reference is removed
        expect(find.widgetWithText(ReferenceField, 'Desc 1'), findsNothing);

        // Verify that editing mode is disabled
        expect(find.byIcon(Icons.delete), findsNothing);
    });

    testWidgets('Removing References', (WidgetTester tester) async {
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

        await tester.pump(Duration(seconds: 1));
        await tester.pumpAndSettle();

        // Verify that there are two references initially
        expect(find.widgetWithText(ReferenceField, 'Desc 1'), findsOneWidget);
        expect(find.widgetWithText(ReferenceField, 'Desc 2'), findsOneWidget);

        // Tap the "Edit" button
        await tester.tap(find.byIcon(Icons.edit));
        await tester.pumpAndSettle();

        // Tap the "Remove" button for the first reference
        await tester.tap(find.byIcon(Icons.delete).first);
        await tester.pumpAndSettle();

        // Verify that the first reference is removed
        expect(find.widgetWithText(ReferenceField, 'Desc 1'), findsNothing);
        expect(find.widgetWithText(ReferenceField, 'Desc 2'), findsOneWidget);
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

      await tester.pump(Duration(seconds: 1));
      await tester.pumpAndSettle();

      // Tap the "Add" button
      await tester.tap(find.byIcon(Icons.add));
      await tester.pumpAndSettle();

      // Verify that a new skill input field is added
      expect(find.byType(TextField), findsNWidgets(4));

      // Tap the "Edit" button
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();

      // Verify that editing mode is enabled
      expect(find.byIcon(Icons.delete), findsNWidgets(2));

      // Tap the "Remove" button of the first skill
      await tester.tap(find.byIcon(Icons.delete).first);
      await tester.pumpAndSettle();

      // Verify that the first skill is removed
      expect(find.text('Skill 1'), findsNothing);
      expect(find.text('Reason 1'), findsNothing);

      // Tap the "Edit" button again to exit editing mode
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();

      // Verify that editing mode is disabled
      expect(find.byIcon(Icons.delete), findsNothing);
    });
  });

  testWidgets("Links view", (WidgetTester tester) async {
    await tester.pumpWidget( MaterialApp(home: LinksTest(urlC: TextEditingController())));
  
    expect(find.byKey(const Key("url")), findsOneWidget);
  });

}