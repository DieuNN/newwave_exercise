import 'package:flutter/material.dart';

class ImdbTag extends StatelessWidget {
  const ImdbTag({Key? key, required this.imdbScore, required this.width, required this.height, required this.fontSize}) : super(key: key);
  final num imdbScore;
  final double width;
  final double height;
  final double fontSize;
  // w45 h14 fs8

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: DecoratedBox(
          decoration: const BoxDecoration(color: Colors.yellow),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                 Text(
                  "IMDb",
                  style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold),
                ),
                Text(
                  "$imdbScore",
                  style:  TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: fontSize,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
