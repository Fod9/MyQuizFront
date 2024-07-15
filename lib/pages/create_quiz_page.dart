import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/creation/end_validation/create_quiz_button.dart' show CreateQuizButton;
import 'package:my_quiz_ap/components/Quiz/creation/questions/questions_section.dart' show QuestionsSection;
import 'package:my_quiz_ap/components/Quiz/creation/quiz_name_input.dart' show QuizNameInput;
import 'package:my_quiz_ap/components/Quiz/creation/select_subject_class_button.dart' show SelectSubjectClassButton;
import 'package:my_quiz_ap/components/full_page_loading.dart' show FullPageLoading;
import 'package:my_quiz_ap/helpers/get_user_info.dart' show getUserInfo;
import 'package:my_quiz_ap/helpers/quiz_creation/get_associate.dart' show getAssociate;
import 'package:my_quiz_ap/helpers/utils.dart' show printError;
import 'package:my_quiz_ap/providers/layout_provider.dart' show LayoutProvider;
import 'package:my_quiz_ap/providers/quiz_creation_data.dart' show QuizCreationData;
import 'package:provider/provider.dart' show ChangeNotifierProvider, Consumer, Provider;
import 'package:my_quiz_ap/helpers/quiz/get_quiz.dart' show getQuiz;

class CreateQuizPage extends StatefulWidget {
  const CreateQuizPage({super.key, this.isModify = false});

  final bool isModify;

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {

  late final Map<String, dynamic> _teacherData;  // teacher classes and subjects
  late final Map<String, dynamic> _userInfo;  // user info (used for its ID)
  int? quizId;  // quiz ID if we are modifying a quiz
  late final Map<String, dynamic>? quizData;  // quiz data if we are modifying a quiz
  final QuizCreationData _quizProvider = QuizCreationData();

  // used in dev mode to avoid data reload after a hot reload
  bool _isPageLoaded = false;
  // avoids page reload when modifying a quiz
  late Future<bool> _pageFuture;

  final Widget _spacer = const SizedBox(height: 24.0);

  @override
  void initState() {
    super.initState();
    _pageFuture = _loadData();
  }

  /// Load the data for the page
  /// This method is the future for the FutureBuilder
  /// Needs [context] to use the Provider
  Future<bool> _loadData() async {

    if (_quizProvider.quizId != null) {
      return true;
    }

    if (!_isPageLoaded) {
      _teacherData = await getAssociate();
      _userInfo = await getUserInfo();

      if (widget.isModify && mounted) {
        // get the quiz ID from the arguments
        quizId = ModalRoute.of(context)!.settings.arguments as int;
        // get the quiz data
        quizData = await getQuiz(quizId!);

        // set the quiz data in the provider
        _quizProvider.setQuizData(quizData!);
      } else {
        quizId = null;
        quizData = null;
      }

      _isPageLoaded = true;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _pageFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            printError(snapshot.error.toString());
            return const Center(
              child: Text(
                'An error occurred, please try again later',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontFamily: 'QuickSand',
                ),
              ),
            );

          } else if (snapshot.connectionState == ConnectionState.done) {

            Map<String, dynamic> data = _teacherData;

            return ChangeNotifierProvider.value(
              value:  _quizProvider,
              child: Consumer<QuizCreationData>(
                  builder: (context, value, child) {

                    value.setUserId(_userInfo['id']);

                    return PopScope(
                      onPopInvoked: (_) {
                        // unFocus all text fields
                        Provider.of<LayoutProvider>(context, listen: false).unFocusAll();
                      },

                      canPop: false,

                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 24.0),
                              child: QuizNameInput(),
                            ),

                            SelectSubjectClassButton(mode: "class", listOfSelections: data["classes"]!),
                            SelectSubjectClassButton(mode: "subject", listOfSelections: data["matieres"]!),

                            _spacer,

                            const QuestionsSection(),

                            _spacer,

                            const CreateQuizButton(),

                            _spacer,
                          ],
                        ),
                      ),
                    );
                  }
              ),
            );
          } else {
            return const FullPageLoading(text: "Loading...");
          }
        }
    );
  }
}
