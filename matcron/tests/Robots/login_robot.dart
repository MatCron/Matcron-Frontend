import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

class LoginRobot {
  final WidgetTester tester;

  LoginRobot(this.tester);

  // Locators
  Finder get emailField => find.byType(TextField).at(0);
  Finder get passwordField => find.byType(TextField).at(1);
  Finder get signInButton => find.byType(ElevatedButton);
  Finder get errorMessage => find.textContaining('Error:');
  Finder get forgotPassword => find.text('Forgot Password?');
  Finder get signUpLink => find.text('Sign Up');
  // Finder get welcomeText => find.text('Welcome Back!');

  // Actions
  Future<void> enterEmail(String email) async {
    await tester.enterText(emailField, email);
    await tester.pumpAndSettle();
  }

  Future<void> enterPassword(String password) async {
    await tester.enterText(passwordField, password);
    await tester.pumpAndSettle();
  }

  Future<void> tapSignInButton() async {
    await tester.tap(signInButton);
    await tester.pumpAndSettle();
  }

  Future<void> tapForgotPassword() async {
    await tester.tap(forgotPassword);
    await tester.pumpAndSettle();
  }

  Future<void> tapSignUpLink() async {
    await tester.tap(signUpLink);
    await tester.pumpAndSettle();
  }

  // Assertions
  Future<void> verifyErrorMessage(String expectedMessage) async {
    expect(find.text(expectedMessage), findsOneWidget);
  }

  // Future<void> verifyWelcomeText() async {
  //   expect(welcomeText, findsOneWidget);
  // }

  
}
