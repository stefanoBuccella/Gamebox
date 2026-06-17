// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'diary_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DiaryEntry {

 String get id; Game get game; double get rating; String get reviewText; DateTime get createdAt; int get likesCount; bool get isLikedByMe; String? get username;
/// Create a copy of DiaryEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DiaryEntryCopyWith<DiaryEntry> get copyWith => _$DiaryEntryCopyWithImpl<DiaryEntry>(this as DiaryEntry, _$identity);

  /// Serializes this DiaryEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DiaryEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.game, game) || other.game == game)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewText, reviewText) || other.reviewText == reviewText)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.isLikedByMe, isLikedByMe) || other.isLikedByMe == isLikedByMe)&&(identical(other.username, username) || other.username == username));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,game,rating,reviewText,createdAt,likesCount,isLikedByMe,username);

@override
String toString() {
  return 'DiaryEntry(id: $id, game: $game, rating: $rating, reviewText: $reviewText, createdAt: $createdAt, likesCount: $likesCount, isLikedByMe: $isLikedByMe, username: $username)';
}


}

/// @nodoc
abstract mixin class $DiaryEntryCopyWith<$Res>  {
  factory $DiaryEntryCopyWith(DiaryEntry value, $Res Function(DiaryEntry) _then) = _$DiaryEntryCopyWithImpl;
@useResult
$Res call({
 String id, Game game, double rating, String reviewText, DateTime createdAt, int likesCount, bool isLikedByMe, String? username
});


$GameCopyWith<$Res> get game;

}
/// @nodoc
class _$DiaryEntryCopyWithImpl<$Res>
    implements $DiaryEntryCopyWith<$Res> {
  _$DiaryEntryCopyWithImpl(this._self, this._then);

  final DiaryEntry _self;
  final $Res Function(DiaryEntry) _then;

/// Create a copy of DiaryEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? game = null,Object? rating = null,Object? reviewText = null,Object? createdAt = null,Object? likesCount = null,Object? isLikedByMe = null,Object? username = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,game: null == game ? _self.game : game // ignore: cast_nullable_to_non_nullable
as Game,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewText: null == reviewText ? _self.reviewText : reviewText // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,isLikedByMe: null == isLikedByMe ? _self.isLikedByMe : isLikedByMe // ignore: cast_nullable_to_non_nullable
as bool,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of DiaryEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameCopyWith<$Res> get game {
  
  return $GameCopyWith<$Res>(_self.game, (value) {
    return _then(_self.copyWith(game: value));
  });
}
}


/// Adds pattern-matching-related methods to [DiaryEntry].
extension DiaryEntryPatterns on DiaryEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DiaryEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DiaryEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DiaryEntry value)  $default,){
final _that = this;
switch (_that) {
case _DiaryEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DiaryEntry value)?  $default,){
final _that = this;
switch (_that) {
case _DiaryEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  Game game,  double rating,  String reviewText,  DateTime createdAt,  int likesCount,  bool isLikedByMe,  String? username)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DiaryEntry() when $default != null:
return $default(_that.id,_that.game,_that.rating,_that.reviewText,_that.createdAt,_that.likesCount,_that.isLikedByMe,_that.username);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  Game game,  double rating,  String reviewText,  DateTime createdAt,  int likesCount,  bool isLikedByMe,  String? username)  $default,) {final _that = this;
switch (_that) {
case _DiaryEntry():
return $default(_that.id,_that.game,_that.rating,_that.reviewText,_that.createdAt,_that.likesCount,_that.isLikedByMe,_that.username);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  Game game,  double rating,  String reviewText,  DateTime createdAt,  int likesCount,  bool isLikedByMe,  String? username)?  $default,) {final _that = this;
switch (_that) {
case _DiaryEntry() when $default != null:
return $default(_that.id,_that.game,_that.rating,_that.reviewText,_that.createdAt,_that.likesCount,_that.isLikedByMe,_that.username);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DiaryEntry implements DiaryEntry {
  const _DiaryEntry({required this.id, required this.game, required this.rating, required this.reviewText, required this.createdAt, this.likesCount = 0, this.isLikedByMe = false, this.username});
  factory _DiaryEntry.fromJson(Map<String, dynamic> json) => _$DiaryEntryFromJson(json);

@override final  String id;
@override final  Game game;
@override final  double rating;
@override final  String reviewText;
@override final  DateTime createdAt;
@override@JsonKey() final  int likesCount;
@override@JsonKey() final  bool isLikedByMe;
@override final  String? username;

/// Create a copy of DiaryEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DiaryEntryCopyWith<_DiaryEntry> get copyWith => __$DiaryEntryCopyWithImpl<_DiaryEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DiaryEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DiaryEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.game, game) || other.game == game)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.reviewText, reviewText) || other.reviewText == reviewText)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.likesCount, likesCount) || other.likesCount == likesCount)&&(identical(other.isLikedByMe, isLikedByMe) || other.isLikedByMe == isLikedByMe)&&(identical(other.username, username) || other.username == username));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,game,rating,reviewText,createdAt,likesCount,isLikedByMe,username);

@override
String toString() {
  return 'DiaryEntry(id: $id, game: $game, rating: $rating, reviewText: $reviewText, createdAt: $createdAt, likesCount: $likesCount, isLikedByMe: $isLikedByMe, username: $username)';
}


}

/// @nodoc
abstract mixin class _$DiaryEntryCopyWith<$Res> implements $DiaryEntryCopyWith<$Res> {
  factory _$DiaryEntryCopyWith(_DiaryEntry value, $Res Function(_DiaryEntry) _then) = __$DiaryEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, Game game, double rating, String reviewText, DateTime createdAt, int likesCount, bool isLikedByMe, String? username
});


@override $GameCopyWith<$Res> get game;

}
/// @nodoc
class __$DiaryEntryCopyWithImpl<$Res>
    implements _$DiaryEntryCopyWith<$Res> {
  __$DiaryEntryCopyWithImpl(this._self, this._then);

  final _DiaryEntry _self;
  final $Res Function(_DiaryEntry) _then;

/// Create a copy of DiaryEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? game = null,Object? rating = null,Object? reviewText = null,Object? createdAt = null,Object? likesCount = null,Object? isLikedByMe = null,Object? username = freezed,}) {
  return _then(_DiaryEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,game: null == game ? _self.game : game // ignore: cast_nullable_to_non_nullable
as Game,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviewText: null == reviewText ? _self.reviewText : reviewText // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,likesCount: null == likesCount ? _self.likesCount : likesCount // ignore: cast_nullable_to_non_nullable
as int,isLikedByMe: null == isLikedByMe ? _self.isLikedByMe : isLikedByMe // ignore: cast_nullable_to_non_nullable
as bool,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of DiaryEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameCopyWith<$Res> get game {
  
  return $GameCopyWith<$Res>(_self.game, (value) {
    return _then(_self.copyWith(game: value));
  });
}
}

// dart format on
