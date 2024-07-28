// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PodcastImpl _$$PodcastImplFromJson(Map<String, dynamic> json) =>
    _$PodcastImpl(
      id: json['id'] as String?,
      description: json['description'] as String?,
      audioUrl: json['audioUrl'] as String,
      title: json['title'] as String,
      category: $enumDecode(_$PodCastCategoryEnumMap, json['category']),
      isFeatured: json['isFeatured'] as bool? ?? false,
    );

Map<String, dynamic> _$$PodcastImplToJson(_$PodcastImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'audioUrl': instance.audioUrl,
      'title': instance.title,
      'category': _$PodCastCategoryEnumMap[instance.category]!,
      'isFeatured': instance.isFeatured,
    };

const _$PodCastCategoryEnumMap = {
  PodCastCategory.devotion: 'devotion',
  PodCastCategory.doctrine: 'doctrine',
  PodCastCategory.sermon: 'sermon',
  PodCastCategory.other: 'other',
};
