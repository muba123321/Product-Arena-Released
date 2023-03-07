import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:delta_team/amplifyconfiguration.dart';
import 'package:flutter/material.dart';

import 'dart:convert';


class UserLecturesScreen extends StatefulWidget {
  @override
  _UserLecturesScreenState createState() => _UserLecturesScreenState();
}

class _UserLecturesScreenState extends State<UserLecturesScreen> {
  List<String> userRoles = [];
  List<String> lista = [];
  late Future<dynamic> userDataFuture;

  bool isDone = false;
  List _lectures = [];
  List get lectures {
    return [..._lectures];
  }

  void initState() {
    super.initState();

    _configureAmplify();

    // userDataFuture = getUserLectures([]);
  }

  Future<void> _configureAmplify() async {
    // Add any Amplify plugins you want to use
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
    // await _configureAmplify();
    try {
      final result = await Amplify.Auth.signIn(
        username: 'semir.blekich@gmail.com',
        password: 'Password123!',
      );
      print('LOGINOVO SE KRALJ AMAR');
    } on AuthException catch (e) {
      safePrint(e.message);
    }
  }

  // Future<void> getUserLectures() async {
  //   await signInUser();
  //   try {
  //     final restOperation = Amplify.API.get(
  //       '/api/user/lectures',
  //       apiName: 'getUserLectures',
  //       queryParameters: {
  //         'paDate': 'Jan2023',
  //       },
  //     );

  //     final response = await restOperation.response;
  //     Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());
  //     print('GET call succeeded: ${responseMap['lectures']}');

  //     responseMap['lectures'].forEach((lecture) {
  //       roles.addAll(lecture['roles']);
  //     });

  //     Set<String> set = Set<String>.from(roles);
  //     setState(() {
  //       roles = set.toList();
  //       print(roles);
  //     });
  //   } on ApiException catch (e) {
  //     print('GET call failed: ${e.message}');
  //   }
  // }

  // Future<dynamic> getUserLectures(List lista) async {
  //   signInUser();
  //   try {
  //     final restOperation = Amplify.API.get('/api/user/lectures',
  //         apiName: 'getUserLectures',
  //         queryParameters: {
  //           'paDate': 'Jan2023'
  //           // , 'name': 'Flutter widgets'
  //         });
  //     final response = await restOperation.response;
  //     Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());
  //     List temp = [];
  //     responseMap['lectures'].forEach((lecture) {
  //       temp.addAll(lecture['roles']);
  //     });
  //     print(responseMap);
  //     Set<String> set = Set<String>.from(temp);
  //     List<String> roles = set.toList();
  //     print(roles);
  //     setState(() {
  //       userRoles = roles;
  //       lista = roles;
  //     });
  //   } on ApiException catch (e) {
  //     print('GET call failed: ${e.message}');
  //   }
  //   return lista;
  // }

  // Future<void> getUserLectures() async {
  //   await signInUser();
  //   try {
  //     final restOperation = Amplify.API.get('/api/user/lectures',
  //         apiName: 'getUserLectures',
  //         queryParameters: {
  //           'paDate': 'Jan2023'
  //           // , 'name': 'Flutter widgets'
  //         });
  //     final response = await restOperation.response;
  //     Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());
  //     List temp = [];
  //     responseMap['lectures'].forEach((lecture) {
  //       temp.addAll(lecture['roles']);
  //     });
  //     Set<String> set = Set<String>.from(temp);
  //     List<String> roles = set.toList();
  //     //print(roles);
  //     final restOperation2 = Amplify.API.get('/api/lectures/order',
  //         apiName: 'omegaLectureOrder',
  //         queryParameters: {
  //           'paDate': 'Jan2023'
  //           // , 'name': 'Flutter widgets'
  //         });
  //     final response2 = await restOperation2.response;
  //     Map<String, dynamic> orders =
  //         jsonDecode(response2.decodeBody())['lectureOrders'];
  //     // print(orders);
  //     Map<String, dynamic> lectures = {};
  //     roles.forEach((role) {
  //       lectures[role] = List<dynamic>.filled(
  //           (orders[role] as Map<String, dynamic>).length, 0);
  //     });
  //     responseMap['lectures'].forEach((lecture) {
  //       lecture['roles'].forEach((role) {
  //         //print(orders[role][lecture['name']]);
  //         lectures[role][orders[role][lecture['name']]] = lecture;
  //       });
  //     });
  //     print(lectures['fullstack']);
  //     // print('GET call succeeded: ${responseMap['lectures']}');
  //   } on ApiException catch (e) {
  //     print('GET call failed: $e');
  //   }
  // }

  Future<void> getUserLectures() async {
    await signInUser();
    try {
      final restOperation = Amplify.API.get(
        '/api/user/lectures',
        apiName: 'getUserLectures',
        headers: {
          'Access-Control-Request-Headers': 'access-control-allow-methods'
        },
        queryParameters: {
          'paDate': 'Jan2023'
          // , 'name': 'Flutter widgets'
        },
      );
      final response = await restOperation.response;
      Map<String, dynamic> responseMap = jsonDecode(response.decodeBody());
      /* List<dynamic> objects = (responseMap['lectures'] as List)
          .map((jsonObject) => Lecture.fromJson(jsonObject))
          .toList();

      //print(objects);
      int duration = objects[0].durationInSeconds;
      setState(() {
        lectures = List.from(objects);
      }); */

      List temp = [];
      responseMap['lectures'].forEach((lecture) {
        temp.addAll(lecture['roles']);
      });
      Set<String> set = Set<String>.from(temp);
      List<String> roles = set.toList();
      //print(roles);
      final restOperation2 = Amplify.API.get('/api/lectures/order',
          apiName: 'getLecturesOrder',
          queryParameters: {
            'paDate': 'Jan2023'
            // , 'name': 'Flutter widgets'
          });
      final response2 = await restOperation2.response;
      Map<String, dynamic> orders =
          jsonDecode(response2.decodeBody())['lectureOrders'];
      // print(orders);
      Map<String, dynamic> lectures = {};
      roles.forEach((role) {
        lectures[role] = List<dynamic>.filled(
            (orders[role] as Map<String, dynamic>).length, 0);
      });
      responseMap['lectures'].forEach((lecture) {
        lecture['roles'].forEach((role) {
          //print(orders[role][lecture['name']]);
          lectures[role][orders[role][lecture['name']]] = lecture;
        });
      });
      //print(lectures['fullstack']);
      // print('GET call succeeded: ${responseMap['lectures']}');

      var Lecture;
      responseMap['lectures'].forEach((lecture) {
        Lecture = lecture;
        _lectures.add(Lecture);
      });
      isDone = true;
      // notifyListeners();
    } on ApiException catch (e) {
      print('GET call failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: ElevatedButton(
          onPressed: getUserLectures,
          child: Text('a'),
        ),
      ),
      body: Container(
          child: isDone == true
              ? Text(lectures[0]['description'])
              : Text("No valid information")),
    );
  }
}