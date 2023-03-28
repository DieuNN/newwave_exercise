import 'package:bt_c3/c4/routes/app_route.dart';
import 'package:bt_c3/c5/c5.dart';
import 'package:bt_c3/c5/ui/screens/c5_screen_1.dart';
import 'package:bt_c3/c5/ui/screens/c5_screen_2.dart';
import 'package:bt_c3/c5/ui/screens/c5_screen_3.dart';
import 'package:bt_c3/main.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class C5Screen4 extends StatelessWidget {
  const C5Screen4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> texts = logoPositions.map((e) => Text(e)).toList();
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
                    "assets/images/marvel/marvel_4.png",
                    width: MediaQuery.of(context).size.width,
                    height: 600,
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Column(
                      children: logoPositions
                          .map((e) => Text(
                                e,
                                style: const TextStyle(color: Colors.white),
                              ))
                          .toList(),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Column(
                        children: [
                          Image.asset("assets/images/marvel/marvel_logo.png"),
                          const SizedBox(
                            height: 137,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: () => validateForm(context),
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    side: const BorderSide(
                                        color: Colors.red, width: 3)),
                                child: const Text(
                                  "Continue",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validateForm(BuildContext context) {
    String textOne = textEditControllers["Screen1"]?.text ?? "";
    String textTwo = textEditControllers["Screen2"]?.text ?? "";
    String textThree = textEditControllers["Screen3"]?.text ?? "";
    if (textOne.isEmpty) {
      Fluttertoast.showToast(
        msg: "Text one is empty",
      );
      Navigator.push(
        context,
        AppRoute.createPageRoute(
          C5Screen1(
            popBack: true,
          ),
        ),
      );
      return;
    }

    if (textTwo.isEmpty) {
      Fluttertoast.showToast(
        msg: "Text two is empty",
      );
      Navigator.push(
        context,
        AppRoute.createPageRoute(
          C5Screen2(
            popBack: true,
          ),
        ),
      );
      return;
    }

    if (textThree.isEmpty) {
      Fluttertoast.showToast(
        msg: "Text three is empty",
      );
      Navigator.push(
        context,
        AppRoute.createPageRoute(
          C5Screen3(
            popBack: true,
          ),
        ),
      );
      return;
    }
    Fluttertoast.showToast(
      msg: "Login successfully",
    );
    Navigator.pushAndRemoveUntil(
      context,
      AppRoute.createPageRoute(const MyHomePage()),
      (route) => false,
    );
    // Clear TextEditController value
    textEditControllers["Screen1"] = TextEditingController();
    textEditControllers["Screen2"] = TextEditingController();
    textEditControllers["Screen3"] = TextEditingController();
  }
}
