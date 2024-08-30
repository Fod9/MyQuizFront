import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/colors.dart';
import 'package:my_quiz_ap/providers/student_provider.dart' show Student, StudentProvider;
import 'package:provider/provider.dart' show Provider;

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  late final StudentProvider _provider = Provider.of<StudentProvider>(context);

  DataCell studentDataCell(String text, Student student) {
    return DataCell(
        Text(text, style: const TextStyle(color: Colors.white)),
        onTap: () => _provider.selectStudent(student),
    );
  }

  DataColumn studentDataColumn(String text) {
    return DataColumn(
        label: Text(text,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold
            )
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.7,
        maxWidth: 800,
      ),
      child: _provider.isStudentListLoading
          ? const Center(
        child: SizedBox(
          width: 50,
          height: 50,
          child: Padding(
            padding: EdgeInsets.all(10),
            child: CircularProgressIndicator(
              color: Colors.white,
              strokeCap: StrokeCap.round,
            ),
          ),
        ),
      )
          : _provider.students.isEmpty
          ? const Center(child: Text('No students found'))
          : SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 30,
                columns: [
                  studentDataColumn(''),
                  studentDataColumn('Nom'),
                  studentDataColumn('Prénom'),
                  studentDataColumn('Email'),
                ],
                rows: _provider.students.map((student) {
                  return DataRow(
                    onLongPress: () => _provider.selectStudent(student),
                    selected: student.selected,
                    color: WidgetStateProperty.all<Color>( student.selected ?
                      lightGlassBlue : Colors.transparent
                    ),
                    cells: [
                      DataCell(
                        SizedBox(
                          width: 5,
                          child: Checkbox(
                            value: student.selected,
                            onChanged: (value) => _provider.selectStudent(student),
                            fillColor: WidgetStateProperty.all<Color>(Colors.white),
                            overlayColor: WidgetStateProperty.all<Color>(electricBlue),
                            side: const BorderSide(color: electricBlue, width: 2),
                            checkColor: electricBlue,
                          ),
                        ),
                      ),
                      studentDataCell(student.lastName, student),
                      studentDataCell(student.firstName, student),
                      studentDataCell(student.email, student),
                    ],
                  );
                }).toList(),
              ),
            ),
    );
  }
}