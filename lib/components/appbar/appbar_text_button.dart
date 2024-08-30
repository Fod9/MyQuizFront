import 'package:flutter/material.dart';

class AppbarTextButton extends StatefulWidget {
  const AppbarTextButton({
    super.key,
    required this.route,
    required this.text,
    this.child,
    this.color,
  });

  final String route, text;
  final Widget? child;
  final Color? color;

  @override
  State<AppbarTextButton> createState() => _AppbarTextButtonState();
}

class _AppbarTextButtonState extends State<AppbarTextButton> {

  final Color _highlightColor = const Color(0xFF685374);

  late final TextStyle _textStyle = TextStyle(
    fontSize: MediaQuery.of(context).size.width < 600 ? 24 : 20,
    height: 1.2,
    fontWeight: FontWeight.w600,
    fontFamily: 'Quicksand',
    color: widget.color ?? _highlightColor,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            widget.route, (route) => false
        );
      },

      color: const Color(0x00000000),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),

      elevation: 0,
      highlightElevation: 0,
      hoverElevation: 0,
      hoverColor: Colors.white.withOpacity(0.35),
      highlightColor: Colors.white.withOpacity(0.35),
      splashColor: const Color(0x60FFFFFF),

      child: widget.child ?? Text(
        widget.text,
        style: _textStyle,
      ),
    );
  }
}
