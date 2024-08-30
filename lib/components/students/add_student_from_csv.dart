import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/colors.dart' show lightGlassBlue;
import 'package:my_quiz_ap/helpers/utils.dart';
import 'package:my_quiz_ap/providers/student_provider.dart';
import 'package:provider/provider.dart';

class AddStudentFromCsv extends StatefulWidget {
  const AddStudentFromCsv({super.key});

  @override
  State<AddStudentFromCsv> createState() => _AddStudentFromCsvState();
}

class _AddStudentFromCsvState extends State<AddStudentFromCsv> {

  File? _file;
  late final StudentProvider _provider = Provider.of<StudentProvider>(context, listen: false);

  getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      final file = File(result.files.single.path!);
      setState(() {
        _file = file;
      });
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
    return Column(
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
                printOrder("Sending file");
                _provider.addStudentFromCsv(_file);
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
        ],
      ],
    );
  }
}
