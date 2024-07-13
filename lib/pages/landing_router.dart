import 'package:flutter/material.dart';
import 'dart:convert' show jsonDecode;
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:my_quiz_ap/constants.dart' show apiUrl;
import 'package:my_quiz_ap/helpers/http_extensions.dart' show IsOk;
import 'package:my_quiz_ap/helpers/jwt/token_checker.dart';
import 'package:my_quiz_ap/helpers/utils.dart' show printInfo;
import 'package:my_quiz_ap/helpers/jwt/jwt.dart' show JWT, JWTR;
import 'package:http/http.dart' as http show Response, get;


/// This widget is used to redirect the user to the appropriate route
/// depending on the user's role
/// It appears when the app is launched or when the user logs out
///
/// It fetches the user data from the server
/// if the token is not found, no user is logged in
/// and the user is redirected to the auth page
///
/// if the token is found, checks Token with the server
/// the user is redirected to the appropriate route
class LandingRouter extends StatefulWidget {
  const LandingRouter({
    super.key,
    this.logout = false,
  });

  final bool logout;

  @override
  State<LandingRouter> createState() => _LandingRouterState();
}

class _LandingRouterState extends State<LandingRouter> {

  final JWT jwt = JWT();

  /// Fetches the user data from the server
  /// if the token is not found, no user is logged in
  /// and the user is redirected to the auth page
  ///
  /// if the token is found, checks Token with the server
  ///
  /// returns the user data if the token is valid
  Future<Map<String, dynamic>> getUserData() async {

    // read the token from the device
    String token = await jwt.read();

    // if the user logs out, delete the token and redirect to the auth page
    if (widget.logout) {
      await jwt.delete();
      JWTR jwtr = JWTR();
      jwtr.delete();
      redirectTo('/auth');
      return <String, dynamic>{'role': ''};
    }

    // if the token is not found, redirect to the auth page
    if (token.isEmpty) {
      redirectTo('/auth');
      return <String, dynamic>{'role': ''};
    }

    // check the token with the server
    Future<http.Response> fResponse() async => http.get(
        Uri.parse('$apiUrl/connection/checkToken'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': await jwt.read(),
        }
      );

    final http.Response response = await checkToken(fResponse);

    // if the response is successful, return the user data
    if (response.ok) {
      return jsonDecode(response.body);

    // if the response is not successful, return the error
    } else {
      return <String, dynamic>{
        'error': response.body,
      };
    }
  }

  /// Shortcuts the redirection to a route
  /// respecting the widget lifecycle
  void redirectTo(String route) {
    if (mounted) {
      Future.delayed(Duration.zero, () {
        Navigator.pushNamedAndRemoveUntil(context, route, (route) => false);
      });
    }
  }

  /// Redirects the [user] to the appropriate route
  /// depending on the [role]
  ///
  /// returns [true] if the [user] is redirected
  /// returns [false] if the [user] is not redirected
  bool redirectFromRole(String role) {
    if (role == 'admin') {
      redirectTo('/admin');
    } else if (role == 'teacher') {
      redirectTo('/teacher');
    } else if (role == 'student') {
      redirectTo('/student');
    } else {
      return false;
    }
    return true;
  }

  late Widget resetJwtBtn = ElevatedButton(
    onPressed: () async {
      await jwt.delete();
      printInfo("JWT Reset");
      setState(() {});
    },
    child: const Text("Reset JWT"),
  );

  Widget loadingError(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(error),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.9,

      child: FutureBuilder(
          future: getUserData(), // fetch the user data
          builder: (context, snapshot) {

            // if the snapshot has an error, return the error message
            if (snapshot.hasError) {
              return loadingError(snapshot.error.toString());

            // if the snapshot is done, check the role
            } else if (snapshot.connectionState == ConnectionState.done) {

                // if data contains an error, return the error message
                if (snapshot.data!['error'] != null) {
                  return loadingError(snapshot.data!['error']);

                // if the role is found, redirect the user
                } else {
                  final String role = snapshot.data!['role'] ?? '';
                  final bool hasRedirected = redirectFromRole(role);

                  // if the user is redirected, return an empty widget
                  return hasRedirected ?
                    const SizedBox.shrink()
                      :
                    // else return an error message
                    loadingError("Role not found");
                }


            } else {
                // if the snapshot is not done, return a loading spinner
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    strokeCap: StrokeCap.round,
                  ),
                );
            }
          }
      ),
    );
  }
}
