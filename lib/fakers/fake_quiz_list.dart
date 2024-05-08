Future<List<Map<String, dynamic>>> getFakeQuizList({
  int subjectCount = 3,
  int quizCount = 3,
  int delay = 3,
  bool throwError = false,
}) async {
  List<Map<String, dynamic>> quizList = [];

  for (int i = 1; i <= subjectCount; i++) {
    List<Map<String, dynamic>> quizListSubject = [];
    for (int j = 1; j <= quizCount; j++) {
      quizListSubject.add({
        "name": "Quiz $j",
        "id": "$j",
      });
    }
    quizList.add({
      "name": "Subject $i",
      "id": "$i",
      "quizList": quizListSubject,
    });
  }

  if (throwError) {
    throw Exception("Error fetching quiz list");
  } else {
    await Future.delayed(Duration(seconds: delay));
    return quizList;
  }
}