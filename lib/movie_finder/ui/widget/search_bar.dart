import 'package:flutter/material.dart';

class MovieFinderSearchBar extends StatelessWidget {
  final VoidCallback onSearch;
  final VoidCallback onVoiceSearch;

  const MovieFinderSearchBar(
      {Key? key, required this.onSearch, required this.onVoiceSearch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
      child: TextField(
        onEditingComplete: onSearch,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color.fromRGBO(255, 255, 255, 0.2),
          hintText: "Search",
          hintStyle: const TextStyle(
              fontWeight: FontWeight.w400, color: Colors.grey, fontSize: 18, fontFamily: "BeVietnamPro"),
          prefixIcon: IconButton(
            icon: const Icon(Icons.search),
            color: Colors.white,
            onPressed: onSearch,
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.mic),
            color: Colors.white,
            onPressed: onVoiceSearch,
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white, width: 1),
              borderRadius: BorderRadius.all(Radius.circular(15))),
        ),
        cursorColor: Colors.white,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
