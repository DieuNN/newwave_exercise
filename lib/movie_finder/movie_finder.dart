import 'package:bt_c3/main.dart';
import 'package:bt_c3/movie_finder/ui/page/movie_detail_page.dart';
import 'package:bt_c3/movie_finder/ui/widget/app_bar.dart';
import 'package:bt_c3/movie_finder/ui/widget/bottom_navigation_bar.dart';
import 'package:bt_c3/movie_finder/ui/widget/movie_carousel.dart';
import 'package:bt_c3/movie_finder/ui/widget/movie_item.dart';
import 'package:bt_c3/movie_finder/ui/widget/option_buttons.dart';
import 'package:bt_c3/movie_finder/ui/widget/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

class MovieFinder extends StatefulWidget {
  const MovieFinder({Key? key}) : super(key: key);

  @override
  State<MovieFinder> createState() => _MovieFinderState();
}

class _MovieFinderState extends State<MovieFinder> {
  @override
  Widget build(BuildContext context) {
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
              expaned: false,
              key: UniqueKey(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const MovieFinderBottomBar(),
    );
  }
}
