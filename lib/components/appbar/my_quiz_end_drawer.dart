import 'package:flutter/material.dart';
import 'package:my_quiz_ap/components/appbar/appbar_text_button.dart';
import 'dart:ui' show Clip, Color, FontWeight, ImageFilter, Radius;

import 'package:my_quiz_ap/components/appbar/drawer_trial_button.dart';

class MyQuizEndDrawer extends StatefulWidget {
  const MyQuizEndDrawer({
    super.key,
  });

  @override
  State<MyQuizEndDrawer> createState() => _MyQuizEndDrawerState();
}

class _MyQuizEndDrawerState extends State<MyQuizEndDrawer> {
  final Color _highlightColor = const Color(0xFF685374);

  final double _blur = 10.0;

  late final TextStyle _textStyle = TextStyle(
    fontSize: 24,
    height: 1.2,
    fontWeight: FontWeight.w600,
    fontFamily: 'Quicksand',
    color: _highlightColor,
  );

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      clipBehavior: Clip.antiAlias,

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35.0),
          bottomLeft: Radius.circular(35.0),
        ),
      ),

      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: _blur, sigmaY: _blur),
        blendMode: BlendMode.srcOver,

        child: DecoratedBox(
          decoration: const BoxDecoration(
            color: Color(0xA0FFFFFF),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xAFFFFFFF),
                Color(0xA0FFFFFF),
                Color(0x90FFFFFF),
                Color(0x98FFFFFF),
              ],
            ),
          ),

          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: 310,
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        const Spacer(flex: 30),

                        const AppbarTextButton(text:'Accueil', route: '/home'),

                        const Spacer(flex: 15),

                        AppbarTextButton(
                            text: 'Inscription/Connexion', route: '/auth',
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Inscription/', style: _textStyle),
                                const SizedBox(height: 5),
                                Text('Connexion', style: _textStyle),
                              ],
                            )
                        ),

                        const Spacer(flex: 15),

                        DrawerTrialButton(),

                        const Spacer(flex: 30),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: 10,
                  left: 10,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },

                      padding: EdgeInsets.zero,

                      icon:  Icon(
                        Icons.arrow_forward_rounded,
                        color: _highlightColor,
                        size: 30,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ),
    );
  }
}