// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PodcastImpl _$$PodcastImplFromJson(Map<String, dynamic> json) =>
    _$PodcastImpl(
      description: json['description'] as String?,
      audioUrl: json['audioUrl'] as String,
      title: json['title'] as String,
      category: $enumDecode(_$PodCastCategoryEnumMap, json['category']),
    );

Map<String, dynamic> _$$PodcastImplToJson(_$PodcastImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'audioUrl': instance.audioUrl,
      'title': instance.title,
      'category': _$PodCastCategoryEnumMap[instance.category]!,
    };

const _$PodCastCategoryEnumMap = {
  PodCastCategory.devotion: 'devotion',
  PodCastCategory.doctrine: 'doctrine',
  PodCastCategory.sermon: 'sermon',
  PodCastCategory.other: 'other',
};
