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
    // cut a "add" button inside a circle
    return Container(
      height: widget.width * 0.15,
      width: widget.width * 0.15,
      child: ClipPath(
        clipper: AddClipper(),
        child: Container(
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}
class AddClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final rectWidth = size.width * 0.12;
    final rectHeight = size.height * 0.12;

    // Draw the circle
    path.addOval(Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2,
    ));

    // Draw horizontal rectangle
    final horizontalRect = Path()
      ..addRect(Rect.fromLTWH(
        size.width / 2 - rectWidth / 2,
        size.height / 4,
        rectWidth,
        size.height / 2,
      ));

    // Draw vertical rectangle
    final verticalRect = Path()
      ..addRect(Rect.fromLTWH(
        size.width / 4,
        size.height / 2 - rectHeight / 2,
        size.width / 2,
        rectHeight,
      ));

    // Subtract the rectangles from the circle
    Path path1 = Path.combine(PathOperation.difference, path, horizontalRect);
    Path finalPath = Path.combine(PathOperation.difference, path1, verticalRect);

    return finalPath;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}