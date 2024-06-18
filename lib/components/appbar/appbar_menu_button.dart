import 'package:flutter/material.dart';

class AppbarMenuButton extends StatelessWidget {
  const AppbarMenuButton({
    super.key,
    this.size = 50.0,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: IconButton(

        onPressed: () {
          Scaffold.of(context).openDrawer();
        },

        padding: EdgeInsets.zero,
        alignment: Alignment.center,

        icon: Icon(
          Icons.menu_rounded,
          color: const Color(0xFFFFFFFF),
          size: size * 0.6,
        ),
      ),
    );
  }
}
