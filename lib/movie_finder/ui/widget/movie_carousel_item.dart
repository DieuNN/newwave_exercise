import 'dart:developer';
import 'dart:ui';

import 'package:bt_c3/movie_finder/model/movie.dart';
import 'package:bt_c3/movie_finder/ui/page/movie_detail_page.dart';
import 'package:bt_c3/movie_finder/ui/widget/imdb_tag.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class MovieCarouselItem extends StatelessWidget {
  final bool expanded;
  final Movie movie;
  final bool active;

  const MovieCarouselItem({
    Key? key,
    required this.expanded,
    required this.movie,
    required this.active,
  }) : super(key: key);

  void navigateToDetailPage(context, heroTag) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MovieDetailPage(
          key: key,
          heroTag: heroTag,
          movie: movie,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Generate unique id for hero tag based on current time
    String heroTag = const Uuid().v1();
    log(active.toString());

    return GestureDetector(
      onTap: () => navigateToDetailPage(context, heroTag),
      child: carouselItem(heroTag),
    );
  }

  Widget carouselItem(heroTag) {
    final double opacityAmount = active ? 1 : 0.5;
    return Hero(
      tag: heroTag,
      child: SizedBox(
        width: expanded ? 328 : 145,
        height: expanded ? 141 : 214,
        child: Opacity(
          opacity: opacityAmount,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Stack(
              fit: StackFit.expand,
              children: [
                expanded
                    ? Image.network(
                        "https://image.tmdb.org/t/p/w500/${movie.backdropPath}",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset("assets/images/no_image.png"),
                      )
                    : Image.network(
                        "https://image.tmdb.org/t/p/w500/${movie.posterPath}",
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Image.asset("assets/images/no_image.png"),
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
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                movie.title ?? "Unknown",
                                style: const TextStyle(
                                  fontFamily: "BeVietnamPro",
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                            ),
                            ImdbTag(
                              imdbScore: movie.voteAverage ?? 0.0,
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
