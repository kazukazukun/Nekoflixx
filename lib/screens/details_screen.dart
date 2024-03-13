import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nekoflixx/firebase/firestore_service.dart';
import 'package:nekoflixx/models/media_entity.dart';
import 'package:nekoflixx/widgets/details_app_bar.dart';
import 'package:nekoflixx/widgets/tag.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.mediaEntity}) : super(key: key);
  final MediaEntity mediaEntity;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  bool _isInWatchlist = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkWatchlistStatus();
  }

  Future<void> _checkWatchlistStatus() async {
    try {
      bool isInWatchlist =
          await _firestoreService.isInWatchlist(widget.mediaEntity.id);
      setState(() {
        _isInWatchlist = isInWatchlist;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Handle the error appropriately
    }
  }

  Future<void> _toggleWatchlistStatus() async {
    setState(() {
      _isLoading = true;
    });
    try {
      // Pass the current status to the method
      await _firestoreService.toggleWatchlistStatus(
          widget.mediaEntity.id, _isInWatchlist);
      _checkWatchlistStatus(); // Refresh status after toggling
    } catch (e) {
      // Handle the error appropriately
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _watchlistButton() {
    return _isLoading
        ? CircularProgressIndicator()
        : IconButton(
            icon: _isInWatchlist ? Icon(Icons.check) : Icon(Icons.add),
            onPressed: _toggleWatchlistStatus,
            tooltip:
                _isInWatchlist ? 'Remove from Watchlist' : 'Add to Watchlist',
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.mediaEntity.name),
        actions: [
          _watchlistButton()
        ], // Positioned the button in the app bar for accessibility
      ),
      body: CustomScrollView(
        slivers: [
          DetailsAppBar(media: widget.mediaEntity),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.mediaEntity.name,
                    style: GoogleFonts.belleza(
                        fontSize: 45, fontWeight: FontWeight.w600),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 26),
                  Text("Overview",
                      style: GoogleFonts.openSans(
                          fontSize: 25, fontWeight: FontWeight.w800)),
                  SizedBox(height: 16),
                  Text(widget.mediaEntity.overview,
                      style: GoogleFonts.roboto(
                          fontSize: 17, fontWeight: FontWeight.w600)),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (widget.mediaEntity.mediaType == "movie")
                        Tag(
                            txt: "Release date",
                            content: widget.mediaEntity.releaseDate)
                      else
                        Tag(
                            txt: "First air date",
                            content: widget.mediaEntity.releaseDate),
                      Tag(
                        txt: "Rating",
                        content:
                            "${widget.mediaEntity.voteAverage.toStringAsFixed(1)}/10",
                      ),
                    ],
                  ),
                  // Optional: Add additional movie details or actions here
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
