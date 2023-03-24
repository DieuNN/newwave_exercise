import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class C4Feature1 extends StatelessWidget {
  const C4Feature1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [
      itemRow(
          title: "FAQ",
          assetName: "assets/images/Image/FAQ/FAQ@3x.png",
          assetType: AssetType.jpeg),
      itemRow(
          title: "Group",
          assetName: "assets/images/Image/Groups/Group@3x.png",
          assetType: AssetType.jpeg),
      itemRow(
          title: "Term",
          assetName: "assets/images/Image/Terms/terms@3x.png",
          assetType: AssetType.jpeg),
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) => rows[index],
            itemCount: rows.length,
            separatorBuilder: (context, index) => const SizedBox(
              height: 8,
            ),
          ),
        ),
      ),
    );
  }
}

Widget itemRow(
    {required String title,
    required String assetName,
    required AssetType assetType}) {
  Widget icon;
  switch (assetType) {
    case AssetType.jpeg:
      icon = Image(
        image: AssetImage(assetName),
        width: 32,
        height: 32,
      );
      break;
    case AssetType.svg:
      icon = SvgPicture.asset(
        assetName,
        width: 32,
        height: 32,
      );
      break;
  }
  return DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.blueGrey.shade100,
      borderRadius: const BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          icon,
          const SizedBox(
            width: 16,
          ),
          Text(title),
        ],
      ),
    ),
  );
}

enum AssetType { svg, jpeg }
