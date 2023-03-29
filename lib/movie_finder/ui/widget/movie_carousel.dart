import 'package:bt_c3/movie_finder/model/movie.dart';
import 'package:bt_c3/movie_finder/ui/widget/movie_item.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MovieCarousel extends StatefulWidget {
  final bool expaned;

  const MovieCarousel({
    Key? key,
    required this.expaned,
  }) : super(key: key);

  @override
  State<MovieCarousel> createState() => _MovieCarouselState();
}

class _MovieCarouselState extends State<MovieCarousel> {
  int pageIndex = 0;
  late CarouselController carouselController;

  @override
  void initState() {
    carouselController = CarouselController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Movie> dummyData = [
      Movie("Movie 1", 10, "assets/images/img_1.jpg"),
      Movie("Movie 2", 8, "assets/images/img_2.jpg"),
      Movie("Movie 3", 7, "assets/images/img_3.jpg"),
    ];

    List<Widget> dummyWidget = dummyData
        .map(
          (e) => MovieItem(
            expanded: widget.expaned,
            title: e.title,
            imdbScore: e.imdbScore,
            source: e.source,
          ),
        )
        .toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          items: dummyWidget,
          carouselController: carouselController,
          options: CarouselOptions(
            viewportFraction: widget.expaned ? 0.7 : 0.4,
            enlargeCenterPage: true,
            autoPlay: true,
            enlargeStrategy: CenterPageEnlargeStrategy.scale,
            height: widget.expaned ? 141 : 214,
            enableInfiniteScroll: true,
            autoPlayInterval: Duration(seconds: widget.expaned ? 3 : 4),
            onPageChanged: (index, _) {
              setState(
                () {
                  pageIndex = index;
                },
              );
            },
          ),
        ),
        const SizedBox(
          height: 18,
        ),
        AnimatedSmoothIndicator(
          activeIndex: pageIndex,
          count: dummyWidget.length,
          onDotClicked: (index) {
            setState(() {
              pageIndex = index;
              carouselController.animateToPage(index);
            });
          },
          effect: const WormEffect(
            dotWidth: 12,
            dotHeight: 12,
          ),
        ),
        // DotsIndicator(
        //   dotsCount: dummyData.length,
        //   position: pageIndex.toDouble(),
        //   decorator: DotsDecorator(
        //     size: const Size.square(9.0),
        //     activeSize: const Size(18.0, 9.0),
        //     activeShape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(5.0)),
        //   ),
        // ),
      ],
    );
  }
}
