import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nekoflixx/models/actor.dart';
import 'package:nekoflixx/widgets/details_app_bar.dart';
import 'package:nekoflixx/widgets/tag.dart';

class ActorDetails extends StatefulWidget {
  final Actor actor;

  const ActorDetails({Key? key, required this.actor}) : super(key: key);

  @override
  State<ActorDetails> createState() => _ActorDetailsState();
}

class _ActorDetailsState extends State<ActorDetails> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.actor.name),
        leading: null, // Disable default back button
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                DetailsAppBar(backdropPath: widget.actor.profilePath),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.actor.name,
                          style: GoogleFonts.belleza(
                              fontSize: 45, fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 26),
                        Text("Overview",
                            style: GoogleFonts.openSans(
                                fontSize: 25, fontWeight: FontWeight.w800)),
                        const SizedBox(height: 16),
                        Text(widget.actor.biography,
                            style: GoogleFonts.roboto(
                                fontSize: 17, fontWeight: FontWeight.w600)),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Tag(
                              txt: "Birth Day",
                              content: widget.actor.birthday,
                            ),
                            Tag(
                              txt: "Rating",
                              content: "${widget.actor.popularity}",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
