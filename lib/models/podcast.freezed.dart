// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'podcast.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Podcast _$PodcastFromJson(Map<String, dynamic> json) {
  return _Podcast.fromJson(json);
}

/// @nodoc
mixin _$Podcast {
  String? get description => throw _privateConstructorUsedError;
  String get audioUrl => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  PodCastCategory get category => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PodcastCopyWith<Podcast> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PodcastCopyWith<$Res> {
  factory $PodcastCopyWith(Podcast value, $Res Function(Podcast) then) =
      _$PodcastCopyWithImpl<$Res, Podcast>;
  @useResult
  $Res call(
      {String? description,
      String audioUrl,
      String title,
      PodCastCategory category});
}

/// @nodoc
class _$PodcastCopyWithImpl<$Res, $Val extends Podcast>
    implements $PodcastCopyWith<$Res> {
  _$PodcastCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = freezed,
    Object? audioUrl = null,
    Object? title = null,
    Object? category = null,
  }) {
    return _then(_value.copyWith(
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      audioUrl: null == audioUrl
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as PodCastCategory,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PodcastImplCopyWith<$Res> implements $PodcastCopyWith<$Res> {
  factory _$$PodcastImplCopyWith(
          _$PodcastImpl value, $Res Function(_$PodcastImpl) then) =
      __$$PodcastImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? description,
      String audioUrl,
      String title,
      PodCastCategory category});
}

/// @nodoc
class __$$PodcastImplCopyWithImpl<$Res>
    extends _$PodcastCopyWithImpl<$Res, _$PodcastImpl>
    implements _$$PodcastImplCopyWith<$Res> {
  __$$PodcastImplCopyWithImpl(
      _$PodcastImpl _value, $Res Function(_$PodcastImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = freezed,
    Object? audioUrl = null,
    Object? title = null,
    Object? category = null,
  }) {
    return _then(_$PodcastImpl(
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      audioUrl: null == audioUrl
          ? _value.audioUrl
          : audioUrl // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as PodCastCategory,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PodcastImpl implements _Podcast {
  _$PodcastImpl(
      {this.description,
      required this.audioUrl,
      required this.title,
      required this.category});

  factory _$PodcastImpl.fromJson(Map<String, dynamic> json) =>
      _$$PodcastImplFromJson(json);

  @override
  final String? description;
  @override
  final String audioUrl;
  @override
  final String title;
  @override
  final PodCastCategory category;

  @override
  String toString() {
    return 'Podcast(description: $description, audioUrl: $audioUrl, title: $title, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PodcastImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.audioUrl, audioUrl) ||
                other.audioUrl == audioUrl) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, description, audioUrl, title, category);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PodcastImplCopyWith<_$PodcastImpl> get copyWith =>
      __$$PodcastImplCopyWithImpl<_$PodcastImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PodcastImplToJson(
      this,
    );
  }
}

abstract class _Podcast implements Podcast {
  factory _Podcast(
      {final String? description,
      required final String audioUrl,
      required final String title,
      required final PodCastCategory category}) = _$PodcastImpl;

  factory _Podcast.fromJson(Map<String, dynamic> json) = _$PodcastImpl.fromJson;

  @override
  String? get description;
  @override
  String get audioUrl;
  @override
  String get title;
  @override
  PodCastCategory get category;
  @override
  @JsonKey(ignore: true)
  _$$PodcastImplCopyWith<_$PodcastImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
