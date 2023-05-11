
import 'package:bt_c3/main.dart';
import 'package:bt_c3/movie_finder/model/movie_cast_api_response.dart';
import 'package:bt_c3/movie_finder/model/movie_primary_info_api_response.dart';
import 'package:bt_c3/movie_finder/movie_finder_provider.dart';
import 'package:bt_c3/movie_finder/ui/widget/caster_card.dart';
import 'package:bt_c3/movie_finder/ui/widget/category_chip.dart';
import 'package:bt_c3/movie_finder/ui/widget/imdb_tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../model/movie.dart';

class MovieDetailPanel extends StatefulWidget {
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
  State<MovieDetailPanel> createState() => _MovieDetailPanelState();
}

class _MovieDetailPanelState extends State<MovieDetailPanel> {
  @override
  void initState() {
    Provider.of<MovieFinderProvider>(context, listen: false)
        .loadCast(widget.movie);
    Provider.of<MovieFinderProvider>(context, listen: false)
        .loadCategory(widget.movie);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // if not loaded
        if (!Provider.of<MovieFinderProvider>(context, listen: true)
                .isMovieCastLoaded ||
            !Provider.of<MovieFinderProvider>(context, listen: true)
                .isMoviePrimaryInfoLoaded ||
            Provider.of<MovieFinderProvider>(context, listen: true)
                    .moviePrimaryInfoApiResult ==
                null ||
            Provider.of<MovieFinderProvider>(context, listen: true)
                    .movieCastApiResult ==
                null) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  HexColor.fromHex("2B5876"),
                  HexColor.fromHex("4E4376")
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: const [
                Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        }
        return Container(
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
            controller: widget.scrollController,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildSlideUpButton(),
                  const SizedBox(
                    height: 16,
                  ),
                  _buildTitle(),
                  const SizedBox(
                    height: 28,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _buildCategoryTags(
                              context
                                  .watch<MovieFinderProvider>()
                                  .moviePrimaryInfoApiResult!,
                              context),
                          const SizedBox(
                            width: 10,
                          ),
                          _buildImdbTag(),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                      Row(
                        children: _buildShareButtons(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  _buildDescriptionText(),
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
                  _buildCastingGrid(
                      context.watch<MovieFinderProvider>().movieCastApiResult!),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSlideUpButton() {
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

  Widget _buildTitle() {
    return Center(
      child: Text(
        widget.movie.title ?? "Unknown",
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

  List<Widget> _buildShareButtons() {
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

  Widget _buildImdbTag() {
    return ImdbTag(
      imdbScore: widget.movie.voteAverage ?? 0.0,
      width: 64,
      height: 32,
      fontSize: 12,
    );
  }

  Widget _buildCastingGrid(MovieCastApiResponse movieCastApiResult) {
    return Center(
      child: Wrap(
        spacing: 20,
        children: movieCastApiResult.cast!
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

  Widget _buildDescriptionText() {
    return ReadMoreText(
      widget.movie.overview ?? "No description provided!",
      trimLines: 3,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontFamily: "BeVietnamPro",
      ),
    );
  }

  Widget _buildCategoryTags(
      MoviePrimaryInfoApiResponse moviePrimaryInfoApiResult, context) {
    return Row(
      children: [
        // Todo: Find by category?
        CategoryChip(
          category: moviePrimaryInfoApiResult.genres!.first.name ?? "Unknown",
          onChipTap: () {},
        ),
        CategoryChip(
          category: "+${widget.movie.genreIds!.length - 1}",
          onChipTap: () =>
              _showAllCategoriesDialog(context, moviePrimaryInfoApiResult),
        ),
      ],
    );
  }

  void _showAllCategoriesDialog(
      BuildContext context, MoviePrimaryInfoApiResponse categories) {
    showAnimatedDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          insetPadding: const EdgeInsets.all(16),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          content: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  HexColor.fromHex("2B5876"),
                  HexColor.fromHex("4E4376")
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(32)),
            ),
            padding: const EdgeInsets.all(16),
            child: Wrap(
              spacing: 20,
              children: categories.genres!
                  .map(
                    (item) => CategoryChip(category: item.name!),
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
