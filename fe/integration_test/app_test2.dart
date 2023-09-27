import 'package:ai_cv_generator/models/user/Qualification.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:ai_cv_generator/pages/screens/homeRedo.dart';
import 'package:ai_cv_generator/pages/screens/job.dart';
import 'package:ai_cv_generator/pages/screens/login.dart';
import 'package:ai_cv_generator/pages/util/strings.dart';
import 'package:ai_cv_generator/pages/widgets/description.dart';
import 'package:ai_cv_generator/pages/widgets/employment.dart';
import 'package:ai_cv_generator/pages/widgets/extraActivities.dart';
import 'package:ai_cv_generator/pages/widgets/personaldetails.dart';
import 'package:ai_cv_generator/pages/widgets/qualifications.dart';
import 'package:ai_cv_generator/pages/widgets/referencesForm.dart';
import 'package:ai_cv_generator/pages/widgets/skillsForm.dart';
import 'package:ai_cv_generator/pages/employment2.dart';
import 'package:ai_cv_generator/pages/screens/login.dart';
import 'package:ai_cv_generator/pages/personaldetails2.dart';
import 'package:ai_cv_generator/pages/qualifications2.dart';
import 'package:ai_cv_generator/pages/references2.dart';
import 'package:ai_cv_generator/pages/skills2.dart';
import 'package:ai_cv_generator/pages/screens/help.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_driver/flutter_driver.dart' as flutter_driver;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
//import 'package:test/test.dart';



import 'package:ai_cv_generator/pages/screens/Register.dart';
import 'package:mockito/mockito.dart';

class MockUserModel extends Mock implements UserModel {
  @override
  List<Qualification>? get qualifications => [
    Qualification(qualification: 'BSc Computer Science', intstitution: 'University of Pretoria', date: DateTime(2023, 9, 18), quaid: 123, endo: DateTime(2023, 12, 31)),
  ];
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('E2E test', () {
    testWidgets('Register', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: RegisterPage()));

      await tester.pumpAndSettle();
      //do
      await tester.enterText(find.byKey(const Key('fname')), 'Amanda');
      await tester.enterText(find.byKey(const Key('lname')), 'Khuzwayo');
      await tester.enterText(find.byKey(const Key('username')), 'amandak');
      await tester.enterText(find.byKey(const Key('email')), 'ak@gmail.com');
      await tester.enterText(find.byKey(const Key('password')), '1234');
      await tester.enterText(find.byKey(const Key('passwordretype')), '1234');

      await tester.pumpAndSettle();
      //test
      expect(find.text('Amanda'), findsOneWidget);
      expect(find.text('Khuzwayo'), findsOneWidget);
      expect(find.text('amandak'), findsOneWidget);
      expect(find.text('ak@gmail.com'), findsOneWidget);
      expect(find.text('1234'), findsNWidgets(2));
      expect(find.text('Register'), findsNWidgets(2));

    });

  testWidgets('Login', (tester) async {
    //app.main();
    await tester.pumpWidget(MaterialApp(
      home: const Login(),
    ));

    await tester.pumpAndSettle();
    //do
    await tester.enterText(find.byKey(const Key('name')), 'amandak');
    await tester.enterText(find.byKey(const Key('password')), '1234');

    await tester.pumpAndSettle();
    //test
    expect(find.text('amandak'), findsOneWidget);
    expect(find.text('1234'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
  });

   testWidgets('Survey: Personal Details', (tester) async {
      Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); 

      await tester.pumpWidget( MaterialApp(home: PersonalDetailsFormTest()));

      await tester.enterText(find.byKey(const Key("Name input")), 'Jane');
      await tester.enterText(find.byKey(const Key("Last Name input")), 'Doe');
      await tester.enterText(find.byKey(const Key("Email input")), 'janedoe@gmail.com');
      await tester.enterText(find.byKey(const Key("Cell input")), '012 123 4567');
      await tester.enterText(find.byKey(const Key("Address input")), 'Pretoria');
      await tester.pump();


      expect(find.text('Jane'), findsOneWidget);
      expect(find.text('Doe'), findsOneWidget);
      expect(find.text('janedoe@gmail.com'), findsOneWidget);
      expect(find.text('012 123 4567'), findsOneWidget);
      expect(find.text('Pretoria'), findsOneWidget);
      expect(find.text('Save and Proceed'), findsOneWidget);
    });

    testWidgets('Survey: Qualification Details', (tester) async {
      Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); // Replace AdjustedModel with your actual model class
      
    // Build our widget and trigger a frame.
      await tester.pumpWidget( MaterialApp(home: QualificationsDetailsFormTest()));

      await tester.enterText(find.byKey(const Key("Institution input")), 'University of Pretoria');
      await tester.enterText(find.byKey(const Key("Qualification input")), 'BSc Computer Science');

      // Simulate selecting dates
      await tester.tap(find.byKey(const Key("Start date input")));
      await tester.pumpAndSettle(); // Wait for date picker to appear
      await tester.tap(find.text('OK')); // Select a date (you may need to adapt this part based on your date picker implementation)
      await tester.pumpAndSettle(); // Wait for date picker to close

      await tester.tap(find.byKey(const Key("End date input")));
      await tester.pumpAndSettle(); // Wait for date picker to appear
      await tester.tap(find.text('OK')); // Select a date (you may need to adapt this part based on your date picker implementation)
      await tester.pumpAndSettle(); // Wait for date picker to close

      expect(find.text('University of Pretoria'), findsOneWidget);
      expect(find.text('BSc Computer Science'), findsOneWidget);
      expect(find.text('Start Date'), findsOneWidget);
      expect(find.text('End Date'), findsOneWidget);
      expect(find.text('Add'), findsOneWidget);
      expect(find.text('Save and Proceed'), findsOneWidget);
    });

    testWidgets('Survey: Employment Details', (tester) async {
      Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak');
      await tester.pumpWidget( MaterialApp(home: EmploymentDetailsFormTest()));
      //await tester.pumpAndSettle();

      //debugDumpApp();
      // Verify that the page is initially empty
      expect(find.byKey(const Key("Company input")), findsOneWidget);
      expect(find.byKey(const Key("Job Title input")), findsOneWidget);
      expect(find.byKey(const Key("Employment start")), findsOneWidget);
      expect(find.byKey(const Key("Employment end")), findsOneWidget);

      await tester.enterText(find.byKey(const Key("Company input")), 'Dynamic Visual Technologies');
      await tester.enterText(find.byKey(const Key("Job Title input")), 'Junior Software Engineer');

      // Simulate selecting dates
      await tester.tap(find.byKey(const Key("Employment start")));
      await tester.pumpAndSettle(); // Wait for date picker to appear
      await tester.tap(find.text('OK')); // Select a date (you may need to adapt this part based on your date picker implementation)
      await tester.pumpAndSettle(); // Wait for date picker to close

      await tester.tap(find.byKey(const Key("Employment end")));
      await tester.pumpAndSettle(); // Wait for date picker to appear
      await tester.tap(find.text('OK')); // Select a date (you may need to adapt this part based on your date picker implementation)
      await tester.pumpAndSettle(); // Wait for date picker to clo

      expect(find.text('Dynamic Visual Technologies'), findsOneWidget);
      expect(find.text('Junior Software Engineer'), findsOneWidget);
      expect(find.text('Start Date'), findsOneWidget);
      expect(find.text('End Date'), findsOneWidget);
      expect(find.text('Add'), findsOneWidget);
      expect(find.text('Save and Proceed'), findsOneWidget);
    });

    testWidgets('Survey: References Details', (tester) async {
      Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak');
      await tester.pumpWidget( MaterialApp(home: ReferencesDetailsFormTest()));
      //await tester.pumpAndSettle();

      //debugDumpApp();
      // Verify that the page is initially empty
      expect(find.byKey(const Key("description input")), findsOneWidget);
      expect(find.byKey(const Key("contact input")), findsOneWidget);

      await tester.enterText(find.byKey(const Key("description input")), 'John Doe - Senior Software Engineer');
      await tester.enterText(find.byKey(const Key("contact input")), '123456789');

      expect(find.text('John Doe - Senior Software Engineer'), findsOneWidget);
      expect(find.text('123456789'), findsOneWidget);
      expect(find.text('Add'), findsOneWidget);
      expect(find.text('Save and Proceed'), findsOneWidget);
    });

    testWidgets('Survey: Skills Details', (tester) async {
      Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak');
      await tester.pumpWidget( MaterialApp(home: SkillsDetailsFormTest()));
      //await tester.pumpAndSettle();

      //debugDumpApp();
      // Verify that the page is initially empty
      expect(find.byKey(const Key("skill input")), findsOneWidget);
      expect(find.byKey(const Key("reason input")), findsOneWidget);
      expect(find.byKey(const Key("level input")), findsOneWidget);

      await tester.enterText(find.byKey(const Key("skill input")), 'Java');
      await tester.enterText(find.byKey(const Key("reason input")), 'Used it for app development');

      //dropdown
      await tester.tap(find.byKey(const Key("level input")));
      // Wait for the menu to appear
      await tester.pump(const Duration(seconds: 1));
      await tester.tap(find.text('3'));
      //wait for selection
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Java'), findsOneWidget);
      expect(find.text('Used it for app development'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);

      expect(find.text('Add'), findsOneWidget);
      expect(find.text('Save and Proceed'), findsOneWidget);
    });

    testWidgets('Survey: Description form', (tester) async {
      Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak');
      await tester.pumpWidget( MaterialApp(home: DescriptionFormTest()));
      //await tester.pumpAndSettle();

      //debugDumpApp();
      // Verify that the page is initially empty
      expect(find.byKey(const Key("Description start")), findsOneWidget);
      
      await tester.enterText(find.byKey(const Key("Description start")), 'I am a talented software engineer');
      
      expect(find.text('I am a talented software engineer'), findsOneWidget);
      expect(find.text('Save and Proceed'), findsOneWidget);
    });

    testWidgets('Job recommendations', (tester) async {
        Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak');
        await tester.pumpWidget( MaterialApp(home: JobsPageTest()));

        expect(find.text("RECOMMENDED FOR YOU"), findsOneWidget);
        expect(find.byKey(const Key("occupation")), findsOneWidget);
        expect(find.byKey(const Key("location")), findsOneWidget);
        expect(find.text("Search"), findsOneWidget);

      
        await tester.enterText(find.byKey(const Key("occupation")), 'Software Engineer');
        await tester.enterText(find.byKey(const Key("location")), 'Pretoria');

        expect(find.text('Software Engineer'), findsOneWidget);
        expect(find.text('Pretoria'), findsOneWidget);
    });

  testWidgets("Extra activities input", (WidgetTester tester) async {
    /*Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); // Replace AdjustedModel with your actual model class
    // Build our widget and trigger a frame.
    await tester.pumpWidget( MaterialApp(home: ExtraActivitiesSection(employment: [],)));
    
    await tester.enterText(find.byKey( Key("Organisation")), 'Gendac');
    await tester.enterText(find.byKey( Key("Activity")), 'Graduate Development Program');
    //await tester.enterText(find.byKey( Key("Date")), 'Gendac');
    await tester.pump();

    expect(find.text('Gendac'), findsOneWidget);
    expect(find.text('Graduate Development Program'), findsOneWidget);
    expect(find.text("Date"), findsOneWidget);*/
  });
  testWidgets('Help page', (tester) async {
    Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak');
    await tester.pumpWidget( MaterialApp(home: Help()));

    expect(find.text('What can we help you with?'), findsOneWidget);
  });
  
});


  group('Navigation and user flow tests', () {
    testWidgets('Register input', (tester) async {
      await tester.pumpWidget(const MaterialApp(home: RegisterPage()));

      await tester.pumpAndSettle();
      //do
      await tester.enterText(find.byKey(const Key('fname')), 'Amanda');
      await tester.enterText(find.byKey(const Key('lname')), 'Khuzwayo');
      await tester.enterText(find.byKey(const Key('username')), 'amandak');
      await tester.enterText(find.byKey(const Key('email')), 'ak@gmail.com');
      await tester.enterText(find.byKey(const Key('password')), '1234');
      await tester.enterText(find.byKey(const Key('passwordretype')), '1234');

      await tester.pumpAndSettle();
      //test
      expect(find.text('Amanda'), findsOneWidget);
      expect(find.text('Khuzwayo'), findsOneWidget);
      expect(find.text('amandak'), findsOneWidget);
      expect(find.text('ak@gmail.com'), findsOneWidget);
      expect(find.text('1234'), findsNWidgets(2));
      expect(find.text('Register'), findsNWidgets(2));

    });

  testWidgets('Login input', (tester) async {
    //app.main();
    await tester.pumpWidget(MaterialApp(
      home: const Login(),
    ));

    await tester.pumpAndSettle();
    //do
    await tester.enterText(find.byKey(const Key('name')), 'amandak');
    await tester.enterText(find.byKey(const Key('password')), '1234');

    await tester.pumpAndSettle();
    //test
    expect(find.text('amandak'), findsOneWidget);
    expect(find.text('1234'), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.byKey(const Key('create_account')), findsOneWidget);
    expect(find.text('Forgot your password?'), findsOneWidget);
  });

   testWidgets('Survey: Personal Details input', (tester) async {
      Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); 

      await tester.pumpWidget( MaterialApp(home: PersonalDetailsFormTest()));

      await tester.enterText(find.byKey(const Key("Name input")), 'Jane');
      await tester.enterText(find.byKey(const Key("Last Name input")), 'Doe');
      await tester.enterText(find.byKey(const Key("Email input")), 'janedoe@gmail.com');
      await tester.enterText(find.byKey(const Key("Cell input")), '012 123 4567');
      await tester.enterText(find.byKey(const Key("Address input")), 'Pretoria');
      await tester.pump();


      expect(find.text('Jane'), findsOneWidget);
      expect(find.text('Doe'), findsOneWidget);
      expect(find.text('janedoe@gmail.com'), findsOneWidget);
      expect(find.text('012 123 4567'), findsOneWidget);
      expect(find.text('Pretoria'), findsOneWidget);
      expect(find.text('Save and Proceed'), findsOneWidget);
    });

    testWidgets('Survey: Qualification Details input', (tester) async {
      Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); // Replace AdjustedModel with your actual model class
      
    // Build our widget and trigger a frame.
      await tester.pumpWidget( MaterialApp(home: QualificationsDetailsFormTest()));

      expect(find.text(StringsQualifications.appsubHeadingTitle), findsOneWidget);
      expect(find.text('Institution'), findsOneWidget);
      expect(find.text('Qualification'), findsOneWidget);
      expect(find.text('Start Date'), findsOneWidget);
      expect(find.text('End Date'), findsOneWidget);

      await tester.enterText(find.byKey(const Key("Institution input")), 'University of Pretoria');
      await tester.enterText(find.byKey(const Key("Qualification input")), 'BSc Computer Science');

      // Simulate selecting dates
      await tester.tap(find.byKey(const Key("Start date input")));
      await tester.pumpAndSettle(); // Wait for date picker to appear
      await tester.tap(find.text('OK')); // Select a date (you may need to adapt this part based on your date picker implementation)
      await tester.pumpAndSettle(); // Wait for date picker to close

      await tester.tap(find.byKey(const Key("End date input")));
      await tester.pumpAndSettle(); // Wait for date picker to appear
      await tester.tap(find.text('OK')); // Select a date (you may need to adapt this part based on your date picker implementation)
      await tester.pumpAndSettle(); // Wait for date picker to close

      expect(find.text('University of Pretoria'), findsOneWidget);
      expect(find.text('BSc Computer Science'), findsOneWidget);
      expect(find.text('Start Date'), findsOneWidget);
      expect(find.text('End Date'), findsOneWidget);
      expect(find.text('Add'), findsOneWidget);
      expect(find.text('Back'), findsOneWidget);
      expect(find.text('Save and Proceed'), findsOneWidget);
    });

    testWidgets('Survey: Employment Details input', (tester) async {
      Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak');
      await tester.pumpWidget( MaterialApp(home: EmploymentDetailsFormTest()));
      //await tester.pumpAndSettle();

      //debugDumpApp();
      // Verify that the page is initially empty
      expect(find.byKey(const Key("Company input")), findsOneWidget);
      expect(find.byKey(const Key("Job Title input")), findsOneWidget);
      expect(find.byKey(const Key("Employment start")), findsOneWidget);
      expect(find.byKey(const Key("Employment end")), findsOneWidget);

      await tester.enterText(find.byKey(const Key("Company input")), 'Dynamic Visual Technologies');
      await tester.enterText(find.byKey(const Key("Job Title input")), 'Junior Software Engineer');

      // Simulate selecting dates
      await tester.tap(find.byKey(const Key("Employment start")));
      await tester.pumpAndSettle(); // Wait for date picker to appear
      await tester.tap(find.text('OK')); // Select a date (you may need to adapt this part based on your date picker implementation)
      await tester.pumpAndSettle(); // Wait for date picker to close

      await tester.tap(find.byKey(const Key("Employment end")));
      await tester.pumpAndSettle(); // Wait for date picker to appear
      await tester.tap(find.text('OK')); // Select a date (you may need to adapt this part based on your date picker implementation)
      await tester.pumpAndSettle(); // Wait for date picker to clo

      expect(find.text('Dynamic Visual Technologies'), findsOneWidget);
      expect(find.text('Junior Software Engineer'), findsOneWidget);
      expect(find.text('Start Date'), findsOneWidget);
      expect(find.text('End Date'), findsOneWidget);
      expect(find.text('Add'), findsOneWidget);
      expect(find.text('Back'), findsOneWidget);
      expect(find.text('Save and Proceed'), findsOneWidget);
    });

    testWidgets('Survey: References Details input', (tester) async {
      Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak');
      await tester.pumpWidget( MaterialApp(home: ReferencesDetailsFormTest()));
      //await tester.pumpAndSettle();

      //debugDumpApp();
      // Verify that the page is initially empty
      expect(find.byKey(const Key("description input")), findsOneWidget);
      expect(find.byKey(const Key("contact input")), findsOneWidget);

      await tester.enterText(find.byKey(const Key("description input")), 'John Doe - Senior Software Engineer');
      await tester.enterText(find.byKey(const Key("contact input")), '123456789');

      expect(find.text('John Doe - Senior Software Engineer'), findsOneWidget);
      expect(find.text('123456789'), findsOneWidget);
      expect(find.text('Add'), findsOneWidget);
      expect(find.text('Back'), findsOneWidget);
      expect(find.text('Save and Proceed'), findsOneWidget);
    });

    testWidgets('Survey: Skills Details input', (tester) async {
      Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak');
      await tester.pumpWidget( MaterialApp(home: SkillsDetailsFormTest()));
      //await tester.pumpAndSettle();

      //debugDumpApp();
      // Verify that the page is initially empty
      expect(find.byKey(const Key("skill input")), findsOneWidget);
      expect(find.byKey(const Key("reason input")), findsOneWidget);
      expect(find.byKey(const Key("level input")), findsOneWidget);

      await tester.enterText(find.byKey(const Key("skill input")), 'Java');
      await tester.enterText(find.byKey(const Key("reason input")), 'Used it for app development');

      //dropdown
      await tester.tap(find.byKey(const Key("level input")));
      // Wait for the menu to appear
      await tester.pump(const Duration(seconds: 1));
      await tester.tap(find.text('3'));
      //wait for selection
      await tester.pump(const Duration(seconds: 1));

      expect(find.text('Java'), findsOneWidget);
      expect(find.text('Used it for app development'), findsOneWidget);
      expect(find.text('3'), findsOneWidget);

      expect(find.text('Add'), findsOneWidget);
      expect(find.text('Back'), findsOneWidget);
      expect(find.text('Save and Proceed'), findsOneWidget);
    });

    testWidgets('Survey: Description form input', (tester) async {
      Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak');
      await tester.pumpWidget( MaterialApp(home: DescriptionFormTest()));
      //await tester.pumpAndSettle();

      //debugDumpApp();
      // Verify that the page is initially empty
      expect(find.byKey(const Key("Description start")), findsOneWidget);
      
      await tester.enterText(find.byKey(const Key("Description start")), 'I am a talented software engineer');
      
      expect(find.text('I am a talented software engineer'), findsOneWidget);
      expect(find.text('Back'), findsOneWidget);
      expect(find.text('Save and Proceed'), findsOneWidget);
    });

    testWidgets('Jobs input', (tester) async {
        Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak');
        await tester.pumpWidget( MaterialApp(home: JobsPageTest()));

        expect(find.text("RECOMMENDED FOR YOU"), findsOneWidget);
        expect(find.byKey(const Key("occupation")), findsOneWidget);
        expect(find.byKey(const Key("location")), findsOneWidget);
        expect(find.text("Search"), findsOneWidget);

      
        await tester.enterText(find.byKey(const Key("occupation")), 'Software Engineer');
        await tester.enterText(find.byKey(const Key("location")), 'Pretoria');

        expect(find.text('Software Engineer'), findsOneWidget);
        expect(find.text('Pretoria'), findsOneWidget);
    });

  testWidgets("Extra activities input", (WidgetTester tester) async {
    /*Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); // Replace AdjustedModel with your actual model class
    // Build our widget and trigger a frame.
    await tester.pumpWidget( MaterialApp(home: ExtraActivitiesSection(employment: [],)));
    
    await tester.enterText(find.byKey( Key("Organisation")), 'Gendac');
    await tester.enterText(find.byKey( Key("Activity")), 'Graduate Development Program');
    //await tester.enterText(find.byKey( Key("Date")), 'Gendac');
    await tester.pump();

    expect(find.text('Gendac'), findsOneWidget);
    expect(find.text('Graduate Development Program'), findsOneWidget);
    expect(find.text("Date"), findsOneWidget);*/
  });
});

  group('Security tests', () {
    testWidgets('Login attempt 1: no password', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginTest(),
      ));

    await tester.pumpAndSettle();
    //do
    await tester.enterText(find.byKey(const Key('name')), 'amandak');
    await tester.enterText(find.byKey(const Key('password')), '');

    await tester.pumpAndSettle();
    //test
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text('This field is required'), findsOneWidget);
    });

    testWidgets('Login attempt 2: incorrect password', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginTest(),
      ));

    await tester.pumpAndSettle();
    //do
    await tester.enterText(find.byKey(const Key('name')), 'amandak');
    await tester.enterText(find.byKey(const Key('password')), 'abcd');

    await tester.pumpAndSettle();
    //test
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text("Invalid Login!"), findsOneWidget);
    });

    testWidgets('Login attempt 3: incorrect username', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginTest(),
      ));

    await tester.pumpAndSettle();
    //do
    await tester.enterText(find.byKey(const Key('name')), 'johnny');
    await tester.enterText(find.byKey(const Key('password')), '1234');

    await tester.pumpAndSettle();
    //test
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();

    expect(find.text("Invalid Login!"), findsOneWidget);
    });

    testWidgets('Login attempt 4: incorrect username and password', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: LoginTest(),
      ));

      await tester.pumpAndSettle();
      //do
      await tester.enterText(find.byKey(const Key('name')), 'johnny');
      await tester.enterText(find.byKey(const Key('password')), 'poggi');

      await tester.pumpAndSettle();
      //test
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();

      expect(find.text("Invalid Login!"), findsOneWidget);
    });
  });

  group('Error handling and recovery tests', () {
    testWidgets('Personal details test: empty fields ', (tester) async {
      Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); 
      await tester.pumpWidget( MaterialApp(home: PersonalDetailsFormTest()));

      await tester.tap(find.text('Save and Proceed'));
      await Future.delayed(Duration(seconds: 5));

      expect(find.text('This field is required'), findsNWidgets(2));
      expect(find.text('This is not a valid email'), findsOneWidget);
    });

    testWidgets('Qualifications details test: empty fields ', (tester) async {
      Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); 
      await tester.pumpWidget( MaterialApp(home: QualificationsDetailsFormTest()));

      await tester.tap(find.text('Add'));
      await Future.delayed(Duration(seconds: 5));

      await tester.tap(find.text('Save and Proceed'));
      await Future.delayed(Duration(seconds: 5));

      expect(find.text('This field is required'), findsNWidgets(4));
    });

    testWidgets('Employment details test: empty fields ', (tester) async {
      Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); 
      await tester.pumpWidget( MaterialApp(home: EmploymentDetailsFormTest()));

      await tester.tap(find.text('Add'));
      await Future.delayed(Duration(seconds: 5));

      await tester.tap(find.text('Save and Proceed'));
      await Future.delayed(Duration(seconds: 5));

      expect(find.text('Please enter some text'), findsNWidgets(4));
    });

    testWidgets('References test: empty fields ', (tester) async {
      Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); 
      await tester.pumpWidget( MaterialApp(home: DescriptionFormTest()));


      await tester.tap(find.text('Save and Proceed'));
      await Future.delayed(Duration(seconds: 5));

      expect(find.text('Please enter some text'), findsOneWidget);
    });

    testWidgets('Register test: empty fields ', (tester) async {
      /*await tester.pumpWidget( MaterialApp(home: RegisterPageTest()));

      await tester.pumpAndSettle();
      //do
      await tester.enterText(find.byKey(const Key('fname')), '');
      await tester.enterText(find.byKey(const Key('lname')), '');
      await tester.enterText(find.byKey(const Key('username')), '');
      await tester.enterText(find.byKey(const Key('email')), '');
      await tester.enterText(find.byKey(const Key('password')), '');
      await tester.enterText(find.byKey(const Key('passwordretype')), '');

      await tester.pumpAndSettle();
      //await Future.delayed(Duration(seconds: 8));

      await tester.tap(find.byKey(const Key('Register button')));
      await Future.delayed(Duration(seconds: 8));
      //test
      expect(find.text('This field is required'), findsNWidgets(5));
      expect(find.text('This is not a valid email'), findsOneWidget);*/
    });
  });

  group("Input handling and validation", () {
      testWidgets('Personal details: invalid input formats', (tester) async {
        Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); 
        await tester.pumpWidget( MaterialApp(home: PersonalDetailsFormTest()));

        await tester.enterText(find.byKey(const Key("Name input")), 'Jane');
        await tester.enterText(find.byKey(const Key("Last Name input")), 'Doe');
        await tester.enterText(find.byKey(const Key("Email input")), 'someemail.co');
        await tester.enterText(find.byKey(const Key("Cell input")), '012 123 4567');
        await tester.enterText(find.byKey(const Key("Address input")), 'Pretoria');
        await tester.pump();

        await tester.tap(find.text('Save and Proceed'));
        await Future.delayed(Duration(seconds: 5));

        expect(find.text('This is not a valid email'), findsOneWidget);
      });
    });

  group('end-to-end testv1', () {
    testWidgets('Login page fields',
      (WidgetTester tester) async {
        //app.main();
        await tester.pumpWidget(const MaterialApp(home: Login()));
        await tester.pumpAndSettle();
        //do
        await tester.enterText(find.byKey(const Key('name')), 'amandak');
        await tester.enterText(find.byKey(const Key('password')), '1234');
      
        await tester.pumpAndSettle();

        //test
        expect(find.text('amandak'), findsOneWidget);
        expect(find.text('1234'), findsOneWidget);
        //expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Personal details page',
      (WidgetTester tester) async {
        //app.main();
        await tester.pumpWidget(const MaterialApp(home: PersonalDetails()));
        await tester.pumpAndSettle();
        //do
        await tester.enterText(find.byKey(const Key('Name input')), 'Amanda');
        await tester.enterText(find.byKey(const Key('Last Name input')), 'Khuzwayo');
        await tester.enterText(find.byKey(const Key('Email input')), 'ak@gmail.com');
        await tester.enterText(find.byKey(const Key('Cell input')), '0123456789');
        await tester.enterText(find.byKey(const Key('Address input')), '12 Somewhere Street, Anyplace');
      
        await tester.pumpAndSettle();

        //test
        expect(find.text('Amanda'), findsOneWidget);
        expect(find.text('Khuzwayo'), findsOneWidget);
        expect(find.text('ak@gmail.com'), findsOneWidget);
        expect(find.text('0123456789'), findsOneWidget);
        expect(find.text('12 Somewhere Street, Anyplace'), findsOneWidget);
        //expect(find.byType(ElevatedButton), findsOneWidget);
    });
    
    testWidgets('Qualifications details page',
      (WidgetTester tester) async {
        //app.main();
        await tester.pumpWidget(const MaterialApp(home: QualificationsDetails()));
        await tester.pumpAndSettle();
        //do
        await tester.enterText(find.byKey(const Key('Institution input')), 'University of Pretoria');
        await tester.enterText(find.byKey(const Key('Qualification input')), 'BSc Computer Science');
        //await tester.enterText(find.byKey(const Key('graduation')), '04/2024');
      
        await tester.pumpAndSettle();

        //test
        expect(find.text('University of Pretoria'), findsOneWidget);
        expect(find.text('BSc Computer Science'), findsOneWidget);
        //expect(find.text('04/2024'), findsOneWidget);
        //expect(find.byType(ElevatedButton), findsOneWidget);
    });

    
      testWidgets('Employment details page',
      (WidgetTester tester) async {
        //app.main();
        await tester.pumpWidget(const MaterialApp(home: EmploymentDetails()));
        await tester.pumpAndSettle();
        //do
        await tester.enterText(find.byKey(const Key('Company input')), 'Dynamic Visual Technologies');
        await tester.enterText(find.byKey(const Key('Job Title input')), 'Junior Software Developer');
        //await tester.enterText(find.byKey(const Key('Employment start')), '05/2024');
        //await tester.enterText(find.byKey(const Key('Employment end')), 'current');
      
        await tester.pumpAndSettle();

        //test
        expect(find.text('Dynamic Visual Technologies'), findsOneWidget);
        expect(find.text('Junior Software Developer'), findsOneWidget);
        //expect(find.text('05/2024'), findsOneWidget);
        //expect(find.text('current'), findsOneWidget);
        //expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('Skills page',
      (WidgetTester tester) async {
        //app.main();
        await tester.pumpWidget(const MaterialApp(home: SkillsForm()));
        await tester.pumpAndSettle();
        //do
        await tester.enterText(find.byKey(const Key('Skill1')), 'Web development');
        await tester.enterText(find.byKey(const Key('Skill2')), 'NoSQL Databases');
        await tester.enterText(find.byKey(const Key('Skill3')), 'Cloud management');

        //await tester.enterText(find.byKey(const Key('graduation')), '04/2024');
      
        await tester.pumpAndSettle();

        //test
        expect(find.text('Web development'), findsOneWidget);
        expect(find.text('NoSQL Databases'), findsOneWidget);
        expect(find.text('Cloud management'), findsOneWidget);
        //expect(find.text('04/2024'), findsOneWidget);
        //expect(find.byType(ElevatedButton), findsOneWidget);
    });
    
    testWidgets('References page',
      (WidgetTester tester) async {
        //app.main();
        await tester.pumpWidget(const MaterialApp(home: ReferencesForm()));
        await tester.pumpAndSettle();
        //do
        await tester.enterText(find.byKey(const Key('Name input')), 'Jane Doe');
        await tester.enterText(find.byKey(const Key('Job Title input')), 'Senior Software Engineer');
        await tester.enterText(find.byKey(const Key('Cell input')), '0123456789');
        await tester.enterText(find.byKey(const Key('Email input')), 'jd@gmail.com');

        //await tester.enterText(find.byKey(const Key('graduation')), '04/2024');
      
        await tester.pumpAndSettle();

        //test
        expect(find.text('Jane Doe'), findsOneWidget);
        expect(find.text('Senior Software Engineer'), findsOneWidget);
        expect(find.text('0123456789'), findsOneWidget);
        expect(find.text('jd@gmail.com'), findsOneWidget);
        //expect(find.text('04/2024'), findsOneWidget);
        //expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
    
}
