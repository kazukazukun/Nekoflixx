import 'package:flutter/material.dart';
import 'package:nekoflixx/constants.dart';
import 'package:nekoflixx/pages/discover_movies_page.dart';
import 'package:nekoflixx/pages/discover_tv_page.dart';

/// A page to discover movies and TV shows.
class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key? key}) : super(key: key);

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with SingleTickerProviderStateMixin {
  late TabController? _tabController;
  final List<Widget> _pages = [
    const DiscoverMoviesPage(),
    const DiscoverTvPage(),
  ];

  @override
  void initState() {
    super.initState();
    // Initialize the TabController for switching between movie and TV tabs
    _tabController = TabController(length: _pages.length, vsync: this);
  }

  @override
  void dispose() {
    // Dispose the TabController to free up resources
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            const Size.fromHeight(Constants.discoverPageAppBarHeight),
        child: AppBar(
          backgroundColor: Colors.transparent,
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: 'Movies'), // Tab for discovering movies
              Tab(text: 'TV'), // Tab for discovering TV shows
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _pages, // Pages to display corresponding to the tabs
      ),
    );
  }
}
