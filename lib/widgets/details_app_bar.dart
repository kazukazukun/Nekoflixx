import 'package:flutter/material.dart';
import 'package:nekoflixx/colors.dart';
import 'package:nekoflixx/constants.dart';
import 'package:nekoflixx/models/media_entity.dart';
import 'package:nekoflixx/widgets/back_button.dart';

class DetailsAppBar extends StatelessWidget {
  const DetailsAppBar({
    super.key,
    required this.media,
  });

  final MediaEntity media;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.large(
      leading: const MyBackButton(),
      backgroundColor: Colours.scaffoldBgColor,
      expandedHeight: 500,
      pinned: true,
      floating: true,
      flexibleSpace: FlexibleSpaceBar(
        background: ClipRRect(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(24),
            bottomRight: Radius.circular(24),
          ),
          child: Image.network(
            "${Constants.imagePath}${media.posterPath}",
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}