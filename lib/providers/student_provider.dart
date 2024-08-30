import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/students/get_student_list.dart';

class StudentProvider with ChangeNotifier {

  StudentProvider() {
    fetchStudentList();
  }

  final List<Student> _students = [];
  bool _isStudentListLoading = false;

  List<Student> get students => _students;
  bool get isStudentListLoading => _isStudentListLoading;

  void fetchStudentList() async {
    _isStudentListLoading = true;
    notifyListeners();

    final List<dynamic> rawStudentList = await getStudentList();

    List<Student> students = [];

    for (var student in rawStudentList) {
      students.add(Student(
        firstName: student['prenom'],
        lastName: student['nom'],
        email: student['email'],
      ));
    }

    _students.clear();
    _students.addAll(students);

    _isStudentListLoading = false;
    notifyListeners();
  }

  void addAllStudents(List<Student> students) {
    _students.addAll(students);
    notifyListeners();
  }

  void removeStudent(Student student) {
    _students.remove(student);
    notifyListeners();
  }
}

class Student {

  const Student({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  final String firstName;
  final String lastName;
  final String email;

  @override
  String toString() {
    return 'Student{firstName: $firstName, lastName: $lastName, email: $email}';
  }
}