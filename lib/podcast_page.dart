import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:podcasts/models/podcast.dart';
import 'package:podcasts/provider/podcast_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart';
import 'package:podcasts/audio_player.dart';

class PodcastPage extends StatefulWidget {
  const PodcastPage({super.key});

  @override
  State<PodcastPage> createState() => _PodcastPageState();
}

class _PodcastPageState extends State<PodcastPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SchedulerBinding.instance.scheduleFrameCallback((_) {
      Provider.of<PodcastProvider>(context, listen: false).loadPodcasts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final podcasts = Provider.of<PodcastProvider>(context).podcasts;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${DateFormat.yMMMd().format(DateTime.now())} Devotion'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: podcasts.isEmpty
            ? const Center(
                child: Text('There are no podcasts yet'),
              )
            : Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          LatestPodcastSection(
                            latestPodcast: podcasts.first,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Previous  Episodes",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          PastEpisodesSection(
                            episodes: podcasts,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class LatestPodcastSection extends StatelessWidget {
  final Podcast latestPodcast;
  const LatestPodcastSection({required this.latestPodcast, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   DateFormat.yMMMd().format(latestPodcast.timestamp),
          //   style: Theme.of(context).textTheme.headlineMedium,
          // ),
          Text(
            latestPodcast.title,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          AudioPlayerWidget(url: latestPodcast.audioUrl),
          const SizedBox(height: 8),

          const SizedBox(height: 8),
          Text(
            latestPodcast.description ?? "",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class PastEpisodesSection extends StatelessWidget {
  final List<Podcast> episodes;
  const PastEpisodesSection({required this.episodes, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: episodes.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => Scaffold(
                      body: LatestPodcastSection(
                          latestPodcast: episodes[index]))));
            },
            child: Container(
              width: 200,
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    episodes[index].title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    maxLines: 3,
                    '${episodes[index].description}',
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color:
                            Theme.of(context).colorScheme.onPrimaryContainer),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
