import 'package:ai_cv_generator/pages/screens/Register.dart';
import 'package:ai_cv_generator/pages/employment2.dart';
import 'package:ai_cv_generator/pages/screens/home.dart';
import 'package:ai_cv_generator/pages/screens/login.dart';
import 'package:ai_cv_generator/pages/screens/Register.dart';
import 'package:ai_cv_generator/pages/personaldetails2.dart';
import 'package:ai_cv_generator/pages/screens/profile.dart';
import 'package:ai_cv_generator/pages/qualifications2.dart';
import 'package:ai_cv_generator/pages/references2.dart';
import 'package:ai_cv_generator/pages/skills2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:ai_cv_generator/main.dart' as app;


void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
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
        await tester.pumpWidget(const MaterialApp(home: PersonalDetailsForm()));
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
        await tester.pumpWidget(const MaterialApp(home: QualificationsDetailsForm()));
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
        await tester.pumpWidget(const MaterialApp(home: EmploymentDetailsForm()));
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

    /*testWidgets('Profile page',
      (WidgetTester tester) async {
        //app.main();
        await tester.pumpWidget(const MaterialApp(home: Profile()));
        await tester.pumpAndSettle();
        //do
        await tester.enterText(find.byKey(const Key('description')), 'Final year BSc Computer Science student with experience in small-scale software engineering projects');
        await tester.pumpAndSettle();

        //test
        expect(find.text('Final year BSc Computer Science student with experience in small-scale software engineering projects'), findsOneWidget);
        
    });*/
    /* Home page*/
  });     
}
 