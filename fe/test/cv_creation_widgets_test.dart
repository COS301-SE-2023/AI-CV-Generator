import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:ai_cv_generator/pages/screens/homeRedo.dart';
import 'package:ai_cv_generator/pages/util/strings.dart';
import 'package:ai_cv_generator/pages/widgets/description.dart';
import 'package:ai_cv_generator/pages/widgets/employment.dart';
import 'package:ai_cv_generator/pages/widgets/extraActivities.dart';
import 'package:ai_cv_generator/pages/widgets/personaldetails.dart';
import 'package:ai_cv_generator/pages/widgets/qualifications.dart';
import 'package:ai_cv_generator/pages/widgets/references.dart';
import 'package:ai_cv_generator/pages/widgets/skills.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main(){
  group("Test Personal Details", () {

    testWidgets('PersonalDetailsForm should render correctly', (WidgetTester tester) async {
      /*// Mock the Home.adjustedModel to avoid null reference
      Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); // Replace AdjustedModel with your actual model class
      
    // Build our widget and trigger a frame.
      await tester.pumpWidget( MaterialApp(home: PersonalDetailsFormTest()));

      expect(find.text(StringsPersonal.appsubHeadingTitle), findsOneWidget);
      expect(find.text('First Name'), findsOneWidget);
      expect(find.text('Last Name'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
      expect(find.text('Contact Number'), findsOneWidget);
      expect(find.text('General Location'), findsOneWidget);
      expect(find.text('Save and Proceed'), findsOneWidget);*/
    });

    testWidgets("Personal Details Input test", (WidgetTester tester) async {
      /*Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); // Replace AdjustedModel with your actual model class
      // Build our widget and trigger a frame.
      await tester.pumpWidget( MaterialApp(home: PersonalDetailsForm()));

      await tester.enterText(find.byKey(const Key("Name input")), 'John');
      await tester.enterText(find.byKey(const Key("Last Name input")), 'Doe');
      await tester.enterText(find.byKey(const Key("Email input")), 'john.doe@example.com');
      await tester.enterText(find.byKey(const Key("Cell input")), '012 123 4567');
      await tester.enterText(find.byKey(const Key("Address input")), '123 Main Street, Pretoria');
      await tester.pump();

      // Tap the Save and Proceed button again.
      await tester.tap(find.text('Save and Proceed'));
      await tester.pump();

      // Verify that there are no validation errors.
      expect(find.text('This field is required'), findsNothing);
      expect(find.text('This is not a valid email'), findsNothing);*/
    });

  });

  group("Test Qualifications", () {
    testWidgets("Qualifications Form should render correctly", (WidgetTester tester) async {
      /*Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); // Replace AdjustedModel with your actual model class
      
    // Build our widget and trigger a frame.
      await tester.pumpWidget( MaterialApp(home: QualificationsDetailsForm()));

      expect(find.text(StringsQualifications.appsubHeadingTitle), findsOneWidget);
      expect(find.text('Institution'), findsOneWidget);
      expect(find.text('Qualification'), findsOneWidget);
      expect(find.text('Start Date'), findsOneWidget);
      expect(find.text('End Date'), findsOneWidget);*/
      });

      testWidgets("Qualifications Input test", (WidgetTester tester) async {
        /*Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); // Replace AdjustedModel with your actual model class
          
        // Build our widget and trigger a frame.
          await tester.pumpWidget( MaterialApp(home: QualificationsDetailsForm()));

          await tester.enterText(find.byKey(const Key("Institution input")), 'University of Pretoria');
          await tester.enterText(find.byKey(const Key("Qualification input")), 'BSc Computer Science');
          
          // Simulate entering a start date and end date

          // Tap buttons
          await tester.tap(find.text('Add'));
          await tester.pump();

          // Verify the state of the widget after interactions

          // Example: Verify that a new qualification entry is added
          //expect(find.byType(TextMonitorWidget), findsWidgets);
          expect(find.byType(TextFormField), findsNWidgets(4)); // Assumes two text form fields in TextMonitorWidget
          expect(find.byType(DateTimeFormField), findsNWidgets(4)); // Assumes two date form fields in TextMonitorWidget*/
      });
  });

  group("Test Employment", () {
    testWidgets("Employment Form should render correctly", (WidgetTester tester) async {
      /*Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); // Replace AdjustedModel with your actual model class
      
    // Build our widget and trigger a frame.
      await tester.pumpWidget( MaterialApp(home: EmploymentDetailsForm()));

      expect(find.text(StringsEmployment.appsubHeadingTitle), findsOneWidget);
      expect(find.text('Company'), findsOneWidget);
      expect(find.text('Job Title'), findsOneWidget);
      expect(find.text('Start Date'), findsOneWidget);
      expect(find.text('End Date'), findsOneWidget);*/
    });

    testWidgets("Employment Input test", (WidgetTester tester) async {
      /*Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); // Replace AdjustedModel with your actual model class
      
    // Build our widget and trigger a frame.
      await tester.pumpWidget( MaterialApp(home: EmploymentDetailsForm()));

      await tester.enterText(find.byKey(const Key("Company input")), 'University of Pretoria');
      await tester.enterText(find.byKey(const Key("Job Title input")), 'BSc Computer Science');
      
      // Simulate entering a start date and end date

      // Tap buttons
      await tester.tap(find.text('Add'));
      await tester.pump();

      // Verify the state of the widget after interactions

      // Example: Verify that a new qualification entry is added
      //expect(find.byType(TextMonitorWidget), findsWidgets);
      expect(find.byType(TextFormField), findsNWidgets(4)); // Assumes two text form fields in TextMonitorWidget
      expect(find.byType(DateTimeFormField), findsNWidgets(4)); // Assumes two date form fields in TextMonitorWidget*/
    });
    
  });

  group("Test Skills", () {
    testWidgets("Skills Form should render correctly", (WidgetTester tester) async {
      /*Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); // Replace AdjustedModel with your actual model class
      
    // Build our widget and trigger a frame.
      await tester.pumpWidget( MaterialApp(home: SkillsForm()));

      expect(find.text(StringsSkill.appsubHeadingTitle), findsOneWidget);
      expect(find.text('Skill 1'), findsOneWidget);
      expect(find.text('Skill 2'), findsOneWidget);
      expect(find.text('Skill 3'), findsOneWidget);*/
      });
    testWidgets("Skills Input test", (WidgetTester tester) async {
      Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); // Replace AdjustedModel with your actual model class
      // Build our widget and trigger a frame.
      await tester.pumpWidget( MaterialApp(home: SkillsForm()));

      await tester.enterText(find.byKey(const Key("Skill1")), 'C++');
      await tester.enterText(find.byKey(const Key("Skill2")), 'Java');
      await tester.enterText(find.byKey(const Key("Skill3")), 'Python');
      await tester.pump();

      // Tap the Save and Proceed button again.
      await tester.tap(find.text('Save & Proceed'));
      await tester.pump();

      // Verify that there are no validation errors.
      expect(find.text('Please enter some text'), findsNothing);
    });
  });

  group("Test References", () {
    testWidgets("References Form should render correctly", (WidgetTester tester) async {
      Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); // Replace AdjustedModel with your actual model class
      
    // Build our widget and trigger a frame.
      await tester.pumpWidget( MaterialApp(home: ReferencesForm()));

      expect(find.text(StringsReferences.appsubHeadingTitle), findsOneWidget);
      expect(find.text('Full Name'), findsOneWidget);
      expect(find.text('Job Title'), findsOneWidget);
      expect(find.text('Contact Number'), findsOneWidget);
      expect(find.text('Email'), findsOneWidget);
    });
    testWidgets("References Input test", (WidgetTester tester) async {
      Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); // Replace AdjustedModel with your actual model class
      // Build our widget and trigger a frame.
      await tester.pumpWidget( MaterialApp(home: ReferencesForm()));

      await tester.enterText(find.byKey(const Key("Name input")), 'John Doe');
      await tester.enterText(find.byKey(const Key("Job Title input")), 'Senior Software Engineer');
      await tester.enterText(find.byKey(const Key("Email input")), 'john.doe@example.com');
      await tester.enterText(find.byKey(const Key("Cell input")), '1234567890');
      await tester.pump();

      // Tap the Save and Proceed button again.
      //await tester.tap(find.text('Save & Generate'));
      //await tester.pumpAndSettle();

      // Verify that there are no validation errors.
      expect(find.text('Please enter some text'), findsNothing);
    });
  });
  
  group("Test Description", () {
    testWidgets("Description Form should render correctly", (WidgetTester tester) async {
      /*Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); // Replace AdjustedModel with your actual model class
      
    // Build our widget and trigger a frame.
      await tester.pumpWidget( MaterialApp(home: DescriptionForm()));

      expect(find.text(StringsDescription.appsubHeadingTitle), findsOneWidget);
      expect(find.text('Description'), findsOneWidget);*/
    });

    testWidgets("Description Input test", (WidgetTester tester) async {
      /*Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); // Replace AdjustedModel with your actual model class
      // Build our widget and trigger a frame.
      await tester.pumpWidget( MaterialApp(home: DescriptionForm()));

      await tester.enterText(find.byKey( Key("Description start")), 'I am intelligent');
      await tester.pump();

      // Tap the Save and Proceed button again.
      await tester.tap(find.text('Save and Proceed'));
      //await tester.pumpAndSettle();

      // Verify that there are no validation errors.
      expect(find.text('Please enter some text'), findsNothing);*/
    });
  });

  testWidgets("Extra activities Input test", (WidgetTester tester) async {
    /*Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); // Replace AdjustedModel with your actual model class
    // Build our widget and trigger a frame.
    await tester.pumpWidget( MaterialApp(home: ExtraActivitiesSection(employment: [],)));
    
    expect(find.byIcon(Icons.add), findsOneWidget);*/
  });
}