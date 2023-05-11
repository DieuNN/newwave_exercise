import 'package:bt_c3/c4/features/c4_feature1.dart';
import 'package:flutter/material.dart';

class C4Feature3 extends StatelessWidget {
  const C4Feature3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Widget> rows = [
      itemRow(title: "FAQ", assetName: "assets/svg/FAQ.svg", assetType: AssetType.svg),
      itemRow(title: "Contact", assetName: "assets/svg/Contact.svg", assetType: AssetType.svg),
      itemRow(title: "Terms", assetName: "assets/svg/terms.svg", assetType: AssetType.svg),
    ];

    return Scaffold(
      backgroundColor: Colors.grey.shade400,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.separated(
            itemCount: rows.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8,),
            itemBuilder: (context, index) => rows[index],
          ),
        ),
      ),
    );
  }
}
