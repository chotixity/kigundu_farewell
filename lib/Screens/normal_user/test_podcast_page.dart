import 'package:flutter/material.dart';
import 'package:podcasts/Screens/normal_user/past_episode.dart';
import '../../models/podcast.dart';
import 'package:podcasts/provider/podcast_provider.dart';
import 'package:provider/provider.dart';
import 'package:podcasts/audio_player.dart';

class TestPodcastPage extends StatefulWidget {
  const TestPodcastPage({super.key});

  @override
  State<TestPodcastPage> createState() => _TestPodcastPageState();
}

class _TestPodcastPageState extends State<TestPodcastPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.scheduleFrameCallback((_) {
      Provider.of<PodcastProvider>(context, listen: false).loadPodcasts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final podcastsProvider =
        Provider.of<PodcastProvider>(context, listen: false);
    List<Podcast> loadedPodcasts = podcastsProvider.podcasts; //Get all episodes
    List<Podcast> previousEpisodes = loadedPodcasts
        .getRange(1, loadedPodcasts.length - 1)
        .toList(); //Gets previous episodes removing the one for today
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
        child: Column(
          children: [
            AudioPlayerWidget(
              url: loadedPodcasts.first.audioUrl,
              title: loadedPodcasts.first.title,
              id: loadedPodcasts.first.id!,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.sizeOf(context).height * .6),
              child: SingleChildScrollView(
                  child: Text(loadedPodcasts.first.description ?? "")),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: PreviousEpisode(
                      previousEpisodes: previousEpisodes,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//A widget to display a list of porevios podcast episodes
class PreviousEpisode extends StatelessWidget {
  final List<Podcast> previousEpisodes;
  const PreviousEpisode({
    required this.previousEpisodes,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) {
        return const SizedBox(
          width: 10,
        );
      },
      scrollDirection: Axis.horizontal,
      itemCount: previousEpisodes.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const PastEpisode(),
                settings: RouteSettings(arguments: index),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 0,
            width: MediaQuery.sizeOf(context).width * .45,
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Text(
                  previousEpisodes[index].title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Flexible(
                  child: Text(
                    softWrap: true,
                    maxLines: 100,
                    previousEpisodes[index].description == null
                        ? ""
                        : previousEpisodes[index].description!.trim(),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
