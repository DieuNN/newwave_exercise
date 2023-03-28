import 'package:bt_c3/c3/c3.dart';
import 'package:bt_c3/c4/c4.dart';
import 'package:bt_c3/c4/routes/app_route.dart';
import 'package:bt_c3/movie_finder/movie_finder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'c5/c5.dart';

void main() {
  runApp(const MyApp());
}

// Get system theme
final ValueNotifier<ThemeMode> notifier = ValueNotifier(
    SchedulerBinding.instance.platformDispatcher.platformBrightness ==
            Brightness.light
        ? ThemeMode.light
        : ThemeMode.dark);
late ThemeMode currentTheme;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: notifier,
      builder: (BuildContext context, ThemeMode value, Widget? child) {
        currentTheme = value;
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: value,
          home: const MyHomePage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, AppRoute.createPageRoute(const C3Screen()));
              },
              child: const Text("To C3"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, AppRoute.createPageRoute(const C4Screen()));
              },
              child: const Text("To C4"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, AppRoute.createPageRoute(const C5Screen()));
              },
              child: const Text("To C5"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context, AppRoute.createPageRoute(const MovieFinder()));
              },
              child: const Text("Movie finder"),
            ),
          ],
        ),
      ),
    );
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
