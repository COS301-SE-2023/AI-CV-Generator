import 'package:ai_cv_generator/pages/screens/login.dart';
import 'package:ai_cv_generator/pages/widgets/personaldetails.dart';
import 'package:ai_cv_generator/pages/widgets/qualifications.dart';
import 'package:ai_cv_generator/pages/widgets/references.dart';
import 'package:ai_cv_generator/pages/widgets/skills.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';


class MockNavigatorObserver extends Mock implements NavigatorObserver {}

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
 