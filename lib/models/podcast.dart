import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'podcast.freezed.dart';
part 'podcast.g.dart';

enum PodCastCategory { devotion, doctrine, sermon, other }

@freezed
class Podcast with _$Podcast {
  factory Podcast({
    String? id,
    String? description,
    required String audioUrl,
    required String title,
    required PodCastCategory category,
    @Default(false) bool isFeatured,
    @JsonKey(fromJson: _dateTimeFromTimestamp, toJson: _dateTimeAsIs)
    DateTime? timestamp,
  }) = _Podcast;

  factory Podcast.fromJson(Map<String, dynamic> json) =>
      _$PodcastFromJson(json);

  static DateTime? _dateTimeFromTimestamp(Timestamp? timestamp) =>
      timestamp?.toDate();
  static DateTime? _dateTimeAsIs(DateTime? dateTime) => dateTime;
}
