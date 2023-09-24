import 'package:ai_cv_generator/models/user/Qualification.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:ai_cv_generator/pages/screens/homeRedo.dart';
import 'package:ai_cv_generator/pages/screens/login.dart';
import 'package:ai_cv_generator/pages/util/strings.dart';
import 'package:ai_cv_generator/pages/widgets/employment.dart';
import 'package:ai_cv_generator/pages/widgets/personaldetails.dart';
import 'package:ai_cv_generator/pages/widgets/qualifications.dart';
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
      expect(find.byKey(const Key('register')), findsOneWidget);
    }
  );

   /* testWidgets('Login', (WidgetTester tester) async {
        //app.main();
        await tester.pumpWidget(MaterialApp(
          routes: {
            '/home': (context) => const Home(), // Ensure the '/home' route leads to the home page widget.
          },
          home: const Login(),
        ));
  
        await tester.pumpAndSettle();
        //do
        await tester.enterText(find.byKey(const Key('username')), 'amandak');
        await tester.enterText(find.byKey(const Key('password')), '1234');

        await tester.pumpAndSettle();
        //test
        expect(find.text('amandak'), findsOneWidget);
        expect(find.text('1234'), findsOneWidget);
        expect(find.byKey(const Key('login')), findsOneWidget);
        expect(find.byKey(const Key('create_account')), findsOneWidget);
        expect(find.text('Forgot your password?'), findsOneWidget);


        await tester.tap(find.byKey(const Key('login')));
        await tester.pumpAndSettle();

        expect(find.byType(Home), findsOneWidget);
    });

    testWidgets('Survey: Personal Details', (WidgetTester tester) async {
      Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); 

      await tester.pumpWidget( MaterialApp(home: PersonalDetailsForm()));

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

    testWidgets('Survey: Employment Details', (WidgetTester tester) async {
      Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak');
      await tester.pumpWidget( MaterialApp(home: EmploymentDetailsForm()));
      //await tester.pumpAndSettle();

      //debugDumpApp();
      // Verify that the page is initially empty
      expect(find.text("No Work Experience..."), findsOneWidget);

    });

  //Reimpliment
    testWidgets('Survey: Qualification Details', (WidgetTester tester) async {
      Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); // Replace AdjustedModel with your actual model class
      
    // Build our widget and trigger a frame.
      await tester.pumpWidget( MaterialApp(home: QualificationsDetailsForm()));

      expect(find.text(StringsQualifications.appsubHeadingTitle), findsOneWidget);
      expect(find.text('Institution'), findsOneWidget);
      expect(find.text('Qualification'), findsOneWidget);
      expect(find.text('Start Date'), findsOneWidget);
      expect(find.text('End Date'), findsOneWidget);
    });*/
  });
}
