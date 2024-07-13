import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/creation/end_validation/create_quiz_button.dart' show CreateQuizButton;
import 'package:my_quiz_ap/components/Quiz/creation/questions/questions_section.dart' show QuestionsSection;
import 'package:my_quiz_ap/components/Quiz/creation/quiz_name_input.dart' show QuizNameInput;
import 'package:my_quiz_ap/components/Quiz/creation/select_subject_class_button.dart' show SelectSubjectClassButton;
import 'package:my_quiz_ap/components/full_page_loading.dart' show FullPageLoading;
import 'package:my_quiz_ap/helpers/get_user_info.dart' show getUserInfo;
import 'package:my_quiz_ap/helpers/quiz_creation/get_associate.dart' show getAssociate;
import 'package:my_quiz_ap/helpers/utils.dart' show printError;
import 'package:my_quiz_ap/providers/layout_provider.dart';
import 'package:my_quiz_ap/providers/quiz_creation_data.dart' show QuizCreationData;
import 'package:provider/provider.dart' show ChangeNotifierProvider, Consumer, Provider;

class CreateQuizPage extends StatefulWidget {
  const CreateQuizPage({super.key});

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {

  late final Map<String, dynamic> _teacherData;  // teacher classes and subjects
  late final Map<String, dynamic> _userInfo;  // user info (used for its ID)

  // used in dev mode to avoid data reload after a hot reload
  bool _isPageLoaded = false;

  final Widget _spacer = const SizedBox(height: 24.0);

  /// Load the data for the page
  /// This method is the future for the FutureBuilder
  /// Needs [context] to use the Provider
  Future<bool> _loadData() async {
    if (!_isPageLoaded) {
      _teacherData = await getAssociate();
      _userInfo = await getUserInfo();
      _isPageLoaded = true;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadData(),
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

            return ChangeNotifierProvider(
              create: (context) => QuizCreationData(),
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
