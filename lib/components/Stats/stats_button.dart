import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Stats/statistics.dart' show displayStatsPopup;
import 'package:my_quiz_ap/helpers/Colors.dart' show darkGlass, electricBlue;

class StatisticsButton extends StatelessWidget {
  StatisticsButton({super.key});

  final Color baseColor = darkGlass.withOpacity(0.4);

  final Color highlightColor = electricBlue.withOpacity(0.4);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      child: SizedBox(
        width: (MediaQuery.of(context).size.width * 0.6).clamp(100, 350),
        child: MaterialButton(
          onPressed: () => {displayStatsPopup(context)},

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),

          color: baseColor,
          disabledColor: baseColor,
          focusColor: highlightColor,
          hoverColor: highlightColor,
          highlightColor: highlightColor,

          elevation: 0,

          child: const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Center(
              child: Text(
                "Voir mes statistiques",
                style: TextStyle(
                  fontFamily: "QuickSand",
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}