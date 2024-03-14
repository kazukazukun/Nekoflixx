import 'package:flutter/material.dart';
import 'package:nekoflixx/constants.dart';
import 'package:nekoflixx/models/media_entity.dart';
import 'package:nekoflixx/screens/details_screen.dart';

class MediaGrid extends StatelessWidget {
  final List<MediaEntity> mediaEntityList;

  const MediaGrid({Key? key, required this.mediaEntityList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: mediaEntityList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Adjust the cross axis count as needed
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.65, // Adjust the aspect ratio as needed
      ),
      itemBuilder: (context, index) {
        final mediaEntity = mediaEntityList[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailsScreen(mediaEntity: mediaEntity),
              ),
            );
          },
          child: GridTile(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                "${Constants.imagePath}${mediaEntity.backdropPath}",
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
