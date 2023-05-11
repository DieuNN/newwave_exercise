import 'package:bt_c3/main.dart';
import 'package:flutter/material.dart';

class MovieFinderOptionButtons extends StatelessWidget {
  const MovieFinderOptionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: SizedBox(
        width: 328,
        height: 95,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            optionButton("Genre", Icons.grid_view, () {}),
            optionButton("TV Series", Icons.tv, () {}),
            optionButton("Movie", Icons.movie, () {}),
            optionButton("In theaters", Icons.theaters, () {}),
          ],
        ),
      ),
    );
  }
}

Widget optionButton(String text,IconData icon, VoidCallback onTap) {
  return SizedBox(
    width: 69,
    height: 95,
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              HexColor.fromHex("#A6A1E0").withOpacity(0.3),
              HexColor.fromHex("#A1F3FE").withOpacity(0.3)
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: GestureDetector(
          onTap: onTap,
          child: Stack(
            children: [
              Center(
                child: Icon(icon, color: Colors.white, size: 42),
              ),
              Positioned(
                bottom: 14,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.white, fontSize: 9),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}
