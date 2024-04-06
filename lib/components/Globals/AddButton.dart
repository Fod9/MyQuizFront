import 'package:flutter/material.dart';

class AddButton extends StatefulWidget {
  const AddButton({
    super.key,
    required this.width,
    required this.color
  });


  final double width;
  final Color color;

  @override
  State<AddButton> createState() => _AddButtonState();
}

class _AddButtonState extends State<AddButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: this.widget.width * 0.15,
      width: this.widget.width * 0.15,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Icon(
        Icons.add,
        color: Colors.black,
      ),
    );
  }
}
