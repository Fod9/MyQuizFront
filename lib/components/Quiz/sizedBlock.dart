import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/Colors.dart';

class SizedBlock extends StatefulWidget {
  const SizedBlock({super.key,
    required this.matiereName,
    required this.height,
    required this.width,
    required this.clickEvent,
    this.isExpanded = true,
    this.isExpendable = false,
    this.expandController
    ,
  });

  final String matiereName;
  final double height;
  final double width;
  final VoidCallback clickEvent;
  final bool isExpanded;
  final bool isExpendable;
  final AnimationController? expandController;

  @override
  State<SizedBlock> createState() => _SizedBlockState();
}

class _SizedBlockState extends State<SizedBlock>
    with SingleTickerProviderStateMixin {
  late AnimationController _expandController;
  late Animation<double> _expandAnimation;
  bool isExpanded = true;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.isExpanded;

    _expandController = widget.expandController ??
        AnimationController(
          duration: const Duration(milliseconds: 500),
          vsync: this,
        );

    _expandAnimation = Tween<double>(
      begin: widget.height * 0.5,
      end: widget.height,
    ).animate(
      CurvedAnimation(
        parent: _expandController,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _expand() {
    setState(() {
      if (widget.expandController == null) {
        if (isExpanded) {
          _expandController.reverse();
        } else {
          _expandController.forward();
        }
      }
      isExpanded = !isExpanded;
      widget.clickEvent();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _expandController,
      builder: (context, child) {
        return GestureDetector(
          onTap: _expand,
          child: Container(
            width: widget.width,
            height: widget.isExpendable ? _expandAnimation.value : widget.height,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: darkGlass,
              borderRadius: BorderRadius.circular(widget.height / 6),
            ),
            child: Center(
              child: Text(
                widget.matiereName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _expandController.dispose();
    super.dispose();
  }
}
