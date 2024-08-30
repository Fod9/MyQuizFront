import 'package:flutter/material.dart';

class DrawerTrialButton extends StatelessWidget {
  const DrawerTrialButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        // TODO Navigator.of(context).pushNamed('/trial');
        // TODO add the route '/trial' and its corresponding page
      },

      color: const Color(0x806A0DAD),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 7.5,
        horizontal: 25.0,
      ),

      elevation: 0,

      child: Text(
        'Essai gratuit',
        style: TextStyle(
          fontSize: MediaQuery.of(context).size.width < 600 ? 24 : 20,
          height: 1.2,
          fontWeight: FontWeight.w600,
          fontFamily: 'Quicksand',
          color: const Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}
