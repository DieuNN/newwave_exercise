import 'package:bt_c3/c4/routes/app_route.dart';
import 'package:bt_c3/c5/c5.dart';
import 'package:bt_c3/c5/ui/screens/c5_screen_2.dart';
import 'package:bt_c3/main.dart';
import 'package:flutter/material.dart';

class C5Screen1 extends StatelessWidget {
  final bool popBack;
  final GlobalKey _key = GlobalKey();

  C5Screen1({Key? key, this.popBack = false}) : super(key: key);
  final TextEditingController editingController =
      textEditControllers["Screen1"] ?? TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.asset(
                    "assets/images/marvel/marvel_1.png",
                    width: MediaQuery.of(context).size.width,
                    height: 600,
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/marvel/marvel_logo.png",
                            key: _key,
                          ),
                          const SizedBox(
                            height: 42,
                          ),
                          TextField(
                            controller: editingController,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            style: const TextStyle(color: Colors.black),
                          ),
                          const SizedBox(
                            height: 38,
                          ),
                          const Padding(
                            padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                            child: Text(
                              "All your favourite MARVEL Movies & Series at one place",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: () {
                      if (popBack) {
                        Navigator.pop(context, editingController);
                        return;
                      }
                      RenderBox box =
                          _key.currentContext?.findRenderObject() as RenderBox;
                      Offset position = box.localToGlobal(Offset.zero);
                      logoPositions
                          .add("Screen 1: X:${position.dx};Y:${position.dy}");

                      Navigator.push(
                        context,
                        AppRoute.createPageRoute(
                          C5Screen2(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: HexColor.fromHex("#ED1B24"),
                    ),
                    child: const Text(
                      "Continue",
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
