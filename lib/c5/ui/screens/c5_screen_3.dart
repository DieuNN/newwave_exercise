import 'package:bt_c3/c4/routes/app_route.dart';
import 'package:bt_c3/c5/c5.dart';
import 'package:bt_c3/c5/ui/screens/c5_screen_4.dart';
import 'package:bt_c3/main.dart';
import 'package:flutter/material.dart';

class C5Screen3 extends StatelessWidget {
  final bool popBack;

  C5Screen3({Key? key, this.popBack = false}) : super(key: key);
  final TextEditingController editingController =
      textEditControllers["Screen3"] ?? TextEditingController();

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
                    "assets/images/marvel/marvel_3.png",
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
                              "Create profiles for different members & get personalised recommendations",
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
                      }
                      Navigator.push(
                        context,
                        AppRoute.createPageRoute(
                          const C5Screen4(),
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
