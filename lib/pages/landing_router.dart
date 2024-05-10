import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:my_quiz_ap/constants.dart';
import 'package:my_quiz_ap/helpers/http_extensions.dart';
import 'package:my_quiz_ap/helpers/utils.dart';
import 'package:my_quiz_ap/pages/auth/store_auth_token.dart';
import 'package:http/http.dart' as http;

class LandingRouter extends StatefulWidget {
  const LandingRouter({super.key});

  @override
  State<LandingRouter> createState() => _LandingRouterState();
}

class _LandingRouterState extends State<LandingRouter> {

  Future<Map<String, dynamic>> getUserData() async {

    final String token = await AuthToken.read();

    final http.Response response = await http.get(
      Uri.parse('$apiUrl/connection/checkToken'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': token,
      }
    );

    if (response.ok) {
      return jsonDecode(response.body);
    } else {
      return <String, dynamic>{
        'error': response.body,
      };
    }
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.9,
      child: FutureBuilder(
          future: getUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data!['error'] != null) {
                return Center(
                  child: Text(snapshot.data!['error']),
                );
              } else {
                final String role = snapshot.data!['role'];
                if (role == 'admin') {
                  Navigator.pushNamed(context, '/admin');
                } else if (role == 'teacher') {
                  Navigator.pushNamed(context, '/teacher');
                } else if (role == 'student') {
                  Navigator.pushNamed(context, '/student');
                } else {
                  return const Center(
                    child: Text("An error occurred, please try again later"),
                  );
                }
                return const SizedBox.shrink();
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }
      ),
    );
  }
}
