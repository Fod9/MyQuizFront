import 'package:flutter/material.dart';

import '../../helpers/Colors.dart';

class DropdownQuizHeader extends StatefulWidget {
  const DropdownQuizHeader({
    super.key,
    required this.blockName,
    required this.height,
    required this.width,
    required this.expandedHeight,
    this.toggleExpand,
  });

  final String blockName;
  final double height, expandedHeight, width;
  final VoidCallback? toggleExpand;

  @override
  State<DropdownQuizHeader> createState() => DropdownQuizHeaderState();
}

class DropdownQuizHeaderState extends State<DropdownQuizHeader>
    with SingleTickerProviderStateMixin {

  late double currentHeight = widget.height;
  final Duration _animationDuration = const Duration(milliseconds: 250);

  late final AnimationController _controller = AnimationController(
    duration: _animationDuration,
    vsync: this,
  )..addListener(() {
      setState(() {
        currentHeight = _animation.value;
      });
    });

  late final CurvedAnimation _animationCurve = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeInOut,
  );

  late final Animation<double> _animation = Tween<double>(
    begin: widget.height,
    end: widget.expandedHeight,
  ).animate(_animationCurve);

  void toggleExpand() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(

      onTap: widget.toggleExpand,

      child: DecoratedBox(
        decoration: BoxDecoration(
          color: const Color(0x66000000),
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              color: Color(0x40000000),
              blurRadius: 7.5,
              spreadRadius: 0,
              // offset: Offset(0, 5),
            ),
          ],
        ),
        child: SizedBox(
          height: currentHeight,
          width: widget.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 44),

              Text(
                widget.blockName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'QuickSand',
                  color: Colors.white,
                ),
              ),

              SizedBox(
                width: 44,
                child: AnimatedRotation(
                  turns: _animationCurve.value / 2 - 0.25,
                  duration: const Duration(milliseconds: 25),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: lightGreen,
                    size: 27,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
