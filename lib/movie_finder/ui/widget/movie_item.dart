import 'package:bt_c3/main.dart';
import 'package:bt_c3/movie_finder/ui/page/movie_detail_page.dart';
import 'package:bt_c3/movie_finder/ui/widget/imdb_tag.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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
    // Generate unique id for hero tag based on current time
    String heroTag = const Uuid().v1();
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MovieDetailPage(key: key, heroTag: heroTag),
          ),
        );
      },
      child: Hero(
        tag: heroTag,
        child: SizedBox(
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
                      colors: [
                        Colors.grey.shade50.withOpacity(0.0),
                        Colors.black.withOpacity(0.8)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.0, 1.0],
                    ),
                  ),
                ),
                expanded
                    ? Positioned(
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
                            ImdbTag(
                              imdbScore: imdbScore,
                              width: 45,
                              height: 14,
                              fontSize: 8,
                            )
                          ],
                        ),
                      )
                    : const Positioned(child: SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
