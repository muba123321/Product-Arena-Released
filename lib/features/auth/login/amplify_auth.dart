import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/amplifyconfiguration.dart';
import 'package:flutter/material.dart';

import 'package:riverpod_extension/riverpod_extension.dart';

class AuthenticationProvider with ChangeNotifier {
  String errorMessage = '';
  bool isSignInComplete = false;
  bool isLoading = false;

  Future<void> _configureAmplify() async {
    try {
      // amplify plugins
      final apiPlugin = AmplifyAPI();
      final authPlugin = AmplifyAuthCognito();
      // add Amplify plugins
      await Amplify.addPlugins([apiPlugin, authPlugin]);
      await Amplify.configure(amplifyconfig);
    } catch (e) {
      safePrint('An error occurred configuring Amplify: $e');
    }
  }

  Future<void> signIn(
    email,
    password,
    BuildContext context,
  ) async {
    isLoading = true;
    notifyListeners();
    await _configureAmplify();
    try {
      final result =
          await Amplify.Auth.signIn(username: email, password: password);
      if (result.isSignedIn) {
        isSignInComplete = true;
      } else {
        errorMessage = 'Sign in failed';
      }
    } on AuthException catch (e) {
      errorMessage = e.message;
    } on HttpException catch (e) {
      final response = e.response;
      if (response.statusCode == 400) {
        errorMessage = 'Please enter a valid email or password';
      } else {
        errorMessage = 'Sign in failed';
      }
    }

    isLoading = false;
    notifyListeners();
  }
}

Future<void> signOutCurrentUser(
  email,
  password,
  BuildContext context,
) async {
  try {
    await Amplify.Auth.signOut();
  } on AuthException catch (e) {
    print(e.message);
  }
}
