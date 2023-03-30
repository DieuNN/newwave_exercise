import 'dart:convert';

import 'package:bt_c3/main.dart';
import 'package:bt_c3/movie_finder/model/movie_cast_api_response.dart';
import 'package:bt_c3/movie_finder/model/movie_primary_info_api_response.dart';
import 'package:bt_c3/movie_finder/movie_constants.dart';
import 'package:bt_c3/movie_finder/ui/widget/caster_card.dart';
import 'package:bt_c3/movie_finder/ui/widget/category_chip.dart';
import 'package:bt_c3/movie_finder/ui/widget/imdb_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:readmore/readmore.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:http/http.dart' as http;

import '../../model/movie.dart';

class MovieDetailPanel extends StatelessWidget {
  final Movie movie;

  const MovieDetailPanel(
      {Key? key,
      required this.scrollController,
      required this.panelController,
      required this.movie})
      : super(key: key);
  final ScrollController scrollController;
  final PanelController panelController;

  @override
  Widget build(BuildContext context) {
    Future<MoviePrimaryInfoApiResponse?> moviePrimaryInfoApiResponse =
        Future(() async {
      final response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/movie/${movie.id}?api_key=${MovieFinderConstants.apiKey}&language=en-US"));
      if (response.statusCode == 200) {
        return MoviePrimaryInfoApiResponse.fromJson(jsonDecode(response.body));
      }
      return null;
    });

    Future<MovieCastApiResponse?> movieCastApiResponse = Future(() async {
      final response = await http.get(Uri.parse(
          "https://api.themoviedb.org/3/movie/${movie.id}/credits?api_key=${MovieFinderConstants.apiKey}"));
      if (response.statusCode == 200) {
        return MovieCastApiResponse.fromJson(jsonDecode(response.body));
      }
      return null;
    });
    return Container(
      // height: MediaQuery.of(context).size,
      height: 1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [HexColor.fromHex("2B5876"), HexColor.fromHex("4E4376")],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              slideUpButton(),
              const SizedBox(
                height: 16,
              ),
              title(),
              const SizedBox(
                height: 28,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      categoryTags(moviePrimaryInfoApiResponse),
                      const SizedBox(
                        width: 10,
                      ),
                      imdbTag(),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                  Row(
                    children: shareButtons(),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              descriptionText(),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Cast",
                    style: TextStyle(
                      fontFamily: 'BeVietnamPro',
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "See all",
                    style: TextStyle(
                      fontFamily: 'BeVietnamPro',
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              castingGrid(movieCastApiResponse),
            ],
          ),
        ),
      ),
    );
  }

  Widget slideUpButton() {
    return const Center(
      child: SizedBox(
        width: 30,
        height: 5,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget title() {
    return Center(
      child: Text(
        movie.title ?? "Unknown",
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 60,
          fontFamily: "BeVietnamPro",
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  List<Widget> shareButtons() {
    return [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.share_outlined,
          color: Colors.white,
        ),
      ),
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.favorite_border,
          color: Colors.white,
        ),
      )
    ];
  }

  Widget imdbTag() {
    return ImdbTag(
      imdbScore: movie.voteAverage ?? 0.0,
      width: 64,
      height: 32,
      fontSize: 12,
    );
  }

  Widget castingGrid(Future<MovieCastApiResponse?> movieCastApiResponse) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const SizedBox(
            height: 0,
          );
        }
        if (snapshot.hasData) {
          return Center(
            child: Wrap(
              spacing: 20,
              children: snapshot.data!.cast!
                  .take(10)
                  .map(
                    (e) => MovieFinderCasterCard(
                      source: e.profilePath,
                      actorName: e.name ?? "No name",
                      characterName: e.character ?? "Unknown",
                    ),
                  )
                  .toList(),
            ),
          );
        }
        return const SizedBox(
          height: 0,
        );
      },
      future: movieCastApiResponse,
    );
  }

  Widget descriptionText() {
    return ReadMoreText(
      movie.overview ?? "No description provided!",
      trimLines: 3,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontFamily: "BeVietnamPro",
      ),
    );
  }

  Widget categoryTags(
      Future<MoviePrimaryInfoApiResponse?> moviePrimaryInfoApiResponse) {
    return FutureBuilder(
      future: moviePrimaryInfoApiResponse,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const SizedBox(
            width: 0,
          );
        }
        if (snapshot.hasData) {
          return Row(
            children: [
              // Todo: Find by category?
              CategoryChip(
                category: snapshot.data!.genres!.first.name ?? "Unknown",
                onChipTap: () {},
              ),
              CategoryChip(
                category: "+${movie.genreIds!.length - 1}",
                onChipTap: ()=> showAllCategoriesDialog(context, snapshot),
              ),
            ],
          );
        }
        return const SizedBox(
          width: 0,
        );
      },
    );
  }

  void showAllCategoriesDialog(BuildContext context,AsyncSnapshot<MoviePrimaryInfoApiResponse?> snapshot) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          insetPadding: EdgeInsets.zero,
          shape:  const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          content: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [HexColor.fromHex("2B5876"), HexColor.fromHex("4E4376")],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(32)),
            ),
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 20,
              children: snapshot.data!.genres!
                  .map(
                    (item) =>
                    CategoryChip(category: item.name!),
              )
                  .toList(),
            ),
          ),
        );
      },
      animationType: DialogTransitionType.size,
      curve: Curves.fastOutSlowIn,
      duration: const Duration(milliseconds: 500),
    );
  }
}
