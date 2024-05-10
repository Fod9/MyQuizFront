import 'package:flutter/cupertino.dart';

String getScreenType(BuildContext context) {
  return MediaQuery.of(context).size.width > 600 ? "desktop" : "mobile";
}