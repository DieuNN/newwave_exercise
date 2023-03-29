import 'package:bt_c3/main.dart';
import 'package:bt_c3/movie_finder/ui/widget/caster_card.dart';
import 'package:bt_c3/movie_finder/ui/widget/category_chip.dart';
import 'package:bt_c3/movie_finder/ui/widget/imdb_tag.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MovieDetailPanel extends StatelessWidget {
  const MovieDetailPanel(
      {Key? key, required this.scrollController, required this.panelController})
      : super(key: key);
  final ScrollController scrollController;
  final PanelController panelController;


  @override
  Widget build(BuildContext context) {
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
              const Center(
                child: SizedBox(
                  width: 30,
                  height: 5,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Center(
                child: Text(
                  "this is a long line",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 60,
                    fontFamily: "BeVietnamPro",
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      CategoryChip(category: "Action"),
                      SizedBox(
                        width: 10,
                      ),
                      CategoryChip(category: "+20"),
                      SizedBox(
                        width: 10,
                      ),
                      ImdbTag(
                        imdbScore: 10,
                        width: 64,
                        height: 32,
                        fontSize: 12,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
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
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              const ReadMoreText(
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
                trimLines: 3,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontFamily: "BeVietnamPro",
                ),
              ),
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
              Center(
                child: Wrap(
                  spacing: 20,
                  children: List.filled(
                    5,
                    const MovieFinderCasterCard(
                        source: "assets/images/img_1.jpg",
                        actorName: "Actor name",
                        characterName: "Character"),
                  ).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
