import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import 'package:my_quiz_ap/providers/student_provider.dart' show StudentProvider;

class StudentList extends StatefulWidget {
  const StudentList({super.key});

  @override
  State<StudentList> createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  late final StudentProvider _provider = Provider.of<StudentProvider>(context);

  // After
  Widget rowCell(
    String text, {
    FontWeight? fontWeight,
    double fontSize = 14,
  }) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text,
            style: TextStyle(
              color: Colors.white,
              fontSize: fontSize,
              fontWeight: fontWeight,
            )),
      );

  Widget firstRowCell(String text) =>
      rowCell(text, fontWeight: FontWeight.w700, fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height * 0.7,
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
              : Table(
                  border: TableBorder.all(color: Colors.white),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(2),
                  },
                  children: [
                    TableRow(
                      children: [
                        firstRowCell("Nom"),
                        firstRowCell("Prénom"),
                        firstRowCell("Email"),
                      ],
                    ),
                    for (var student in _provider.students)
                      TableRow(
                        children: [
                          rowCell(student.lastName),
                          rowCell(student.firstName),
                          rowCell(student.email),
                        ],
                      ),
                  ],
                ),
    );
  }
}
