import 'package:flutter/material.dart';

class MovieFinderCasterCard extends StatelessWidget {
  const MovieFinderCasterCard(
      {Key? key,
      required this.source,
      required this.actorName,
      required this.characterName})
      : super(key: key);
  final String? source;
  final String actorName;
  final String characterName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 128,
      width: 50,
      child: Column(
        children: [
          casterCardImage(),
          const SizedBox(
            height: 8,
          ),
          actorNameText(),
          const SizedBox(
            height: 3,
          ),
          characterNameText(),
        ],
      ),
    );
  }

  Widget characterNameText() {
    return Text(
      characterName,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.grey,
        fontFamily: "BeVietnamPro",
        fontSize: 10,
      ),
      maxLines: 3,
      overflow: TextOverflow.fade,
    );
  }

  Widget actorNameText() {
    return Text(
      actorName,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontFamily: "BeVietnamPro",
        fontSize: 10,
      ),
      overflow: TextOverflow.fade,
      maxLines: 3,
    );
  }

  Widget casterCardImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(15)),
      child: source != null
          ? Image.network(
              "https://image.tmdb.org/t/p/w500/$source",
              width: 50,
              fit: BoxFit.cover,
              height: 50,
            )
          : Image.asset(
              "assets/images/no_image.png",
              width: 50,
              fit: BoxFit.cover,
              height: 50,
            ),
    );
  }
}
