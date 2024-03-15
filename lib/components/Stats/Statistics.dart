import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/sizedBlock.dart';

class StatisticsBlock extends StatefulWidget {
  const StatisticsBlock({
    super.key,
    this.blockName = "Student Statistics",
    required this.height,
    required this.width,
  });

  final String blockName;
  final double height;
  final double width;


  @override
  State<StatisticsBlock> createState() => _StatisticsBlockState();
}

class _StatisticsBlockState extends State<StatisticsBlock> {
  @override
  Widget build(BuildContext context) {
    return SizedBlock(
        blockName: widget.blockName,
        height: widget.height,
        width: widget.width,
        clickEvent: () {},
        child: Placeholder(),
    );
  }
}
