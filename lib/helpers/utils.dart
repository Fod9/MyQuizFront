import 'package:flutter/cupertino.dart' show BuildContext, MediaQuery;
import 'package:flutter/foundation.dart' show kDebugMode;

String getScreenType(BuildContext context) {
  double width = MediaQuery.of(context).size.width;

  if (width >= 1000) {
    return "desktop";
  } else if (width >= 650 && width < 1000) {
    return "tablet";
  } else {
    return "mobile";
  }
}


void printError(String text) {
  if (kDebugMode) print('\x1B[31m$text\x1B[0m');
}

void printWarning(String text) {
  if (kDebugMode) print('\x1B[33m$text\x1B[0m');
}

void printInfo(String text) {
  if (kDebugMode) print('\x1B[36m$text\x1B[0m');
}

void printOrder(String text) {
  if (kDebugMode) print('\x1B[34m$text\x1B[0m');
}

void printSuccess(String text) {
  if (kDebugMode) print('\x1B[32m$text\x1B[0m');
}