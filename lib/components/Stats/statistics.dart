import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:blurrycontainer/blurrycontainer.dart' show BlurryContainer;
import 'package:my_quiz_ap/components/Stats/customCircularIndicator.dart' show StatsCircularIndicator;
import 'package:my_quiz_ap/components/Stats/customLinearIndicator.dart' show StatsLinearIndicator;
import 'package:my_quiz_ap/helpers/Colors.dart' show electricBlue;
import 'package:my_quiz_ap/helpers/stats/get_stats.dart' show getStats;

class StatisticsPopUp extends StatefulWidget {
  const StatisticsPopUp({super.key});

  @override
  State<StatisticsPopUp> createState() => _StatisticsPopUpState();
}

class _StatisticsPopUpState extends State<StatisticsPopUp> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getStats(),
      builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.hasError) {
          return Expanded(
            child: Center(
                child: Column(
                  children: [
                    const Text("Erreur de chargement des statistiques"),
                    ElevatedButton(
                      onPressed: () => {
                        Navigator.of(context).pop(),
                        displayStatsPopup(context),
                      },
                      child: const Text(
                          "Réessayer",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "QuickSand",
                            fontWeight: FontWeight.bold,
                          )
                      ),
                    ),
                  ],
                )
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.done) {

          final Map<String, dynamic> stats = snapshot.data!;

          return Center(
            child: BlurryContainer(
              blur: 30,
              color: Colors.black.withOpacity(0.4),
              elevation: 15,
              shadowColor: electricBlue,
              borderRadius: BorderRadius.circular(20),
              width: (MediaQuery.of(context).size.width * 0.75).clamp(0, 500),
              height: (MediaQuery.of(context).size.height * 0.75).clamp(0, 500),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Vos statistiques",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "QuickSand",
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Moyenne",
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "QuickSand",
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),

                        const SizedBox(height: 20),

                        StatsCircularIndicator(
                            width: 90, percentage: stats["average_note"]!
                        ),

                        const SizedBox(height: 20),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Temps passé",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "QuickSand",
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),

                        StatsLinearIndicator(
                            percentage: stats["time_elapsed"]!,
                            text: "${stats["time_elapsed"]!} / 100"
                        ),

                        const SizedBox(height: 20),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Quiz fait",
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: "QuickSand",
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),

                        StatsLinearIndicator(
                            percentage: stats["percentage_done_quizzes"]!,
                            text: "${stats["percentage_done_quizzes"]} / 100"
                        ),
                      ],
                    ),
                  ),

                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.close_rounded, color: Colors.white),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const CircularProgressIndicator(
            color: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeCap: StrokeCap.round,
          );
        }
      },
    );
  }
}


void displayStatsPopup(BuildContext context) {
  showDialog(
    context: context,
    barrierColor: const Color(0x00000000),
    builder: (context) => Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
        ),

        const StatisticsPopUp(),
      ],
    ),
  );
}