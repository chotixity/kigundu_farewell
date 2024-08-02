import 'package:flutter/material.dart';
import 'package:podcasts/audio_player.dart';
import 'package:podcasts/provider/podcast_provider.dart';
import 'package:provider/provider.dart';
import 'package:podcasts/models/podcast.dart';

class PastEpisode extends StatefulWidget {
  const PastEpisode({super.key});

  @override
  State<PastEpisode> createState() => _PastEpisodeState();
}

class _PastEpisodeState extends State<PastEpisode> {
  late int podcastIndex;
  late Podcast podcast;
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    podcastIndex = ModalRoute.of(context)!.settings.arguments as int;
    podcast = Provider.of<PodcastProvider>(context).podcasts[podcastIndex + 1];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(podcast.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            AudioPlayerWidget(
                url: podcast.audioUrl, title: podcast.title, id: podcast.id!)
          ],
        ),
      ),
    );
  }
}
