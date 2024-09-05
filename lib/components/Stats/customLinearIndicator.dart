import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/Colors.dart';

class StatsLinearIndicator extends StatefulWidget {
  const StatsLinearIndicator({
    super.key,
    required this.percentage,
    this.text
  });

  final String? text;
  final num percentage;

  @override
  State<StatsLinearIndicator> createState() => _StatsLinearIndicatorState();
}

class _StatsLinearIndicatorState extends State<StatsLinearIndicator> {

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Stack(
              children: [
                Container(
                  height: 30,
                  width: constraints.maxWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Container(
                    height: 30,
                    width: constraints.maxWidth * widget.percentage / 100,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          lightGlassBlue,
                          lightGreen,
                        ],
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        widget.text ?? "${widget.percentage}%",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    )
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
