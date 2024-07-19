import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_quiz_ap/components/sized_block.dart' show SizedBlock;
import 'dart:convert' show jsonDecode;

class AdminPage extends StatefulWidget {
  const AdminPage({
    super.key,
  });

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  List<Map<String, dynamic>> _data = [];

  Future<void> getSchools() async {
    http.Response response =
        await http.get(Uri.parse('http://localhost:3000/admin/listSchools'));
    String body = response.body;

    // If the server returns a JSON object
    List<dynamic> jsonData = jsonDecode(body);
    List<Map<String, dynamic>> data = jsonData.cast<Map<String, dynamic>>();
    setState(() {
      _data = data;
    });
  }

  @override
  void initState() {
    super.initState();
    getSchools();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.4;
    double height = MediaQuery.of(context).size.height * 0.1;

    return Center(
        child: Column(
      children: [
        SizedBlock(
          height: height,
          width: width,
          clickEvent: () {},
          child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display the list of schools
                Text("List of schools:"),
              ]),
        ),
        Column(
            children: _data.map((school) {
          return SizedBlock(
            height: height,
            width: width,
            clickEvent: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(school["nom"]),
                Text(school["email"]),
              ],
            ),
          );
        }).toList()),
      ],
    ));
  }
}
