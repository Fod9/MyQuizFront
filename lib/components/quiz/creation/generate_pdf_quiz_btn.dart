import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/quiz/generate_quiz_pdf.dart';
import 'package:my_quiz_ap/providers/quiz_creation_data.dart';
import 'package:provider/provider.dart';

import '../../../helpers/colors.dart';

class GeneratePdfQuizBtn extends StatefulWidget {
  const GeneratePdfQuizBtn({super.key});

  @override
  State<GeneratePdfQuizBtn> createState() => _GeneratePdfQuizBtnState();
}

class _GeneratePdfQuizBtnState extends State<GeneratePdfQuizBtn> {

  late final QuizCreationData _quizProvider = Provider.of<QuizCreationData>(context, listen: false);

  File? _file;
  bool _loading = false;

  Future<void> getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowedExtensions: ['pdf'], type: FileType.custom, allowMultiple: false);

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
    return SizedBox(
      width: 200,
      height: 50,
      child: MaterialButton(
        onPressed: () async {
          await getFile();
          
          if (_file != null) {
            setState(() {
              _loading = true;
            });

            final int quizId = await generateQuizPdf(
              file: _file!,
              matiere: _quizProvider.selectedSubject!['name'],
              name: _quizProvider.quizName,
              userId: _quizProvider.userId,
              classes: _quizProvider.selectedClasses.map((e) => e['id'] as int).toList(),
            );

            if (quizId != -1) {
              Navigator.pushNamedAndRemoveUntil(context, "/modify-quiz", (route) => false, arguments: quizId);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('An error occurred while generating the quiz'),
              ));
            }

            setState(() {
              _loading = false;
            });
          }
        },
        color: lightGlassBlue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),

        child: _loading ?
        const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ) :
        const Text(
          "Sélectionner un fichier PDF",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
