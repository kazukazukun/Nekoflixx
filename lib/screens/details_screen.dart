import 'package:flutter/material.dart';
import 'package:nekoflixx/api/api.dart';
import 'package:nekoflixx/firebase/firestore_service.dart';
import 'package:nekoflixx/models/actor.dart';
import 'package:nekoflixx/models/media_entity.dart';
import 'package:nekoflixx/models/movie.dart';
import 'package:nekoflixx/models/tv.dart';
import 'package:nekoflixx/screens/network_failure_screen.dart';
import 'package:nekoflixx/widgets/actor_details.dart';
import 'package:nekoflixx/widgets/movie_details.dart';
import 'package:nekoflixx/widgets/tv_details.dart';

// Screen to show movie, tv and actor details
class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.mediaEntity}) : super(key: key);
  final MediaEntity mediaEntity;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  bool _isInWatchlist = false;
  bool _isTogglingWatchlist = false;
  late Future<void> _detailsFuture;

  Movie? _movieDetails;
  TV? _tvDetails;
  Actor? _actorDetails;

  @override
  void initState() {
    super.initState();
    _detailsFuture = _initializeDetailsScreen();
  }

  Future<void> _initializeDetailsScreen() async {
    await Future.wait([
      _fetchMediaDetails(),
      _checkWatchlistStatus(),
    ]);
  }

  Future<void> _checkWatchlistStatus() async {
    try {
      bool isInWatchlist = await _firestoreService
          .isInWatchlist(widget.mediaEntity.id.toString());
      setState(() {
        _isInWatchlist = isInWatchlist;
      });
    } catch (e) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const NetworkFailureScreen()));
    }
  }

  //Adds to watchlist
  Future<void> _toggleWatchlistStatus() async {
    if (_isTogglingWatchlist) return; // Prevent multiple taps during operation

    setState(() {
      _isTogglingWatchlist = true;
    });

    try {
      await _firestoreService.toggleWatchlistStatus(widget.mediaEntity);
      await _checkWatchlistStatus(); // Refresh status after toggling
    } catch (e) {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const NetworkFailureScreen()));
    }

    setState(() {
      _isTogglingWatchlist = false;
    });
  }

  Future<void> _fetchMediaDetails() async {
    if (widget.mediaEntity.mediaType == 'movie') {
      _movieDetails = await API().getMovieDetails(widget.mediaEntity.id);
    } else if (widget.mediaEntity.mediaType == 'tv') {
      _tvDetails = await API().getTvDetails(widget.mediaEntity.id);
    } else if (widget.mediaEntity.mediaType == 'person') {
      _actorDetails = await API().getActorDetails(widget.mediaEntity.id);
    }
  }

  Widget _watchlistButtonFAB() {
    return FloatingActionButton(
      onPressed: _isTogglingWatchlist ? null : _toggleWatchlistStatus,
      backgroundColor: _isTogglingWatchlist ? Colors.grey : null,
      child: _isTogglingWatchlist
          ? CircularProgressIndicator(color: Colors.white)
          : Icon(_isInWatchlist ? Icons.check : Icons.add),
      tooltip: _isInWatchlist ? 'Remove from Watchlist' : 'Add to Watchlist',
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _detailsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }

        // Decide which content to show based on the media type and availability of details
        Widget content;
        if (widget.mediaEntity.mediaType == 'movie' && _movieDetails != null) {
          content = MovieDetails(movie: _movieDetails!);
        } else if (widget.mediaEntity.mediaType == 'tv' && _tvDetails != null) {
          content = TvDetails(tv: _tvDetails!);
        } else if (widget.mediaEntity.mediaType == 'person' &&
            _actorDetails != null) {
          content = ActorDetails(actor: _actorDetails!);
        } else {
          content = Scaffold(
            body: Center(child: Text('No details available.')),
          );
        }

        // Only show FAB if the mediaType is not "person"
        bool showFAB = widget.mediaEntity.mediaType != "person";

        return Scaffold(
          body: content,
          floatingActionButton: showFAB ? _watchlistButtonFAB() : null,
        );
      },
    );
  }
}
