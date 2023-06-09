import 'package:bt_c3/movie_finder/model/movie.dart';
import 'package:bt_c3/movie_finder/ui/widget/movie_carousel_item.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class MovieCarousel extends StatefulWidget {
  final bool expaned;
  final List<Movie> movieList;

  const MovieCarousel({
    Key? key,
    required this.expaned,
    required this.movieList,
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
    List<Widget> movieItemWidgets = widget.movieList
        .map(
          (item) => MovieCarouselItem(
            expanded: widget.expaned,
            movie: item,
          ),
        )
        .toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        carouselSlider(movieItemWidgets),
        const SizedBox(
          height: 18,
        ),
        carouselIndicator(movieItemWidgets),
      ],
    );
  }

  Widget carouselIndicator(List<Widget> movieItemWidgets) {
    return AnimatedSmoothIndicator(
      activeIndex: pageIndex,
      count: movieItemWidgets.length,
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
    );
  }

  Widget carouselSlider(List<Widget> movieItemWidgets) {
    return CarouselSlider(
      items: movieItemWidgets,
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
    );
  }
}
