import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/utils.dart' show getScreenType;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _width = 300;
  double _height = 150;
  final double _verticalPosition = 70; // Variable pour ajuster la position verticale de l'image

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
    const double paddingValue = 12.0; // Constante pour l'espacement

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: verticalPosition / 3, bottom: verticalPosition / 10), // Utiliser la variable pour ajuster la position verticale
            child: Image.asset(
              'assets/images/image1.png',
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(paddingValue),
            child: Text(
              'Découvrez MyQuiz : votre compagnon d\'apprentissage personnalisé',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Couleur du texte en blanc
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: paddingValue, horizontal: paddingValue * 2),
            child: Text(
              'Bienvenue sur MyQuiz, l\'application conçue pour transformer votre expérience d\'apprentissage. Destinée aux étudiants du supérieur, MyQuiz vous offre un accès direct à des quiz personnalisés qui vous aident à renforcer vos connaissances et à mieux vous préparer pour vos examens. Grâce à des contenus spécialement élaborés par vos enseignants, vous pouvez réviser de manière ciblée et interactive.',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white, // Couleur du texte en blanc
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: paddingValue / 2),
            child: Image.asset(
              'assets/images/image2.png',
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(paddingValue),
            child: Text(
              'Des quiz personnalisés créés par vos enseignants',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Couleur du texte en blanc
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: paddingValue, horizontal: paddingValue * 2),
            child: Text(
              "Avec MyQuiz, les enseignants ont la possibilité de créer des quiz de manière simple et rapide. Ils peuvent soit générer des questions manuellement, soit utiliser notre intelligence artificielle pour créer des quiz à partir de documents PDF de leurs cours. Cette technologie permet de transformer le contenu des cours en questions pertinentes et adaptées au niveau de chaque étudiant, garantissant ainsi une expérience d'apprentissage optimisée.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white, // Couleur du texte en blanc
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: paddingValue / 2),
            child: Image.asset(
              'assets/images/image3.png',
              fit: BoxFit.cover,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(paddingValue),
            child: Text(
              'Améliorez vos résultats en toute simplicité',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Couleur du texte en blanc
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: paddingValue, horizontal: paddingValue * 2),
            child: Text(
              "MyQuiz est plus qu'un simple outil d'évaluation ; c'est un véritable atout pour maximiser vos performances académiques. En vous offrant des quiz accessibles à tout moment et sur n'importe quel appareil, MyQuiz vous permet de vous entraîner régulièrement et de mesurer vos progrès. Que vous soyez en déplacement ou à la maison, votre révision est à portée de main, vous aidant à atteindre vos objectifs académiques avec succès.",
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white, // Couleur du texte en blanc
              ),
            ),
          ),
          SizedBox(
            width: width,
            height: height,
            child: Form(
              key: formKey,
              child: const Column(
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
