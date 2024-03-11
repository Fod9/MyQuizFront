import "package:flutter/material.dart";
import "package:my_quiz_ap/helpers/Colors.dart";

class MatiereBlock extends StatefulWidget {
  const MatiereBlock({super.key, this.matiere_name, required this.height, required this.width});

  final String? matiere_name;
  final double height;
  final double width;

  @override
  State<MatiereBlock> createState() => _MatiereBlockState();
}

class _MatiereBlockState extends State<MatiereBlock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: const EdgeInsets.all(10),
      child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: darkGlass,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(30),
              child: InkWell(
                borderRadius: BorderRadius.circular(30),
                onTap: () {
                  print("Matiere clicked");
                },
                splashColor: Colors.black26,
                child: Center(
                  child: Text(
                    widget.matiere_name!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
