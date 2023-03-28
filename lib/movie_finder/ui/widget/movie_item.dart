import 'package:bt_c3/main.dart';
import 'package:flutter/material.dart';

class MovieItem extends StatelessWidget {
  final bool expanded;
  final String title;
  final num imdbScore;
  final String source;

  const MovieItem({
    Key? key,
    required this.expanded,
    required this.title,
    required this.imdbScore,
    required this.source,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expanded ? 328 : 145,
      height: expanded ? 141 : 214,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              source,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.grey.withOpacity(0.0), Colors.black],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
            expanded ? Positioned(
              bottom: 15,
              left: 26,
              right: 26,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontFamily: "BeVietnamPro",
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    width: 45,
                    height: 14,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: DecoratedBox(
                        decoration: const BoxDecoration(color: Colors.yellow),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              const Text(
                                "IMDb",
                                style: TextStyle(fontSize: 8),
                              ),
                              Text(
                                "$imdbScore",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 8,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ) : Positioned(child: Container()),
          ],
        ),
      ),
    );
  }
}
