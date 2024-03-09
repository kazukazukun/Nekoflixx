import 'package:flutter/material.dart';
import 'package:nekoflixx/api/api.dart';
import 'package:nekoflixx/constants.dart';
import 'package:nekoflixx/models/media_entity.dart';
import 'package:nekoflixx/widgets/sliding_media_row.dart';
import 'package:nekoflixx/widgets/topic_text.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _textEditingController = TextEditingController();

  List<MediaEntity> movieResults = [];
  List<MediaEntity> tvSeriesResults = [];
  List<MediaEntity> actorResults = [];

  void onSearchTextChanged() async {
    final query = _textEditingController.text;
    if (query.isNotEmpty) {
      try {
        final searchResults = await API().getSearchedList(query);
        setState(() {
          movieResults =
              searchResults.where((item) => item.mediaType == "movie").toList();
          tvSeriesResults =
              searchResults.where((item) => item.mediaType == "tv").toList();
          actorResults = searchResults
              .where((item) => item.mediaType == "person")
              .toList();
        });
      } catch (e) {
        // Handle error
        print("Error: $e");
      }
    } else {
      setState(() {
        movieResults = [];
        tvSeriesResults = [];
        actorResults = [];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(onSearchTextChanged);
  }

  @override
  void dispose() {
    _textEditingController.removeListener(onSearchTextChanged);
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.white),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: Constants.searchPageSpacing),
            if (movieResults.isNotEmpty) ...[
              const TopicText(txt: "Movies"),
              SlidingMediaRow(
                  mediaEntityList: Future.value(movieResults), isMoving: false),
              const SizedBox(height: Constants.spacingBetweenSliders),
            ],
            if (tvSeriesResults.isNotEmpty) ...[
              const TopicText(txt: "TV Series"),
              SlidingMediaRow(
                  mediaEntityList: Future.value(tvSeriesResults),
                  isMoving: false),
              const SizedBox(height: Constants.spacingBetweenSliders),
            ],
            if (actorResults.isNotEmpty) ...[
              const TopicText(txt: "Actors"),
              SlidingMediaRow(
                  mediaEntityList: Future.value(actorResults), isMoving: false),
              const SizedBox(height: Constants.spacingBetweenSliders),
            ],
          ],
        ),
      ),
    );
  }
}
