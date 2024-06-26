import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Quiz/creation/create_quiz_button.dart' show CreateQuizButton;
import 'package:my_quiz_ap/components/Quiz/creation/quiz_name_input.dart' show QuizNameInput;
import 'package:my_quiz_ap/components/Quiz/creation/select_subject_class_button.dart' show SelectSubjectClassButton;
import 'package:my_quiz_ap/components/full_page_loading.dart' show FullPageLoading;
import 'package:my_quiz_ap/helpers/quiz_creation/get_associate.dart' show getAssociate;
import 'package:my_quiz_ap/providers/quiz_creation_data.dart' show QuizCreationData;
import 'package:provider/provider.dart' show ChangeNotifierProvider;

class CreateQuizPage extends StatefulWidget {
  const CreateQuizPage({super.key});

  @override
  State<CreateQuizPage> createState() => _CreateQuizPageState();
}

class _CreateQuizPageState extends State<CreateQuizPage> {

  final Future<Map<String, dynamic>> teacherData = getAssociate();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: teacherData,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
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

            Map<String, dynamic> data = snapshot.data!;

            return ChangeNotifierProvider(
              create: (BuildContext context) => QuizCreationData(),
              child: PopScope(
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
              ),
            );
          } else {
            return const FullPageLoading(text: "Loading...");
          }
        }
    );
  }
}
