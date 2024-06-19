import 'package:flutter/material.dart';
import 'dart:ui' show Clip, Color, FontWeight, ImageFilter, Radius;

class MyQuizEndDrawer extends StatelessWidget {
  const MyQuizEndDrawer({
    super.key,
  });

  final Color _highlightColor = const Color(0xFF685374);

  final double _blur = 10.0;
  TextStyle get _textStyle => TextStyle(
    fontSize: 24,
    height: 1.2,
    fontWeight: FontWeight.w600,
    fontFamily: 'Quicksand',
    color: _highlightColor,
  );

  MaterialButton _drawerButton(
      BuildContext context,
      String text,
      String route,
      {
        Widget? child,
      }
  ) => MaterialButton(
    onPressed: () {
      // TODO Navigator.of(context).pushNamedAndRemoveUntil(route, (route) => false);
    },

    color: const Color(0x00000000),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),

    elevation: 0,
    highlightElevation: 0,
    hoverElevation: 0.5,
    hoverColor: const Color(0xFFFFFFFF),
    highlightColor: const Color(0x60FFFFFF),
    splashColor: const Color(0x60FFFFFF),

    child: child ?? Text(
      text,
      style: _textStyle,
    ),
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
                  
                        const Spacer(flex: 30,),
                  
                        _drawerButton(context, 'Accueil', '/home'),
                  
                        const Spacer(flex: 15,),
                  
                        _drawerButton(context,
                            'Inscription/Connexion', '/auth',
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Inscription/', style: _textStyle),
                                const SizedBox(height: 5),
                                Text('Connexion', style: _textStyle),
                              ],
                            )
                        ),
                  
                        const Spacer(flex: 15,),
                  
                        MaterialButton(
                          onPressed: () {
                            // Navigator.of(context).pushNamed('/home');
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
                            style: _textStyle.copyWith(
                              color: const Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                  
                        const Spacer(flex: 30,),
                      ],
                    ),
                  ),
                ),

                Positioned(
                  top: 5,
                  left: 5,
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