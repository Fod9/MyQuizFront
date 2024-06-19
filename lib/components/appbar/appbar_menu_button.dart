import 'package:flutter/material.dart';

class AppbarMenuButton extends StatelessWidget {
  const AppbarMenuButton({
    super.key,
    this.size = 50.0,
    required this.scaffoldKey,
  });

  final double size;
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: IconButton(

        onPressed: () {
          scaffoldKey.currentState!.openEndDrawer();
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
