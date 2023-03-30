import 'dart:convert';

import 'package:bt_c3/main.dart';
import 'package:bt_c3/movie_finder/movie_constants.dart';
import 'package:bt_c3/movie_finder/ui/widget/app_bar.dart';
import 'package:bt_c3/movie_finder/ui/widget/bottom_navigation_bar.dart';
import 'package:bt_c3/movie_finder/ui/widget/movie_carousel.dart';
import 'package:bt_c3/movie_finder/ui/widget/option_buttons.dart';
import 'package:bt_c3/movie_finder/ui/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';
import 'package:http/http.dart' as http;

import 'model/movie_api_response.dart';

class MovieFinder extends StatefulWidget {
  const MovieFinder({Key? key}) : super(key: key);

  @override
  State<MovieFinder> createState() => _MovieFinderState();
}

class _MovieFinderState extends State<MovieFinder> {
  Future<MovieApiResponse?> movieResponseFuture = Future(() async {
    var response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/discover/movie?api_key=${MovieFinderConstants.apiKey}&page=1"));
    if (response.statusCode == 200) {
      var movieApiResponse =  MovieApiResponse.fromJson(jsonDecode(response.body));
      return movieApiResponse..results!.take(10);
    } else {
      return null;
    }
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: movieResponseFuture,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text("Error, ${snapshot.error}"),
          );
        }
        if (snapshot.hasData) {
          return ScaffoldGradientBackground(
            gradient: LinearGradient(
              colors: [
                HexColor.fromHex("#2B5876"),
                HexColor.fromHex("#4E4376"),
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            body: SafeArea(
              child: ListView(
                children: [
                  MovieFinderAppBar(onNotificationClick: () {}),
                  const SizedBox(
                    height: 20,
                  ),
                  MovieFinderSearchBar(
                    onSearch: () {},
                    onVoiceSearch: () {},
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: Text(
                      "Most Popular",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "BeVietnamPro",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MovieCarousel(
                    expaned: true,
                    key: UniqueKey(),
                    movieList: snapshot.data!.results!.take(10).toList(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const MovieFinderOptionButtons(),
                  const SizedBox(
                    height: 35,
                  ),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: Text(
                      "Upcoming releases",
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: "BeVietnamPro",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MovieCarousel(
                    movieList: snapshot.data!.results!.take(10).toList(),
                    expaned: false,
                    key: UniqueKey(),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
            bottomNavigationBar: const MovieFinderBottomBar(),
          );
        }
        return const Center(
          child: Text("Fetching ...."),
        );
      },
    );
  }
}
