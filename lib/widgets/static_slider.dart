import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nekoflixx/constants.dart';
import 'package:nekoflixx/screens/details_screen.dart';

class StaticSlider extends StatelessWidget {
  const StaticSlider({
    super.key,
    required this.snapshot,
  });
  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    // Determine if the app is running on the web and the screen width
    const bool isWeb = kIsWeb;
    final double screenWidth = MediaQuery.of(context).size.width;

    // Adjust viewportFraction based on platform and screen width
    final double viewportFraction = isWeb && screenWidth > 600 ? 0.2 : 0.55;
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: snapshot.data!.length,
        options: CarouselOptions(
          aspectRatio: 16 / 9,
          height: 250,
          autoPlay: false,
          viewportFraction: viewportFraction,
          enlargeCenterPage: false,
          pageSnapping: true,
          enableInfiniteScroll: false,
        ),
        itemBuilder: (context, itemIndex, pageViewIndex) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                          mediaEntity: snapshot.data[itemIndex])));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 250,
                width: 175,
                child: Image.network(
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                    "${Constants.imagePath}${snapshot.data[itemIndex].backdropPath}"),
              ),
            ),
          );
        },
      ),
    );
  }
}

  // Widget build(BuildContext context) {
  //   return SizedBox(
  //     height: 250,
  //     width: double.infinity,
  //     child: ListView.builder(
  //       controller: _scrollController,
  //       scrollDirection: Axis.horizontal,
  //       physics: const BouncingScrollPhysics(),
  //       itemCount: snapshot.data!.length,
  //       itemBuilder: (context, index) {
  //         return Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: GestureDetector(
  //             onTap: () {
  //               Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) =>
  //                           DetailsScreen(mediaEntity: snapshot.data[index])));
  //             },
  //             child: ClipRRect(
  //               borderRadius: BorderRadius.circular(8),
  //               child: SizedBox(
  //                 height: 250,
  //                 width: 150,
  //                 child: Image.network(
  //                     filterQuality: FilterQuality.high,
  //                     fit: BoxFit.cover,
  //                     "${Constants.imagePath}${snapshot.data![index].posterPath}"),
  //               ),
  //             ),
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }
