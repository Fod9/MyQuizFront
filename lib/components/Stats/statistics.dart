import 'dart:convert';
import 'dart:ui';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:my_quiz_ap/components/Stats/customCircularIndicator.dart';
import 'package:my_quiz_ap/components/Stats/customLinearIndicator.dart';
import 'package:my_quiz_ap/helpers/Colors.dart';
import 'package:my_quiz_ap/helpers/http_extensions.dart';

import '../../constants.dart';
import '../../helpers/jwt/jwt.dart';
import '../../helpers/jwt/token_checker.dart';
import '../../helpers/stats/get_stats.dart';
import '../../helpers/utils.dart';

class Statistics extends StatefulWidget {
  const Statistics({
    super.key,
    required this.togglePopup,
  });

  final Function(BuildContext) togglePopup;

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, bottom: 30),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: DecoratedBox(
          decoration: BoxDecoration(
              color: darkGlass, borderRadius: BorderRadius.circular(10)),
          child: MaterialButton(
            onPressed: () => {widget.togglePopup(context)},
            child: const Padding(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Center(
                child: Text(
                  "Voir mes statistiques",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StatisticsPopUp extends StatefulWidget {
  const StatisticsPopUp({super.key});

  @override
  _StatisticsPopUpState createState() => _StatisticsPopUpState();
}

class _StatisticsPopUpState extends State<StatisticsPopUp> {
  Future<bool>? _statsFuture;

  late Map<String, num> _stats = {
    "average_note": 0,
    "time_elapsed": 0,
    "percentage_done_quizzes": 0,
  };

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  void _loadStats() async {
    Map response = await getStats();
    if (response["error"] != null) {
      _statsFuture = Future.value(false);
    } else {
      setState(() {
        _stats = {
          "average_note": response["average_note"],
          "time_elapsed": response["time_elapsed"],
          "percentage_done_quizzes": response["percentage_done_quizzes"],
        };
        print(_stats);
      });
      _statsFuture = Future.value(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _statsFuture,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(
              child: Text("Erreur de chargement des statistiques"));
        } else if (snapshot.hasData && snapshot.data!) {
          return PopScope(
            canPop: false,
            child: Center(
              child: BlurryContainer(
                blur: 30,
                color: Colors.black.withOpacity(0.4),
                elevation: 15,
                shadowColor: electricBlue,
                borderRadius: BorderRadius.circular(20),
                width: (MediaQuery.of(context).size.width * 0.75).clamp(0, 500),
                height:
                    (MediaQuery.of(context).size.height * 0.75).clamp(0, 500),
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(24.0),
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
                          CustomCircularIndicator(
                              width: 90, percentage: _stats["average_note"]!),
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
                          CustomLinearIndicator(
                              percentage: _stats["time_elapsed"]!,
                              text: "${_stats["time_elapsed"]!} / 100"),
                          SizedBox(height: 20),
                          Align(
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
                          CustomLinearIndicator(
                              percentage: _stats["percentage_done_quizzes"]!,
                              text:
                                  "${_stats["percentage_done_quizzes"]} / 100"),
                        ],
                      ),
                    ),
                    Positioned(
                      child: IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      top: 0,
                      right: 0,
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Center(
              child: Column(
            children: [
              const Text("Erreur de chargement des statistiques"),
              ElevatedButton(
                onPressed: () => _loadStats(),
                child: const Text("Réessayer"),
              ),
            ],
          ));
        }
      },
    );
  }
}
