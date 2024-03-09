import 'package:flutter/material.dart';
import 'package:nekoflixx/api/api.dart';
import 'package:nekoflixx/constants.dart';
import 'package:nekoflixx/models/media_entity.dart';
import 'package:nekoflixx/widgets/sliding_media_row.dart';
import 'package:nekoflixx/widgets/topic_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<MediaEntity>> nowPlayingMovies;
  late Future<List<MediaEntity>> onTvTonights;
  late Future<List<MediaEntity>> upComingMovies;
  late Future<List<MediaEntity>> topGrossingMovies;

  @override
  void initState() {
    super.initState();
    nowPlayingMovies = API().getNowPlayingMovies();
    onTvTonights = API().getTvTonights();
    upComingMovies = API().getBestMoviesThisYear();
    topGrossingMovies = API().getTopGrossingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: Constants.spacingBetweenSliders,
            ),
            const TopicText(txt: "Now Playing"),
            const SizedBox(
              height: Constants.spacingBetweenSliders,
            ),
            SlidingMediaRow(
              mediaEntityList: nowPlayingMovies,
              isMoving: true,
            ),
            const SizedBox(
              height: Constants.spacingBetweenSliders,
            ),
            const TopicText(txt: "What's on TV tonight?"),
            const SizedBox(
              height: Constants.spacingBetweenSliders,
            ),
            SlidingMediaRow(mediaEntityList: onTvTonights, isMoving: true),
            const SizedBox(
              height: Constants.spacingBetweenSliders,
            ),
            const TopicText(txt: "Best Movies of the Year"),
            const SizedBox(
              height: Constants.spacingBetweenSliders,
            ),
            SlidingMediaRow(mediaEntityList: upComingMovies, isMoving: true),
            const SizedBox(
              height: Constants.spacingBetweenSliders,
            ),
            const TopicText(txt: "Top Grossing"),
            const SizedBox(
              height: Constants.spacingBetweenSliders,
            ),
            SlidingMediaRow(mediaEntityList: topGrossingMovies, isMoving: true),
            const SizedBox(
              height: Constants.spacingBetweenSliders,
            ),
          ],
        ),
      ),
    );
  }
}
