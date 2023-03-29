import 'package:bt_c3/movie_finder/ui/widget/movie_detail_panel.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MovieDetailPage extends StatelessWidget {
  final Object heroTag;

  const MovieDetailPage({Key? key, required this.heroTag}) : super(key: key);

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
            tag: heroTag,
            child: Image.asset(
              "assets/images/img_1.jpg",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.7,
              fit: BoxFit.cover,
            ),
          ),
          panelBuilder: (panelBuilderContext) => MovieDetailPanel(
              scrollController: scrollController,
              panelController: panelController),
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
    ));
  }
}
