import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_quiz_ap/helpers/colors.dart' show electricBlue, lightGlassBlue;
import 'package:my_quiz_ap/helpers/quiz_creation/generate_quiz_pdf_web.dart';
import 'package:my_quiz_ap/providers/layout_provider.dart';
import 'package:my_quiz_ap/providers/quiz_creation_data.dart';
import 'package:provider/provider.dart';

class GeneratePdfQuizBtnWeb extends StatefulWidget {
  const GeneratePdfQuizBtnWeb({super.key});

  @override
  State<GeneratePdfQuizBtnWeb> createState() => _GeneratePdfQuizBtnWebState();
}

class _GeneratePdfQuizBtnWebState extends State<GeneratePdfQuizBtnWeb> with SingleTickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  )..addListener(() {
    setState(() {});
  })..repeat(reverse: true);

  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.easeInOut,
  );

  late final QuizCreationData _quizProvider = Provider.of<QuizCreationData>(context, listen: false);
  late final LayoutProvider _layoutProvider = Provider.of<LayoutProvider>(context, listen: false);

  Uint8List? _fileBytes;
  bool _loading = false;

  Future<void> getFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(allowedExtensions: ['pdf'], type: FileType.custom, allowMultiple: false);

    if (result != null) {
      final fileBytes = result.files.single.bytes;
      if (fileBytes != null) {
        setState(() {
          _fileBytes = fileBytes;
        });
      }
    } else {
      if (mounted) {
        snackBar("Aucun fichier sélectionné");
      }
    }
  }

  void snackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: MaterialButton(
        onPressed: () async {
          if (_quizProvider.selectedSubject == null) {
            snackBar("Veuillez sélectionner une matière");
            _layoutProvider.scrollToTop();
            return;
          }

          if (_quizProvider.selectedClasses.isEmpty) {
            snackBar("Veuillez sélectionner au moins une classe");
            _layoutProvider.scrollToTop();
            return;
          }

          if (_quizProvider.quizName.isEmpty) {
            snackBar("Veuillez donner un nom au quiz");
            _layoutProvider.scrollToTop();
            return;
          }

          await getFile();

          if (_fileBytes != null) {
            setState(() {
              _loading = true;
            });

            final int quizId = await generateQuizPdfWeb(
              fileBytes: _fileBytes!,
              matiere: _quizProvider.selectedSubject!['name'],
              name: _quizProvider.quizName,
              userId: _quizProvider.userId,
              classes: _quizProvider.selectedClasses.map((e) => e['id'] as int).toList(),
            );

            if (quizId != -1 && context.mounted) {
              Navigator.pushNamedAndRemoveUntil(context, "/modify-quiz", (route) => false, arguments: quizId);
              _fileBytes = null;
            } else {
              if (context.mounted) {
                snackBar("Une erreur s'est produite lors de la création du quiz, veuillez réessayer");
                _fileBytes = null;
              }
            }

            setState(() {
              _loading = false;
            });
          }
        },
        color: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.zero,
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                lightGlassBlue,
                electricBlue,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: _loading
                ? SizedBox(
                    width: 200,
                    height: 40,
                    child: SvgPicture.asset(
                      'assets/icons/icon_ai.svg',
                      width: 20,
                      height: 20,
                      colorFilter: ColorFilter.mode(
                          Color.lerp(Colors.white, Colors.white30, _animation.value)!, BlendMode.srcIn),
                    ),
                  )
                : RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        height: 1.5,
                        fontFamily: 'QuickSand',
                        fontWeight: FontWeight.w600,
                      ),
                      children: [
                        const TextSpan(
                          text: "Créer à partir d'un PDF",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        WidgetSpan(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: SvgPicture.asset(
                              'assets/icons/icon_ai.svg',
                              width: 20,
                              height: 20,
                              colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}