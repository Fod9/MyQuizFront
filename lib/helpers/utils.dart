import 'package:flutter/cupertino.dart' show BuildContext, MediaQuery;
import 'package:flutter/foundation.dart' show kDebugMode;

String getScreenType(BuildContext context) {
  return MediaQuery.of(context).size.width > 600 ? "desktop" : "mobile";
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