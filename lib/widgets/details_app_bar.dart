import 'package:flutter/material.dart';
import 'package:nekoflixx/colors.dart';
import 'package:nekoflixx/constants.dart';

class DetailsAppBar extends StatelessWidget {
  const DetailsAppBar({
    super.key,
    required this.backdropPath,
  });

  final String backdropPath;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar.large(
      leading: null,
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
            "${Constants.imagePath}$backdropPath",
            filterQuality: FilterQuality.high,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
