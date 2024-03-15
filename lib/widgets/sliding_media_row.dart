import 'package:flutter/material.dart';
import 'package:nekoflixx/models/media_entity.dart';
import 'package:nekoflixx/screens/network_failure_screen.dart';
import 'package:nekoflixx/widgets/moving_slider.dart';
import 'package:nekoflixx/widgets/static_slider.dart';

//Media row, which calls either slidng meida row ot static media row
class SlidingMediaRow extends StatelessWidget {
  const SlidingMediaRow({
    super.key,
    required this.mediaEntityList,
    required this.isMoving,
  });

  final Future<List<MediaEntity>> mediaEntityList;
  final bool isMoving;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FutureBuilder(
        future: mediaEntityList,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const NetworkFailureScreen();
          } else if (snapshot.hasData) {
            if (isMoving) {
              return MovingSlider(snapshot: snapshot);
            } else {
              return StaticSlider(snapshot: snapshot);
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
