import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Stats/customLinearIndicator.dart';
import 'package:my_quiz_ap/components/sizedBlock.dart';
import 'package:my_quiz_ap/helpers/Colors.dart';

import 'customCircularIndicator.dart';

class StatisticsBlock extends StatefulWidget {
  StatisticsBlock({
    super.key,
    this.blockName = "Student Statistics",
    required this.height,
    required this.width,
    this.clickEvent,
    this.child = const SizedBox(),
    this.expandController,
    this.isExpanded = false,
    this.isExpandable = true,
    this.mode = "mobile",
  });

  final String blockName;
  final double height;
  final double width;
  final Function? clickEvent;
  final AnimationController? expandController;
  final Widget child;
  final bool isExpandable;
  final bool isExpanded;
  final String mode;

  @override
  State<StatisticsBlock> createState() => _StatisticsBlockState();
}

class _StatisticsBlockState extends State<StatisticsBlock> {
  Map<String, int> stats = {
    "Maths": 90,
    "Physics": 80,
    "Chemistry": 70,
    "Biology": 60,
    "English": 50,
  };

  @override
  Widget build(BuildContext context) {
    return (widget.mode == "mobile" )
        ? MobileDisplay(parentWidget: widget)
        : DesktopDisplay(parentWidget: widget);
  }
}

class MobileDisplay extends StatelessWidget {
  const MobileDisplay({super.key, required this.parentWidget});

  final parentWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBlock(
      blockName: parentWidget.blockName,
      height: parentWidget.height,
      width: parentWidget.width,
      expandController: parentWidget.expandController,
      isExpanded: parentWidget.isExpanded,
      isExpendable: parentWidget.isExpandable,
      clickEvent: () {},
      expandSize: 0.3,
      percentRadius: 0.05,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              CustomCircularIndicator(
                width: parentWidget.width * 0.35,
                percentage: 90,
              ),
              Center(
                child: CustomLinearIndicator(
                  width: parentWidget.width * 0.8,
                  text: "20/40 minutes",
                ),
              ),
              Center(
                child: CustomLinearIndicator(
                  width: parentWidget.width * 0.8,
                  text: "10/20 Quiz",
                ),
              )
            ],
          ),
          parentWidget.child,
        ],
      ),
    );
  }
}

class DesktopDisplay extends StatelessWidget {
  const DesktopDisplay({super.key, required this.parentWidget});

  final parentWidget;

  @override
  Widget build(BuildContext context) {
    return SizedBlock(
      blockName: parentWidget.blockName,
      height: parentWidget.height,
      width: parentWidget.width,
      expandController: parentWidget.expandController,
      isExpanded: false,
      isExpendable: true,
      clickEvent: () {},
      expandSize: 0.3,
      percentRadius: 0.05,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              CustomCircularIndicator(
                width: parentWidget.width * 0.35,
                percentage: 90,
              ),
              Center(
                child: CustomLinearIndicator(
                  width: parentWidget.width * 0.8,
                  text: "20/40 minutes",
                ),
              ),
              Center(
                child: CustomLinearIndicator(
                  width: parentWidget.width * 0.8,
                  text: "10/20 Quiz",
                ),
              )
            ],
          ),
          parentWidget.child,
        ],
      ),
    );
  }
}
