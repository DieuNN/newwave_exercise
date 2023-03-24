import 'package:bt_c3/c4/c4.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class C4Feature2 extends StatelessWidget {
  const C4Feature2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListView(
              shrinkWrap: true,
              children: [
                imageNetworkWidget(),
                cachedNetworkImageWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget cachedNetworkImageWidget() {
  return Center(
    child: Column(
      children: [
        const Text("Using cached_image"),
        CachedNetworkImage(
          imageUrl:
          C4Const.imageUrl,
          placeholder: (context, url) {
            return const SizedBox(
              width: 256,
              height: 256,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          },
          errorWidget: (context, url, error) =>
          const Icon(Icons.error),
          width: 256,
          height: 256,
        )
      ],
    ),
  );
}

Widget imageNetworkWidget() {
  return Center(
    child: Column(
      children: [
        const Text("Using Image.network"),
        Image.network(
          C4Const.imageUrl,
          width: 256,
          height: 256,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return SizedBox(
              width: 256,
              height: 256,
              child: Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes !=
                      null
                      ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                      : null,
                ),
              ),
            );
          },
        ),
      ],
    ),
  );
}
