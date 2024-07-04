import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/creation/create_quiz_button.dart' show CreateQuizButton;
import 'package:my_quiz_ap/components/Quiz/creation/quiz_name_input.dart' show QuizNameInput;
import 'package:my_quiz_ap/components/Quiz/creation/select_subject_class_button.dart' show SelectSubjectClassButton;
import 'package:my_quiz_ap/components/full_page_loading.dart' show FullPageLoading;
import 'package:my_quiz_ap/helpers/get_user_info.dart' show getUserInfo;
import 'package:my_quiz_ap/helpers/quiz_creation/get_associate.dart' show getAssociate;
import 'package:my_quiz_ap/helpers/utils.dart' show printError;
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

  /// Load the data for the page
  /// This method is the future for the FutureBuilder
  /// Needs [context] to use the Provider
  Future<bool> _loadData(BuildContext context) async {
    if (!_isPageLoaded) {
      _teacherData = await getAssociate();
      _userInfo = await getUserInfo();
      if (context.mounted) {
        Provider.of<QuizCreationData>(context, listen: false)
            .setUserId(_userInfo['id']);
      }
      _isPageLoaded = true;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => QuizCreationData(),
      // Consumer to get the data from the provider within the widget
      child: Consumer<QuizCreationData>(
        builder: (context, value, child) {

          return FutureBuilder(
              future: _loadData(context),
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

                  return PopScope(
                    onPopInvoked: (_) {
                      // TODO : unFocus all text fields
                    },
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

                          const CreateQuizButton(),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const FullPageLoading(text: "Loading...");
                }
              }
          );
        },
      ),
    );
  }
}
