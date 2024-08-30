import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/students/add_student_from_csv.dart';

class ManageStudentsPage extends StatefulWidget {
  const ManageStudentsPage({super.key});

  @override
  State<ManageStudentsPage> createState() => _ManageStudentsPageState();
}

class _ManageStudentsPageState extends State<ManageStudentsPage> {

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: const Column(
        children: [
          AddStudentFromCsv(),

        ],
      )
    );
  }
}
