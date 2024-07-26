import 'package:freezed_annotation/freezed_annotation.dart';

part 'podcast.freezed.dart';
part 'podcast.g.dart';

enum PodCastCategory { devotion, doctrine, sermon, other }

@freezed
class Podcast with _$Podcast {
  factory Podcast({
    String? description,
    required String audioUrl,
    required String title,
    required PodCastCategory category,
  }) = _Podcast;

  factory Podcast.fromJson(Map<String, dynamic> json) =>
      _$PodcastFromJson(json);
}
