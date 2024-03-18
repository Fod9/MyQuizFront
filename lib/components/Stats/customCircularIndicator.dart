import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/Colors.dart';

class CustomCircularIndicator extends StatefulWidget {
  const CustomCircularIndicator({
    super.key,
    required this.width,
    required this.percentage,
  });

  final double width;

  final int percentage;

  @override
  State<CustomCircularIndicator> createState() => _CustomCircularIndicatorState();
}

class _CustomCircularIndicatorState extends State<CustomCircularIndicator> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.width,
      width: widget.width,
      child: Expanded(
        child: Stack(
          children: [
            SizedBox(
              height: widget.width,
              width: widget.width,
              child: const RotatedBox(
                quarterTurns: 2,
                child: CircularProgressIndicator(
                  value: 0.9,
                  strokeWidth: 15,
                  color: lightGreen,
                  strokeCap: StrokeCap.round,
                ),
              ),
            ),
            Center(
              child: Text(
                "${widget.percentage}",
                style: TextStyle(
                  fontSize: widget.width * 0.2,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
