import 'package:bt_c3/main.dart';
import 'package:bt_c3/movie_finder/movie_finder_provider.dart';
import 'package:bt_c3/movie_finder/ui/widget/app_bar.dart';
import 'package:bt_c3/movie_finder/ui/widget/bottom_navigation_bar.dart';
import 'package:bt_c3/movie_finder/ui/widget/movie_carousel.dart';
import 'package:bt_c3/movie_finder/ui/widget/option_buttons.dart';
import 'package:bt_c3/movie_finder/ui/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

class MovieFinder extends StatefulWidget {
  const MovieFinder({Key? key}) : super(key: key);

  @override
  State<MovieFinder> createState() => _MovieFinderState();
}

class _MovieFinderState extends State<MovieFinder> {
  @override
  void initState() {
    Provider.of<MovieFinderProvider>(context, listen: false).loadMovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!context.watch<MovieFinderProvider>().isMovieApiLoaded &&
        context.watch<MovieFinderProvider>().movieApiResult == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: const [
          CircularProgressIndicator(),
        ],
      );
    }
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
              movieList: context
                  .watch<MovieFinderProvider>()
                  .movieApiResult!
                  .results!
                  .take(10)
                  .toList(),
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
              movieList: context
                  .watch<MovieFinderProvider>()
                  .movieApiResult!
                  .results!
                  .take(10)
                  .toList(),
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
}
