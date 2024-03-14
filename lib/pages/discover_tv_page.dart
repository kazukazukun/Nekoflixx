import 'package:flutter/material.dart';
import 'package:nekoflixx/models/genre_provider.dart';
import 'package:provider/provider.dart';

class DiscoverTvPage extends StatefulWidget {
  const DiscoverTvPage({super.key});

  @override
  State<DiscoverTvPage> createState() => _DiscoverTvPageState();
}

class _DiscoverTvPageState extends State<DiscoverTvPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GenreProvider>(
      builder: (context, genreProvider, _) {
        final tvGenres = genreProvider.tvGenres;
        // Use movieGenres list here
        return Container(); // Replace with your actual UI
      },
    );
  }
}
