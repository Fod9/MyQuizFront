import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/colors.dart';

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
    this.percentRadius = 0.15,
    this.centeredVText = true,
    this.centeredHText = true,
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
  final double percentRadius;
  final bool centeredVText;
  final bool centeredHText;

  @override
  State<SizedBlock> createState() => _SizedBlockState();
}

class _SizedBlockState extends State<SizedBlock>
    with SingleTickerProviderStateMixin {
  late AnimationController _expandController;
  late Animation<double> _expandAnimation;
  bool isExpanded = true;
  double radius = 0;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.isExpanded;

    // Initialize the controller for the animation to pass to the widget’

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


    setState(() {
      radius = widget.height * widget.percentRadius;
    });

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
          radius = widget.height * widget.percentRadius;
        } else {
          _expandController.forward();
          Future.delayed(const Duration(milliseconds: 200), () {
            isExpanded = !isExpanded;
          });
          radius = widget.height / 2 * widget.percentRadius;
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
          onTap: () {
            if (widget.isExpendable) {
              _expand();
            }
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: Container(
              width: widget.width,
              height: widget.isExpendable ? _expandAnimation.value : widget.height,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: darkGlass,
                borderRadius: BorderRadius.circular(radius),
                boxShadow: widget.hasShadow
                    ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(2, 2),
                  ),
                ]
                    : null,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(radius),
                child: Container(
                  color: Colors.transparent, // Apply the background color here
                  child: Center(
                    child: SizedBox(
                      width: widget.width,
                      height: widget.height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (!isExpanded)
                            Center(
                              child: Text(
                                widget.blockName,
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          else
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: (isExpanded && !widget.isExpendable)
                                    ? const EdgeInsets.only(top: 0)
                                    : const EdgeInsets.only(top: 20),
                                child: Text(
                                  widget.blockName,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          if (widget.child != null && isExpanded)
                            Expanded(
                              child: widget.child!,
                            ),
                        ],
                      ),
                    ),
                  ),
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
