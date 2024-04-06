import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/Colors.dart';

class CustomLinearIndicator extends StatefulWidget {
  const CustomLinearIndicator({
    super.key,
    required this.width,
    required this.text,
    this.margin = const EdgeInsets.only(top: 40),
  });

  final double width;
  final String text;
  final EdgeInsets margin;

  @override
  State<CustomLinearIndicator> createState() => _CustomLinearIndicatorState();
}

class _CustomLinearIndicatorState extends State<CustomLinearIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      margin: widget.margin,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Stack(
            children: [
              Container(
                height: 30,
                width: widget.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                height: 30,
                width: widget.width * 0.9,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      lightGlassBlue,
                      lightGreen,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
          Text(
            widget.text,
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
