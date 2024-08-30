import 'package:flutter/material.dart';

import '../helpers/colors.dart';

class SchoolPage extends StatelessWidget {
  const SchoolPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 200,
          height: 50,
          child: MaterialButton(
            onPressed: () {
              Navigator.pushNamed(context, "/manage-students");
            },
            color: lightGlassBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),

            child: const Text(
              "Manage Students",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
