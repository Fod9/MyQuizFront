import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/Stats/custom_linear_indicator.dart' show CustomLinearIndicator;
import 'package:my_quiz_ap/components/sized_block.dart' show SizedBlock;
import 'package:my_quiz_ap/components/stats/custom_circular_indicator.dart' show CustomCircularIndicator;

class StatisticsBlock extends StatefulWidget {
  const StatisticsBlock({
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
    final double blockHeight = MediaQuery.of(context).size.height * 0.3;
    final double blockWidth  = MediaQuery.of(context).size.width * 0.8;
    return SizedBlock(
      blockName: parentWidget.blockName,
      height: blockHeight,
      width: blockWidth,
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
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomCircularIndicator(
                  width: blockHeight * 0.50,
                  percentage: 90,
                ),
                Center(
                  child: CustomLinearIndicator(
                    width: blockWidth * 0.25,
                    text: "20/40 minutes",
                    margin: const EdgeInsets.only(left: 20)
                  ),
                ),
                Center(
                  child: CustomLinearIndicator(
                    width: blockWidth * 0.25,
                    text: "10/20 Quiz",
                    margin: const EdgeInsets.only(left: 20)
                  ),
                )
              ],
            ),
          ),
          parentWidget.child,
        ],
      ),
    );
  }
}
