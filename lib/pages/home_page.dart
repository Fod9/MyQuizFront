import 'package:flutter/material.dart';
import 'package:my_quiz_ap/helpers/utils.dart' show getScreenType;
import '../helpers/Colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double _width = 300;
  double _height = 150;
  final double _verticalPosition = 70;

  @override
  Widget build(BuildContext context) {
    String screenType = getScreenType(context);

    if (screenType == "desktop") {
      _width = 410;
      _height = 140;
      return const DesktopDisplay();
    } else {
      _width = MediaQuery.of(context).size.width * 0.8;
      _height = MediaQuery.of(context).size.height * 0.1;
      return MobileDisplay(
          width: _width, height: _height, verticalPosition: _verticalPosition
      );
    }
  }
}

class ContentRow extends StatelessWidget {
  final String text;
  final String description;
  final String imagePath;
  final bool isImageFirst;

  const ContentRow({
    super.key,
    required this.text,
    required this.description,
    required this.imagePath,
    this.isImageFirst = false,
  });

  @override
  Widget build(BuildContext context) {
    const double paddingValue = 12.0;

    Widget textColumn = Expanded(
      flex: 2,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: paddingValue, horizontal: paddingValue * 5),
            child: Text(
              description,
              textAlign: TextAlign.justify,
              style: const TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );

    Widget imageColumn = Expanded(
      flex: 2,
      child: Image.asset(
        imagePath,
        fit: BoxFit.cover,
        scale: 0.5,
      ),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
      child: Row(
        children: isImageFirst
            ? [imageColumn, textColumn]
            : [textColumn, imageColumn],
      ),
    );
  }
}

class DesktopDisplay extends StatelessWidget {
  const DesktopDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        child: Column(
          children: [
            const ContentRow(
              text: 'Découvrez MyQuiz : votre compagnon d\'apprentissage',
              description:
              'Bienvenue sur MyQuiz, l\'application conçue pour transformer votre expérience d\'apprentissage. Destinée aux étudiants du supérieur, MyQuiz vous offre un accès direct à des quiz personnalisés qui vous aident à renforcer vos connaissances et à mieux vous préparer pour vos examens. Grâce à des contenus spécialement élaborés par vos enseignants, vous pouvez réviser de manière ciblée et interactive.',
              imagePath: 'assets/images/image1.png',
              isImageFirst: false,
            ),
            Stack(
              children: [
                ClipPath(
                  clipper: DiagonalClipper(),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.7,
                    color: darkGlass,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 60.0),
                  child: ContentRow(
                    text: 'Des quiz personnalisés créés par vos enseignants',
                    description:
                    "Avec MyQuiz, les enseignants ont la possibilité de créer des quiz de manière simple et rapide. Ils peuvent soit générer des questions manuellement, soit utiliser notre intelligence artificielle pour créer des quiz à partir de documents PDF de leurs cours. Cette technologie permet de transformer le contenu des cours en questions pertinentes et adaptées au niveau de chaque étudiant, garantissant ainsi une expérience d'apprentissage optimisée.",
                    imagePath: 'assets/images/image2.png',
                    isImageFirst: true,
                  ),
                ),
              ],
            ),
            const ContentRow(
              text: 'Améliorez vos résultats en toute simplicité',
              description:
              "MyQuiz est plus qu'un simple outil d'évaluation ; c'est un véritable atout pour maximiser vos performances académiques. En vous offrant des quiz accessibles à tout moment et sur n'importe quel appareil, MyQuiz vous permet de vous entraîner régulièrement et de mesurer vos progrès. Que vous soyez en déplacement ou à la maison, votre révision est à portée de main, vous aidant à atteindre vos objectifs académiques avec succès.",
              imagePath: 'assets/images/image3.png',
              isImageFirst: false,
            ),
          ],
        ),
      ),
    );
  }
}

class MobileDisplay extends StatelessWidget {
  MobileDisplay(
      {super.key,
        required this.width,
        required this.height,
        required this.verticalPosition});

  final double width;
  final double height;
  final double verticalPosition;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    const double paddingValue = 12.0;

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
              'Découvrez MyQuiz : votre compagnon d\'apprentissage',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
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
                color: Colors.white,
              ),
            ),
          ),
          Stack(
            children: [
              ClipPath(
                clipper: DiagonalClipper(),
                child: Container(
                  width: double.infinity,
                  height: 750,
                  color: darkGlass,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: paddingValue * 5),
                child: Column(
                  children: [
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
                          color: Colors.white,
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
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
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
                color: Colors.white,
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
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: height / 1.5,
          )
        ],
      ),
    );
  }
}

class DiagonalClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.1);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height * 0.9);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

