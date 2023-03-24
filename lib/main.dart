import 'package:bt_c3/c3/c3.dart';
import 'package:bt_c3/c4/c4.dart';
import 'package:bt_c3/c4/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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
                Navigator.push(context, AppRoute.createPageRoute(const C3Screen()));
              },
              child: const Text("To C3"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, AppRoute.createPageRoute(const C4Screen()));
              },
              child: const Text("To C4"),
            ),
          ],
        ),
      ),
    );
  }
}



