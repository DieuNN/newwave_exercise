import 'package:flutter/material.dart';

class MovieFinderCasterCard extends StatelessWidget {
  const MovieFinderCasterCard(
      {Key? key,
      required this.source,
      required this.actorName,
      required this.characterName})
      : super(key: key);
  final String source;
  final String actorName;
  final String characterName;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 128,
      width: 50,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            child: Image.asset(
              source,
              width: 50,
              fit: BoxFit.cover,
              height: 50,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            actorName,
            style: TextStyle(
                color: Colors.white, fontFamily: "BeVietnamPro", fontSize: 8),
          ),
          SizedBox(
            height: 3,
          ),
          Text(
            characterName,
            style: TextStyle(
                color: Colors.grey, fontFamily: "BeVietnamPro", fontSize: 8),
          ),
        ],
      ),
    );
  }
}
