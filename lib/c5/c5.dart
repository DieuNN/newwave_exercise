import 'package:bt_c3/c5/ui/screens/c5_screen_1.dart';
import 'package:flutter/widgets.dart';

class C5Screen extends StatelessWidget {
  const C5Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return C5Screen1();
  }
}

Map<String, TextEditingController> textEditControllers = {
  "Screen1": TextEditingController(),
  "Screen2": TextEditingController(),
  "Screen3": TextEditingController(),
};

Set<String> logoPositions = {};
