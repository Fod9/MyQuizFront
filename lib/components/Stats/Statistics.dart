import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/sizedBlock.dart';

class StatisticsBlock extends StatefulWidget {
   StatisticsBlock({
    super.key,
    this.blockName = "Student Statistics",
    required this.height,
    required this.width,
    this.clickEvent,
    this.child = const SizedBox(),
    this.expandController
  });

  final String blockName;
  final double height;
  final double width;
  final Function? clickEvent;
  final AnimationController? expandController;
  final Widget child;


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
    return SizedBlock(
        blockName: widget.blockName,
        height: widget.height,
        width: widget.width,
        expandController: widget.expandController,
        isExpanded: false,
        isExpendable: true,
        clickEvent: () {},
        expandSize: 0.3,
        child: Column(
          children: [
            for (var entry in stats.entries)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(entry.key),
                  Text(entry.value.toString()),
                ],
              ),
            widget.child,
          ],
        )
    );
  }
}
