import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/utils.dart' show getScreenType;

class MyQuizBackground extends StatelessWidget {
  const MyQuizBackground({super.key});

  @override
  Widget build(BuildContext context) {

    String screenType = getScreenType(context);

    return SizedBox.expand(
      child: DecoratedBox(
          decoration: BoxDecoration(
            image: DecorationImage(
              // switch background with type
              image: (screenType == "mobile")
                  ? const AssetImage(
                  "assets/images/BackgroundMobile.png")
                  : const AssetImage(
                  "assets/images/BackgroundDesktop.png"),
              fit: BoxFit.cover,
            ),
          )
      ),
    );
  }
}
