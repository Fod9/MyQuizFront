import 'package:flutter/material.dart';
import '../helpers/Colors.dart';
import 'package:my_quiz_ap/helpers/utils.dart' show getScreenType;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _width = 300;
  double _height = 150;
  double _verticalPosition =
      70; // Variable pour ajuster la position verticale de l'image

  @override
  Widget build(BuildContext context) {
    String screenType = getScreenType(context);

    if (screenType == "mobile") {
      _width = MediaQuery.of(context).size.width * 0.8;
      _height = MediaQuery.of(context).size.height * 0.1;
    }

    return MobileDisplay(
        width: _width, height: _height, verticalPosition: _verticalPosition);
  }
}

class MobileDisplay extends StatelessWidget {
  MobileDisplay(
      {Key? key,
      required this.width,
      required this.height,
      required this.verticalPosition})
      : super(key: key);

  final double width;
  final double height;
  final double verticalPosition;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const double paddingValue = 16.0; // Constante pour l'espacement

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                top:
                    verticalPosition), // Utiliser la variable pour ajuster la position verticale
            child: Image.asset(
              'assets/images/image1.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: paddingValue),
            child: Text(
              'Pellentesque sit amet sapien fringilla, mattis ligula consectetur, ultrices mauris. Maecenas vitae mattis tellus. Nullam quis imperdiet augue. Vestibulum auctor ornare leo, non suscipit magna interdum eu. Curabitur pellentesque nibh nibh, at maximus ante fermentum sit amet.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white, // Couleur du texte en blanc
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: paddingValue),
            child: Image.asset(
              'assets/images/image2.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: paddingValue),
            child: Text(
              'Pellentesque sit amet sapien fringilla, mattis ligula consectetur, ultrices mauris. Maecenas vitae mattis tellus. Nullam quis imperdiet augue. Vestibulum auctor ornare leo, non suscipit magna interdum eu. Curabitur pellentesque nibh nibh, at maximus ante fermentum sit amet.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white, // Couleur du texte en blanc
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: paddingValue),
            child: Image.asset(
              'assets/images/image3.png',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: paddingValue),
            child: Text(
              'Pellentesque sit amet sapien fringilla, mattis ligula consectetur, ultrices mauris. Maecenas vitae mattis tellus. Nullam quis imperdiet augue. Vestibulum auctor ornare leo, non suscipit magna interdum eu. Curabitur pellentesque nibh nibh, at maximus ante fermentum sit amet.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white, // Couleur du texte en blanc
              ),
            ),
          ),
          Container(
            width: width,
            height: height,
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Ajoutez les autres widgets ici
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
