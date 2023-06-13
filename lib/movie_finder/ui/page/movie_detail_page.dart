import 'package:bt_c3/movie_finder/movie_finder_provider.dart';
import 'package:bt_c3/movie_finder/ui/widget/movie_detail_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../model/movie.dart';

class MovieDetailPage extends StatefulWidget {
  final Object heroTag;
  final Movie movie;

  const MovieDetailPage({Key? key, required this.heroTag, required this.movie})
      : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    final double panelMinHeight = MediaQuery.of(context).size.height * 0.3;
    final double panelMaxHeight = MediaQuery.of(context).size.height * 1;
    final PanelController panelController = PanelController();
    return Scaffold(
      body: Stack(
        children: [
          SlidingUpPanel(
            minHeight: panelMinHeight,
            maxHeight: panelMaxHeight,
            controller: panelController,
            renderPanelSheet: true,
            body: Hero(
              tag: widget.heroTag,
              child: Image.network(
                widget.movie.backdropPath == null
                    ? "https://image.tmdb.org/t/p/w500/${widget.movie.backdropPath}"
                    : "https://image.tmdb.org/t/p/w500/${widget.movie.posterPath}",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.7,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Image.asset("assets/images/no_image.png"),
              ),
            ),
            panelBuilder: (panelBuilderContext) => ChangeNotifierProvider(
              create: (BuildContext context) => MovieFinderProvider(),
              child: MovieDetailPanel(
                scrollController: scrollController,
                panelController: panelController,
                movie: widget.movie,
              ),
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
            parallaxEnabled: true,
            parallaxOffset: 0.5,
          ),
          Positioned(
            top: 16,
            left: 8,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
