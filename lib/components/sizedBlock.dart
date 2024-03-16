import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/Colors.dart';

class SizedBlock extends StatefulWidget {
  const SizedBlock({
    super.key,
    required this.height,
    required this.width,
    required this.clickEvent,
    this.isExpanded = true,
    this.isExpendable = false,
    this.expandController,
    this.child,
    this.blockName = "",
    this.expandSize = 0.5,
    this.hasShadow = false,
  });

  final String blockName;
  final double height;
  final double width;
  final VoidCallback clickEvent;
  final bool isExpanded;
  final bool isExpendable;
  final AnimationController? expandController;
  final Widget? child;
  final double expandSize;
  final bool hasShadow;

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
      begin: widget.height * widget.expandSize,
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
          // wait a bit before setting the state
          Future.delayed(const Duration(milliseconds: 100), () {
            isExpanded = !isExpanded;
          });
        } else {
          _expandController.forward();
          Future.delayed(const Duration(milliseconds: 200), () {
            isExpanded = !isExpanded;
          });
        }
      }
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
            height:
                widget.isExpendable ? _expandAnimation.value : widget.height,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: darkGlass,
              borderRadius: BorderRadius.circular(widget.height / 6),
              boxShadow: widget.hasShadow
                  ? [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : null,
            ),
            child: Center(
              child: Container(
                width: widget.width,
                height: widget.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.blockName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    if (isExpanded && widget.child != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        // Ajouter un espacement si nécessaire
                        child: widget.child,
                      ),
                  ],
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
