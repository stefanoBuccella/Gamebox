// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Game {

 String get id; String get title; String? get imageUrl; String? get publisher; List<String> get platforms; double? get rating; int? get releaseYear; String? get summary;
/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameCopyWith<Game> get copyWith => _$GameCopyWithImpl<Game>(this as Game, _$identity);

  /// Serializes this Game to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Game&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&const DeepCollectionEquality().equals(other.platforms, platforms)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.releaseYear, releaseYear) || other.releaseYear == releaseYear)&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,imageUrl,publisher,const DeepCollectionEquality().hash(platforms),rating,releaseYear,summary);

@override
String toString() {
  return 'Game(id: $id, title: $title, imageUrl: $imageUrl, publisher: $publisher, platforms: $platforms, rating: $rating, releaseYear: $releaseYear, summary: $summary)';
}


}

/// @nodoc
abstract mixin class $GameCopyWith<$Res>  {
  factory $GameCopyWith(Game value, $Res Function(Game) _then) = _$GameCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? imageUrl, String? publisher, List<String> platforms, double? rating, int? releaseYear, String? summary
});




}
/// @nodoc
class _$GameCopyWithImpl<$Res>
    implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._self, this._then);

  final Game _self;
  final $Res Function(Game) _then;

/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? imageUrl = freezed,Object? publisher = freezed,Object? platforms = null,Object? rating = freezed,Object? releaseYear = freezed,Object? summary = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,publisher: freezed == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as String?,platforms: null == platforms ? _self.platforms : platforms // ignore: cast_nullable_to_non_nullable
as List<String>,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,releaseYear: freezed == releaseYear ? _self.releaseYear : releaseYear // ignore: cast_nullable_to_non_nullable
as int?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Game].
extension GamePatterns on Game {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Game value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Game() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Game value)  $default,){
final _that = this;
switch (_that) {
case _Game():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Game value)?  $default,){
final _that = this;
switch (_that) {
case _Game() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? imageUrl,  String? publisher,  List<String> platforms,  double? rating,  int? releaseYear,  String? summary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Game() when $default != null:
return $default(_that.id,_that.title,_that.imageUrl,_that.publisher,_that.platforms,_that.rating,_that.releaseYear,_that.summary);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? imageUrl,  String? publisher,  List<String> platforms,  double? rating,  int? releaseYear,  String? summary)  $default,) {final _that = this;
switch (_that) {
case _Game():
return $default(_that.id,_that.title,_that.imageUrl,_that.publisher,_that.platforms,_that.rating,_that.releaseYear,_that.summary);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? imageUrl,  String? publisher,  List<String> platforms,  double? rating,  int? releaseYear,  String? summary)?  $default,) {final _that = this;
switch (_that) {
case _Game() when $default != null:
return $default(_that.id,_that.title,_that.imageUrl,_that.publisher,_that.platforms,_that.rating,_that.releaseYear,_that.summary);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Game implements Game {
  const _Game({required this.id, required this.title, this.imageUrl, this.publisher, final  List<String> platforms = const [], this.rating, this.releaseYear, this.summary}): _platforms = platforms;
  factory _Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? imageUrl;
@override final  String? publisher;
 final  List<String> _platforms;
@override@JsonKey() List<String> get platforms {
  if (_platforms is EqualUnmodifiableListView) return _platforms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_platforms);
}

@override final  double? rating;
@override final  int? releaseYear;
@override final  String? summary;

/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameCopyWith<_Game> get copyWith => __$GameCopyWithImpl<_Game>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Game&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.publisher, publisher) || other.publisher == publisher)&&const DeepCollectionEquality().equals(other._platforms, _platforms)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.releaseYear, releaseYear) || other.releaseYear == releaseYear)&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,imageUrl,publisher,const DeepCollectionEquality().hash(_platforms),rating,releaseYear,summary);

@override
String toString() {
  return 'Game(id: $id, title: $title, imageUrl: $imageUrl, publisher: $publisher, platforms: $platforms, rating: $rating, releaseYear: $releaseYear, summary: $summary)';
}


}

/// @nodoc
abstract mixin class _$GameCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$GameCopyWith(_Game value, $Res Function(_Game) _then) = __$GameCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? imageUrl, String? publisher, List<String> platforms, double? rating, int? releaseYear, String? summary
});




}
/// @nodoc
class __$GameCopyWithImpl<$Res>
    implements _$GameCopyWith<$Res> {
  __$GameCopyWithImpl(this._self, this._then);

  final _Game _self;
  final $Res Function(_Game) _then;

/// Create a copy of Game
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? imageUrl = freezed,Object? publisher = freezed,Object? platforms = null,Object? rating = freezed,Object? releaseYear = freezed,Object? summary = freezed,}) {
  return _then(_Game(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,publisher: freezed == publisher ? _self.publisher : publisher // ignore: cast_nullable_to_non_nullable
as String?,platforms: null == platforms ? _self._platforms : platforms // ignore: cast_nullable_to_non_nullable
as List<String>,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,releaseYear: freezed == releaseYear ? _self.releaseYear : releaseYear // ignore: cast_nullable_to_non_nullable
as int?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
