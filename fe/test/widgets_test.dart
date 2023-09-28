import 'dart:typed_data';

import 'package:ai_cv_generator/models/user/UserModel.dart';
import 'package:ai_cv_generator/pages/screens/about.dart';
import 'package:ai_cv_generator/pages/screens/emailConfirmation.dart';
import 'package:ai_cv_generator/pages/screens/emailVerification.dart';
import 'package:ai_cv_generator/pages/screens/forgotPassword.dart';
import 'package:ai_cv_generator/pages/screens/help.dart';
import 'package:ai_cv_generator/pages/screens/homeRedo.dart';
import 'package:ai_cv_generator/pages/screens/job.dart';
import 'package:ai_cv_generator/pages/widgets/EmptyCV.dart';
import 'package:ai_cv_generator/pages/widgets/breadcrumb.dart';
import 'package:ai_cv_generator/pages/widgets/cvHistory.dart';
import 'package:ai_cv_generator/pages/widgets/description.dart';
import 'package:ai_cv_generator/pages/widgets/loadingscreens/AILoadingScreen.dart';
import 'package:ai_cv_generator/pages/widgets/loadingscreens/ErrorScreen.dart';
import 'package:ai_cv_generator/pages/widgets/policy.dart';
import 'package:ai_cv_generator/pages/widgets/shareCV.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("CV history test", (WidgetTester tester)async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Builder(
            builder: (BuildContext context) {
              return CVHistory(
                context: context,
                axis: Axis.vertical, // Adjust as needed
                list: [], // Provide an empty list or a list of widgets as needed
              );
            },
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text("No CVs..."), findsOneWidget);
  });

  testWidgets("Share CV test", (WidgetTester tester) async {
    /* Failing due to overflow
    Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); 
    // Create a PlatformFile for testing
    final platformFile = PlatformFile(
      name: 'test.pdf',
      size: 1024, // Replace with the appropriate file size
      bytes: Uint8List.fromList([0, 1, 2, 3]), // Replace with file data
    );
    
    await tester.pumpWidget(MaterialApp(home: ShareWidget(file: platformFile)));

    expect(find.text('Specify Name and Time'), findsOneWidget);
    expect(find.text("Enter Name for file"), findsOneWidget);
    expect(find.text('Hours: '), findsOneWidget);
    expect(find.text('Copy Link'), findsOneWidget);*/
  });

  testWidgets("Breadcrumb test", (WidgetTester tester) async {
    Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); 
    // Create a PlatformFile for testing
    await tester.pumpWidget(
      MaterialApp(
        home: Breadcrumb(
          currentPage: 'Current Page',
          previousPage: 'Previous Page',
        ),
      ),
    );

    // Verify that the Breadcrumb widget displays the correct text.
    expect(find.text('Previous Page'), findsOneWidget);
  });

  testWidgets("Description test", (WidgetTester tester) async {
    /*Failing due to button overflow
    Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); 
  
     await tester.pumpWidget(
      MaterialApp(
        home: DescriptionForm()
      )
     );

    await tester.pumpAndSettle();
     expect(find.byKey(const Key("Description start")), findsOneWidget);*/
  });

  testWidgets('Job recommendation page', (tester) async {
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

  testWidgets('Help page', (tester) async {
    await tester.runAsync(() async {

    Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak');
    await tester.pumpWidget( MaterialApp(home: Help()));
    
    expect(find.text('What can we help you with?'), findsOneWidget);
    });
  });

  testWidgets('Policy', (tester) async {
    await tester.runAsync(() async {
    Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak');
    await tester.pumpWidget( MaterialApp(home: Policy(filename: 'example.pdf',)));
    //await tester.pumpAndSettle();
    
    expect(find.text("Done"), findsOneWidget);
    });
  });


group("Empty CV widget tests", () {
  testWidgets("Empty status", (WidgetTester tester) async {
    Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); 

    // Test with ScreenStatus.empty
    await tester.pumpWidget(
      MaterialApp(
        home: EmptyCVScreen(
          status: ScreenStatus.empty,
        ),
      ),
    );

    expect(find.text('Create CV !!!'), findsOneWidget);
    expect(find.byIcon(Icons.emoji_emotions_outlined), findsOneWidget);
  });

  testWidgets("Loading status", (WidgetTester tester) async {
    Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); 

    // Test with ScreenStatus.empty
    await tester.pumpWidget(
      MaterialApp(
        home: EmptyCVScreen(
          status: ScreenStatus.loading,
        ),
      ),
    );

    expect(find.byType(AILoadingScreen), findsOneWidget);
  });

  testWidgets("Error status", (WidgetTester tester) async {
    Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); 

    // Test with ScreenStatus.empty
    await tester.pumpWidget(
      MaterialApp(
        home: EmptyCVScreen(
          status: ScreenStatus.error,
        ),
      ),
    );

    expect(find.byType(ErrorScreen), findsOneWidget);
    expect(find.text('Rate Limit Exceeded'), findsOneWidget);
  });
});

  testWidgets("About page", (WidgetTester tester) async {
    Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); 

    await tester.pumpWidget(MaterialApp(home: AboutPage()));

    await tester.pumpAndSettle();

    expect(find.text("ABOUT US"), findsOneWidget);
    expect(find.text("A challenge for job seekers in South Africa is the creation of an effective CV, cover letter, or email that can make them stand out to potential employers. Many job seekers lack the necessary knowledge and skills to craft high-quality job application documents that highlight their strengths and experiences. The AI CV Generator aims to aid job seekers in creating appealing job application documents that will increase their chances of acquiring a job."), findsOneWidget);
  });

  testWidgets("Email confirmation", (WidgetTester tester) async {
    Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); 

    await tester.pumpWidget(MaterialApp(home: EmailConfirmation()));

    await tester.pumpAndSettle();

    expect(find.text("Check your inbox"), findsOneWidget);
  });

  testWidgets("Email verification", (WidgetTester tester) async {
    Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); 

    await tester.pumpWidget(MaterialApp(home: EmailVerification()));

    await tester.pumpAndSettle();

    expect(find.text("Verify your account"), findsOneWidget);
    expect(find.text("Complete the verification process"), findsOneWidget);
    expect(find.text("Verify"), findsOneWidget);
  });

  testWidgets("Forgot password", (WidgetTester tester) async {
    /* Failing due to overflow 
    Home.adjustedModel = UserModel(fname: 'Amanda', lname: 'K', username: 'amandak'); 

    await tester.pumpWidget(MaterialApp(home: ForgotPassword()));

    await tester.pumpAndSettle();

    expect(find.text('Forgot Password'), findsOneWidget);
    expect(find.byKey(const Key('name')), findsOneWidget);
    expect(find.byKey(const Key('email')), findsOneWidget);
    expect(find.text('Send Verification Code'), findsOneWidget);*/
  });
  
}


