import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/amplifyconfiguration.dart';

class LectureServices {
  List roles = [];
  // void initState() {
  //   super.initState();
  //   _configureAmplify();
  //   // _getLectureList();
  // }

  Future<void> _configureAmplify() async {
    // Add any Amplify plugins you want to use
    print('pocela konfiguracija');
    final authPlugin = AmplifyAuthCognito();
    final api = AmplifyAPI();
    await Amplify.addPlugins([authPlugin, api]);
    try {
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      safePrint(
          'Tried to reconfigure Amplify; this can occur when your app restarts on Android.');
    }
  }

  Future<void> signInUser() async {
    await _configureAmplify();
    try {
      final result = await Amplify.Auth.signIn(
        username: 'sblekic@pa.tech387.com', // email of user
        password: 'Password123!',
      );
      print('LOGINOVO SE KRALJ AMAR');
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  List _lectures = [];

  List get lectures {
    return [...lectures];
  }

  Future<void> getUserLectures() async {
    List lecture = [];

    print('funkcija pozvana');
    await signInUser();
    try {
      print('try pozvana');
      final restOperation = Amplify.API.get('/api/user/lectures',
          apiName: 'getUserLectures',
          queryParameters: {
            'paDate': 'Jan2023'
            // , ‘name’: ‘Flutter widgets’
          });
      final response = await restOperation.response;
      print('$response');
      Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());
      print('GET call succeeded: ${responseMap['lectures']}');
      List temp = [];
      responseMap['lectures'].forEach((lecture) {
        temp.addAll(lecture['roles']);
      });
      Set<String> set = Set<String>.from(temp);
      List<String> roles = set.toList();
      print(roles);
      var singleLecture;
      responseMap['lectures'].forEach((lecture) {
        singleLecture = lecture;
        _lectures.add(singleLecture);
        print(singleLecture);
      });
    } on ApiException catch (e) {
      print('GET call failed: ${e.message}');
    }
  }

  // Future<List<Map<String, dynamic>>> getUserLectures() async {
  //   await signInUser();
  //   try {
  //     final restOperation = Amplify.API.get('/api/user/lectures',
  //         apiName: 'getUserLectures',
  //         queryParameters: {
  //           'paDate': 'Jan2023'
  //           // , ‘name’: ‘Flutter widgets’
  //         });
  //     final response = await restOperation.response;
  //     Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());
  //     print('GET call succeeded: ${responseMap['lectures']}');
  //     List<Lecture> temp = [];
  //     responseMap['lectures'].forEach((lectureJson) {
  //       final lecture = Lecture.fromJson(lectureJson);
  //       temp.add(lecture);
  //     });
  //     Set<String> set = Set<String>.from(temp);
  //     List<String> roles = set.toList();
  //     print(roles);
  //     var oneLecture;
  //     responseMap['lectures'].forEach((lecture) {
  //       oneLecture = lecture;
  //       _lectures.add(oneLecture);
  //     });
  //     List<Map<String, dynamic>> lectures =
  //         _lectures.map((element) => element as Map<String, dynamic>).toList();
  //     return lectures;
  //   } on ApiException catch (e) {
  //     print('GET call failed: ${e.message}');
  //     return [];
  //   }
  // }

  Future<void> getLectureOrder() async {
    try {
      final restOperation = Amplify.API.get('/api/lectures/order',
          apiName: 'getLecturesOrder',
          queryParameters: {
            'paDate': 'Jan2023'
            // , ‘name’: ‘Flutter widgets’
          });
      final response = await restOperation.response;
      Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());
      print(
          'GET call succeeded: ${responseMap['lectureOrders']['productManager']}');
      print(jsonEncode(responseMap));
    } on ApiException catch (e) {
      print('GET call failed: ${e.message}');
    }
  }
}
