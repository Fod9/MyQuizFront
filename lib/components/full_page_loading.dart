import 'package:flutter/material.dart';

class FullPageLoading extends StatelessWidget {
  const FullPageLoading({
    super.key,
    this.text,
  });

  final String? text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text ?? "Loading...",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24.0,
              fontFamily: "QuickSand",
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20.0),

          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeCap: StrokeCap.round,
          ),
        ],
      ),
    );
  }
}
