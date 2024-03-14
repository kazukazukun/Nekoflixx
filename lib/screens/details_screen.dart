import 'package:flutter/material.dart';
import 'package:nekoflixx/api/api.dart';
import 'package:nekoflixx/firebase/firestore_service.dart';
import 'package:nekoflixx/models/actor.dart';
import 'package:nekoflixx/models/media_entity.dart';
import 'package:nekoflixx/models/movie.dart';
import 'package:nekoflixx/models/tv.dart';

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

  late Movie _movieDetails;
  late TV _tvDetails;
  late Actor _actorDetails;

  @override
  void initState() {
    super.initState();
    _checkWatchlistStatus();
    _fetchMediaDetails();
  }

  Future<void> _checkWatchlistStatus() async {
    try {
      bool isInWatchlist = await _firestoreService
          .isInWatchlist(widget.mediaEntity.id.toString());
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
      await _firestoreService.toggleWatchlistStatus(widget.mediaEntity);
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
        ? const CircularProgressIndicator()
        : IconButton(
            icon: _isInWatchlist
                ? const Icon(Icons.check)
                : const Icon(Icons.add),
            onPressed: _toggleWatchlistStatus,
            tooltip:
                _isInWatchlist ? 'Remove from Watchlist' : 'Add to Watchlist',
          );
  }

  Future<void> _fetchMediaDetails() async {
    try {
      if (widget.mediaEntity.mediaType == 'movie') {
        _movieDetails = await API().getMovieDetails(widget.mediaEntity.id);
      } else if (widget.mediaEntity.mediaType == 'tv') {
        _tvDetails = await API().getTvDetails(widget.mediaEntity.id);
      } else if (widget.mediaEntity.mediaType == 'person') {
        _actorDetails = await API().getActorDetails(widget.mediaEntity.id);
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      // Handle error
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
