import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/features/auth/signup/provider/auth_provider_mobile.dart';
import 'package:delta_team/features/auth/signup/signup_mobile/screens/signupScreen_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:provider/provider.dart';

late MyEmail myEmail;

Widget createMobileSignupScreen() => ChangeNotifierProvider<MyEmail>(
      create: (context) {
        myEmail = MyEmail();
        return myEmail;
      },
      child: const MaterialApp(
        home: SignupScreenMobile(),
      ),
    );

@GenerateMocks([
  SignInResult,
  SignUpResult,
  AmplifyClass,
  BuildContext,
  SignOutResult,
  RestOperation,
  AWSHttpResponse
])
void main() {
  testWidgets('QA: Verify if a user can choose from drop dropdown filed.',
      (WidgetTester tester) async {
    await tester.pumpWidget(createMobileSignupScreen());
    await tester.pumpAndSettle();

    final dropDown = find.byKey(const ValueKey('statusKey'));
    await tester.tap(dropDown);
    await tester.pumpAndSettle();

    final status = find.text('Student').last;
    await tester.tap(status);
  });

  testWidgets(
      'QA: Verify if a user can not proceed without filling all the mandatory fields.',
      (WidgetTester tester) async {
    await tester.pumpWidget(createMobileSignupScreen());
    await tester.pumpAndSettle();

    final cyaButton = find.byKey(const ValueKey('createAccountKey'));
    await tester.ensureVisible(cyaButton);
    await tester.tap(cyaButton);
    await tester.pumpAndSettle();

    expect(find.text('Please fill the required field.'), findsNWidgets(7));
  });

  testWidgets(
      'QA: Verify the valid age of the user when the user wants to sign up.',
      (WidgetTester tester) async {
    await tester.pumpWidget(createMobileSignupScreen());
    await tester.pumpAndSettle();

    final birthDateField = find.byKey(const ValueKey('birthDateKey'));
    await tester.tap(birthDateField);
    await tester.enterText(birthDateField, '07/12/2056');
    await tester.pumpAndSettle();

    final cyaButton = find.byKey(const ValueKey('createAccountKey'));
    await tester.ensureVisible(cyaButton);
    await tester.tap(cyaButton);
    await tester.pumpAndSettle();

    expect(
        find.text('Please enter valid birth date (dd/mm/yy)'), findsOneWidget);
  });

  testWidgets(
      'QA:  Verify if the numbers and special characters are not allowed in the First and Last name.',
      (WidgetTester tester) async {
    await tester.pumpWidget(createMobileSignupScreen());
    await tester.pumpAndSettle();

    //name
    final nameField = find.byKey(const ValueKey('nameKey'));
    await tester.ensureVisible(nameField);
    await tester.tap(nameField);
    await tester.enterText(nameField, 'aco123');
    await tester.pumpAndSettle();

    //surname
    final surnameField = find.byKey(const ValueKey('surnameKey'));
    await tester.ensureVisible(surnameField);
    await tester.tap(surnameField);
    await tester.enterText(surnameField, 'ferhat1222');
    await tester.pumpAndSettle();

    final cyaButton = find.byKey(const ValueKey('createAccountKey'));
    await tester.ensureVisible(cyaButton);
    await tester.tap(cyaButton);
    await tester.pumpAndSettle();

    expect(find.text('Please enter valid name'), findsOneWidget);
    expect(find.text('Please enter valid surname'), findsOneWidget);
  });

  testWidgets(
      'QA: Verify if a user can sign-up successfully with all the mandatory details.',
      (WidgetTester tester) async {
    await tester.pumpWidget(createMobileSignupScreen());
    await tester.pumpAndSettle();

    //name
    final nameField = find.byKey(const ValueKey('nameKey'));
    await tester.pumpAndSettle();
    await tester.tap(nameField);
    await tester.pump();
    await tester.enterText(nameField, 'alen');

    //surname
    final surnameField = find.byKey(const ValueKey('surnameKey'));
    await tester.pumpAndSettle();
    await tester.tap(surnameField);
    await tester.pump();
    await tester.enterText(surnameField, 'islamovic');

    //birth date
    final birthDateField = find.byKey(const ValueKey('birthDateKey'));
    await tester.pumpAndSettle();
    await tester.tap(birthDateField);
    await tester.pump();
    await tester.enterText(birthDateField, '05/04/2006');

    //city
    final cityField = find.byKey(const ValueKey('cityKey'));
    await tester.pumpAndSettle();
    await tester.tap(cityField);
    await tester.pump();
    await tester.enterText(cityField, 'Berlin');

    //phone
    final phoneField = find.byKey(const ValueKey('phoneNumberKey'));
    await tester.pumpAndSettle();
    await tester.tap(phoneField);
    await tester.pump();
    await tester.enterText(phoneField, '+38761123456789');

    //email
    final emailField = find.byKey(const ValueKey('emailKey'));
    await tester.pumpAndSettle();
    await tester.tap(emailField);
    await tester.pump();
    await tester.enterText(emailField, 'vijaypratapica@otpku.com');

    //password
    final passwordField = find.byKey(const ValueKey('passwordKey'));
    await tester.pumpAndSettle();
    await tester.tap(passwordField);
    await tester.pump();
    await tester.enterText(passwordField, 'Imeiprezime1@');

    final cyaButton = find.byKey(const ValueKey('createAccountKey'));
    await tester.ensureVisible(cyaButton);
    await tester.tap(cyaButton);
    await tester.pumpAndSettle();

    expect(find.text('Please fill the required field.'), findsNothing);

    //expect(find.byType(ConfirmationContainers), findsOneWidget);

    // I got a verification email, but in Integration, test will be processed
  });

  testWidgets('QA: Verify if duplicate email address will not get assigned.',
      (WidgetTester tester) async {
    await tester.pumpWidget(createMobileSignupScreen());
    await tester.pumpAndSettle();

    //name
    final nameField = find.byKey(const ValueKey('nameKey'));
    await tester.pumpAndSettle();
    await tester.tap(nameField);
    await tester.pump();
    await tester.enterText(nameField, 'alen');

    //surname
    final surnameField = find.byKey(const ValueKey('surnameKey'));
    await tester.pumpAndSettle();
    await tester.tap(surnameField);
    await tester.pump();
    await tester.enterText(surnameField, 'islamovic');

    //birth date
    final birthDateField = find.byKey(const ValueKey('birthDateKey'));
    await tester.pumpAndSettle();
    await tester.tap(birthDateField);
    await tester.pump();
    await tester.enterText(birthDateField, '05/04/2006');

    //city
    final cityField = find.byKey(const ValueKey('cityKey'));
    await tester.pumpAndSettle();
    await tester.tap(cityField);
    await tester.pump();
    await tester.enterText(cityField, 'Berlin');

    //phone
    final phoneField = find.byKey(const ValueKey('phoneNumberKey'));
    await tester.pumpAndSettle();
    await tester.tap(phoneField);
    await tester.pump();
    await tester.enterText(phoneField, '+38761123456789');

    //email
    final emailField = find.byKey(const ValueKey('emailKey'));
    await tester.pumpAndSettle();
    await tester.tap(emailField);
    await tester.pump();
    await tester.enterText(emailField, 'vijaypratapica@otpku.com');

    //password
    final passwordField = find.byKey(const ValueKey('passwordKey'));
    await tester.pumpAndSettle();
    await tester.tap(passwordField);
    await tester.pump();
    await tester.enterText(passwordField, 'Imeiprezime1@');

    final cyaButton = find.byKey(const ValueKey('createAccountKey'));
    await tester.ensureVisible(cyaButton);
    await tester.tap(cyaButton);
    await tester.pumpAndSettle();

    expect(find.text('Email already exists'), findsOneWidget);
  });
}
