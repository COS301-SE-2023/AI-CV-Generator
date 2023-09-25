import 'package:ai_cv_generator/models/user/Qualification.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:ai_cv_generator/pages/screens/homeRedo.dart';
import 'package:ai_cv_generator/pages/screens/login.dart';
import 'package:ai_cv_generator/pages/util/strings.dart';
import 'package:ai_cv_generator/pages/widgets/employment.dart';
import 'package:ai_cv_generator/pages/widgets/personaldetails.dart';
import 'package:ai_cv_generator/pages/widgets/qualifications.dart';
import 'package:ai_cv_generator/pages/widgets/referencesForm.dart';
import 'package:ai_cv_generator/pages/widgets/skillsForm.dart';
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

  group('end-to-end test2', () {
    /*
    //Passing
    testWidgets('Register Test', (tester) async {
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
    }
  );

  testWidgets('Login', (WidgetTester tester) async {
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


    //await tester.tap(find.text('Login'));
    //await tester.pumpAndSettle();

    //expect(find.byType(HomeTestWidget), findsOneWidget);
  });

   testWidgets('Survey: Personal Details', (WidgetTester tester) async {
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

    testWidgets('Survey: Qualification Details', (WidgetTester tester) async {
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

    testWidgets('Survey: Employment Details', (WidgetTester tester) async {
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

    testWidgets('Survey: References Details', (WidgetTester tester) async {
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
    */

    testWidgets('Survey: Skills Details', (WidgetTester tester) async {
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

  });
}
