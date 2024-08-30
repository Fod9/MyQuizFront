import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/students/add_student_from_csv.dart';
import 'package:my_quiz_ap/components/students/delete_students_button.dart';
import 'package:my_quiz_ap/components/students/student_list.dart';
import 'package:my_quiz_ap/providers/student_provider.dart';
import 'package:provider/provider.dart';

class ManageStudentsPage extends StatefulWidget {
  const ManageStudentsPage({super.key});

  @override
  State<ManageStudentsPage> createState() => _ManageStudentsPageState();
}

class _ManageStudentsPageState extends State<ManageStudentsPage> {

  final List<dynamic> studentList = [];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StudentProvider>(
      create: (context) => StudentProvider(),
      child: Consumer<StudentProvider>(
        builder: (context, provider, child) {
          return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  const AddStudentFromCsv(),
                  const SizedBox(height: 24),
                  if (provider.hasSelectedStudents) const DeleteStudentsButton(),
                  const SizedBox(height: 24),
                  const StudentList(),
                ],
              )
          );
        },
      ),
    );
  }
}