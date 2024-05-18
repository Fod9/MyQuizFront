
// input format :
// {Subject: [{name: Python, id: 1, Quiz: [{id: 40, name: Quiz Programmation 1, created_by: 17, created_at: 2024-05-08T14:49:21.000Z}]}]}

List<Map<String, dynamic>> quizListFormat(Map<String, dynamic> quizList) {
  List<Map<String, dynamic>> formattedList = [];

  for (var subject in quizList['Subject']) {
    Map<String, dynamic> subjectMap = {
      'name': subject['name'],
      'id': subject['id'],
      'quizList': <Map<String, dynamic>>[],
    };

    for (var quiz in subject['Quiz']) {
      Map<String, dynamic> quizMap = {
        'id': quiz['id'],
        'name': quiz['name'],
        'created_by': quiz['created_by'],
        'created_at': quiz['created_at'],
      };

      subjectMap['quizList'].add(quizMap);
    }

    formattedList.add(subjectMap);
  }

  return formattedList;
}