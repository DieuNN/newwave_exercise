import 'package:bt_c3/main.dart';
import 'package:flutter/material.dart';

class MovieFinderBottomBar extends StatelessWidget {
  const MovieFinderBottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [HexColor.fromHex("#2B6476"), HexColor.fromHex("#4E4376")],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight
        ),
      ),
      child: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.airplane_ticket),
            label: "Ticket",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Person",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shuffle),
            label: "Shuffle",
          ),
        ],
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 1,
      ),
    );
  }
}
