import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/colors.dart' show lightGlassBlue;
import 'package:my_quiz_ap/helpers/send_student_csv.dart';
import 'package:my_quiz_ap/helpers/utils.dart';

class AddStudentsPage extends StatefulWidget {
  const AddStudentsPage({super.key});

  @override
  State<AddStudentsPage> createState() => _AddStudentsPageState();
}

class _AddStudentsPageState extends State<AddStudentsPage> {

  File? _file;
  List<dynamic> _result = [];

  getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final file = File(result.files.single.path!);
      _file = file;
      setState(() {});
    } else {

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please select file'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            height: 50,
            child: MaterialButton(
              onPressed: () {
                getFile();
              },
              color: lightGlassBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),

              child: const Text(
                "Add students from CSV",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  height: 1.25,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          if (_file != null) ...[
            const SizedBox(height: 20),
            Text(
              "File selected: ${_file!.uri.pathSegments.last}",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),

            SizedBox(
              width: 200,
              height: 50,
              child: MaterialButton(
                onPressed: () async {
                  _result = await sendStudentCsv(_file!);
                  setState(() {});
                },
                color: lightGlassBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),

                child: const Text(
                  "Add students",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    height: 1.25,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Text(
              _result.map((key) => key.toString()).join('\n'),
              style: TextStyle(
                color: _result.isEmpty ? Colors.red : Colors.black,
                fontSize: 16,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
