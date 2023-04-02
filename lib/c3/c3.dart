import 'package:bt_c3/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class C3Screen extends StatefulWidget {
  const C3Screen({Key? key}) : super(key: key);

  @override
  State<C3Screen> createState() => _C3ScreenState();
}

final isRefreshed = ValueNotifier<bool>(false);

class _C3ScreenState extends State<C3Screen> {
  Future<void> _refresh() async {
    return Future.delayed(
      const Duration(seconds: 1),
      () {
        isRefreshed.value = !isRefreshed.value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<SaladItem> saladItems = [
      SaladItem("Salad", "123.456 recipes", "assets/images/img_1.jpg"),
      SaladItem("Vegetable", "123.456 recipes", "assets/images/img_2.jpg"),
      SaladItem("Puppy", "123.456 recipes", "assets/images/img_3.jpg"),
      SaladItem("Carrot", "123.456 recipes", "assets/images/img_4.jpg"),
      SaladItem("Egg", "123.456 recipes", "assets/images/img_5.jpg"),
      SaladItem("Cat", "123.456 recipes", "assets/images/img_6.jpg"),
      SaladItem("Dog", "123.456 recipes", "assets/images/img_7.jpg"),
    ];

    return ValueListenableBuilder(
        valueListenable: notifier,
        builder: (BuildContext context, ThemeMode value, Widget? child) {
          bool isLightTheme = value == ThemeMode.light;
          return Scaffold(
            backgroundColor: isLightTheme ? Colors.white : Colors.black,
            appBar: _appBar(isLightTheme),
            body: RefreshIndicator(
              onRefresh: () => _refresh(),
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                children: [
                  SizedBox(
                    height: 200,
                    width: MediaQuery.of(context).size.width,
                    child: listView(items: saladItems),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  _sortByWidget(isLightTheme),
                  Container(
                    child: gridView(items: saladItems),
                  )
                ],
              ),
            ),
          );
        });
  }

  _appBar(isLightTheme) {
    return AppBar(
      title: Text(
        "Salad",
        style: TextStyle(color: isLightTheme ? Colors.black : Colors.white),
      ),
      actions: [
        IconButton(
          onPressed: () {
            if (kDebugMode) {
              print(notifier.value);
            }
            if (notifier.value == ThemeMode.light) {
              notifier.value = ThemeMode.dark;
            } else {
              notifier.value = ThemeMode.light;
            }
          },
          icon: Icon(
            Icons.search,
            color: isLightTheme ? Colors.black : Colors.white,
          ),
        )
      ],
      backgroundColor: isLightTheme ? Colors.white : Colors.black,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: isLightTheme ? Colors.black : Colors.white,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      elevation: 0,
      shadowColor: Colors.transparent,
    );
  }

  _sortByWidget(isLightTheme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Text(
          "Sort by",
          style: TextStyle(
              color: isLightTheme ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 22),
        ),
        Row(
          children: [
            const Text(
              "Most popular",
              style: TextStyle(
                  color: Color.fromRGBO(245, 66, 120, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            const SizedBox(
              width: 8,
            ),
            IconButton(
              icon: const Icon(Icons.swap_vert),
              iconSize: 18,
              color: const Color.fromRGBO(245, 66, 120, 1),
              constraints: const BoxConstraints(
                maxHeight: 36,
                maxWidth: 36,
              ),
              splashRadius: 12,
              onPressed: () {},
            )
          ],
        ),
      ],
    );
  }
}

Widget gridViewItem({required SaladItem item, required BuildContext context}) {
  return Stack(
    children: [
      ClipRRect(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                item.assetImage,
              ),
            ),
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Colors.white,
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Colors.grey.withOpacity(0.0),
              Colors.black,
            ],
            stops: const [0.0, 1.0],
          ),
        ),
      ),
      Positioned(
        right: 8,
        top: 8,
        child: bookmarkIcon(),
      ),
      Positioned(
        bottom: 8,
        left: 8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              item.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Text(
              item.subtitle,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    ],
  );
}

Widget gridView({required List<SaladItem> items}) {
  return GridView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
    ),
    itemCount: items.length,
    itemBuilder: (context, index) {
      return gridViewItem(item: items[index], context: context);
    },
  );
}

Widget listView({required List<SaladItem> items}) {
  return ListView.separated(
    scrollDirection: Axis.horizontal,
    itemCount: items.length,
    itemBuilder: (BuildContext context, int index) {
      return listviewItem(item: items[index], context: context);
    },
    separatorBuilder: (BuildContext context, int index) {
      return const SizedBox(
        width: 16,
      );
    },
    physics: const BouncingScrollPhysics(),
  );
}

Widget bookmarkIcon() {
  return ValueListenableBuilder(
      valueListenable: isRefreshed,
      builder: (context, value, child) {
        return Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (value) ? Colors.red : Colors.yellow,
          ),
          child: IconButton(
            icon: Icon(
              value ? Icons.bookmark : Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
            iconSize: 18,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
        );
      });
}

Widget listviewItem({required SaladItem item, required context}) {
  return Container(
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    // 2 times padding
    width: MediaQuery.of(context).size.width - 2 * 20,
    height: 200,
    child: Stack(
      children: [
        ClipRRect(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  item.assetImage,
                ),
              ),
            ),
            height: 200.0,
          ),
        ),
        Container(
          height: 200.0,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: Colors.white,
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.grey.withOpacity(0.0),
                Colors.black,
              ],
              stops: const [0.0, 1.0],
            ),
          ),
        ),
        Positioned(
          bottom: 8,
          left: 8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              Text(
                item.subtitle,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 10),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

class SaladItem {
  String title;
  String subtitle;
  String assetImage;

  SaladItem(this.title, this.subtitle, this.assetImage);
}
