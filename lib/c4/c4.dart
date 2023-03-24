import 'package:bt_c3/c4/features/c4_feature3.dart';
import 'package:bt_c3/c4/features/c4_feature1.dart';
import 'package:bt_c3/c4/features/c4_feature2.dart';
import 'package:bt_c3/c4/features/c4_feature4.dart';
import 'package:flutter/material.dart';

import 'routes/app_route.dart';

class C4Screen extends StatelessWidget {
  const C4Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, AppRoute.createPageRoute(const C4Feature1()));
                },
                child: const Text("Feature 1"),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, AppRoute.createPageRoute(const C4Feature2()));
                },
                child: const Text("Feature 2"),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, AppRoute.createPageRoute(const C4Feature3()));
                },
                child: const Text("Feature 3"),
              ),
              const SizedBox(
                height: 8,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context, AppRoute.createPageRoute(const C4Feature4()));
                },
                child: const Text("Feature 4"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class C4Const {
  static const String imageUrl =
      "https://blog.logrocket.com/wp-content/uploads/2021/04/Building-Flutter-desktop-app-tutorial-examples.png";
  static const String youtubeVideoUrl = "https://www.youtube.com/watch?v=YBRkVCRP1Gw";
  static const String githubVideoUrl = "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4";
}
