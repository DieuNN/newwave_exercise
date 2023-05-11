import 'package:bt_c3/main.dart';
import 'package:flutter/material.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

class MovieFinderAppBar extends StatelessWidget {
  final VoidCallback onNotificationClick;

  const MovieFinderAppBar({super.key, required this.onNotificationClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(64, 32, 64, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 18,
                fontFamily: "BeVietnamPro",
              ),
              children: [
                TextSpan(text: "Hello,"),
                TextSpan(text: " "),
                TextSpan(
                  text: "User",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          IconButton(
            onPressed: onNotificationClick,
            icon: const Icon(
              Icons.notifications_outlined,
              color: Colors.white,
            ),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          )
        ],
      ),
    );
  }

// MovieFinderAppBar({required this.onNotificationClick, super.key})
//     : super(
//         backgroundColor: Colors.transparent,
//         shadowColor: Colors.transparent,
//         automaticallyImplyLeading: false,
//         title:
//         actions: [
//
//         ],
//       );
}
