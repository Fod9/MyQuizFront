import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/Colors.dart';

class StatsCircularIndicator extends StatefulWidget {
  const StatsCircularIndicator({
    super.key,
    required this.width,
    required this.percentage,
  });

  final double width;

  final num percentage;

  @override
  State<StatsCircularIndicator> createState() => _StatsCircularIndicatorState();
}

class _StatsCircularIndicatorState extends State<StatsCircularIndicator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.width,
      width: widget.width,
      child: Stack(
          children: [
            SizedBox(
              height: widget.width,
              width: widget.width,
              child: RotatedBox(
                quarterTurns: 2,
                child: CircularProgressIndicator(
                  value: widget.percentage / 20,
                  strokeWidth: 10,
                  color: lightGreen,
                  strokeCap: StrokeCap.round,
                ),
              ),
            ),
            Center(
              child: Text(
                widget.percentage.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: widget.width * 0.2,
                  fontFamily: "QuickSand",
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
  }
}
