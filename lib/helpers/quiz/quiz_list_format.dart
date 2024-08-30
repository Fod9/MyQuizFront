/// Formats the quiz list data from the API to a more convenient format
/// - [quizList] is the data from the API as a [Map<String, dynamic>]
/// - returns a [List<Map<String, dynamic>>]
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