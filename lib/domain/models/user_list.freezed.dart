// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserList implements DiagnosticableTreeMixin {

 String get id; String get userId; String get username; String get title; String? get description; bool get isPublic; int get upvotesCount; int get downvotesCount; List<Game> get games; DateTime get createdAt; int get myVote;
/// Create a copy of UserList
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserListCopyWith<UserList> get copyWith => _$UserListCopyWithImpl<UserList>(this as UserList, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserList'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('username', username))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('isPublic', isPublic))..add(DiagnosticsProperty('upvotesCount', upvotesCount))..add(DiagnosticsProperty('downvotesCount', downvotesCount))..add(DiagnosticsProperty('games', games))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('myVote', myVote));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserList&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.upvotesCount, upvotesCount) || other.upvotesCount == upvotesCount)&&(identical(other.downvotesCount, downvotesCount) || other.downvotesCount == downvotesCount)&&const DeepCollectionEquality().equals(other.games, games)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.myVote, myVote) || other.myVote == myVote));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,username,title,description,isPublic,upvotesCount,downvotesCount,const DeepCollectionEquality().hash(games),createdAt,myVote);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserList(id: $id, userId: $userId, username: $username, title: $title, description: $description, isPublic: $isPublic, upvotesCount: $upvotesCount, downvotesCount: $downvotesCount, games: $games, createdAt: $createdAt, myVote: $myVote)';
}


}

/// @nodoc
abstract mixin class $UserListCopyWith<$Res>  {
  factory $UserListCopyWith(UserList value, $Res Function(UserList) _then) = _$UserListCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String username, String title, String? description, bool isPublic, int upvotesCount, int downvotesCount, List<Game> games, DateTime createdAt, int myVote
});




}
/// @nodoc
class _$UserListCopyWithImpl<$Res>
    implements $UserListCopyWith<$Res> {
  _$UserListCopyWithImpl(this._self, this._then);

  final UserList _self;
  final $Res Function(UserList) _then;

/// Create a copy of UserList
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? username = null,Object? title = null,Object? description = freezed,Object? isPublic = null,Object? upvotesCount = null,Object? downvotesCount = null,Object? games = null,Object? createdAt = null,Object? myVote = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,upvotesCount: null == upvotesCount ? _self.upvotesCount : upvotesCount // ignore: cast_nullable_to_non_nullable
as int,downvotesCount: null == downvotesCount ? _self.downvotesCount : downvotesCount // ignore: cast_nullable_to_non_nullable
as int,games: null == games ? _self.games : games // ignore: cast_nullable_to_non_nullable
as List<Game>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,myVote: null == myVote ? _self.myVote : myVote // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserList].
extension UserListPatterns on UserList {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserList value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserList() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserList value)  $default,){
final _that = this;
switch (_that) {
case _UserList():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserList value)?  $default,){
final _that = this;
switch (_that) {
case _UserList() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String username,  String title,  String? description,  bool isPublic,  int upvotesCount,  int downvotesCount,  List<Game> games,  DateTime createdAt,  int myVote)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserList() when $default != null:
return $default(_that.id,_that.userId,_that.username,_that.title,_that.description,_that.isPublic,_that.upvotesCount,_that.downvotesCount,_that.games,_that.createdAt,_that.myVote);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String username,  String title,  String? description,  bool isPublic,  int upvotesCount,  int downvotesCount,  List<Game> games,  DateTime createdAt,  int myVote)  $default,) {final _that = this;
switch (_that) {
case _UserList():
return $default(_that.id,_that.userId,_that.username,_that.title,_that.description,_that.isPublic,_that.upvotesCount,_that.downvotesCount,_that.games,_that.createdAt,_that.myVote);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String username,  String title,  String? description,  bool isPublic,  int upvotesCount,  int downvotesCount,  List<Game> games,  DateTime createdAt,  int myVote)?  $default,) {final _that = this;
switch (_that) {
case _UserList() when $default != null:
return $default(_that.id,_that.userId,_that.username,_that.title,_that.description,_that.isPublic,_that.upvotesCount,_that.downvotesCount,_that.games,_that.createdAt,_that.myVote);case _:
  return null;

}
}

}

/// @nodoc


class _UserList with DiagnosticableTreeMixin implements UserList {
  const _UserList({required this.id, required this.userId, this.username = 'User', required this.title, this.description, this.isPublic = true, this.upvotesCount = 0, this.downvotesCount = 0, final  List<Game> games = const [], required this.createdAt, this.myVote = 0}): _games = games;
  

@override final  String id;
@override final  String userId;
@override@JsonKey() final  String username;
@override final  String title;
@override final  String? description;
@override@JsonKey() final  bool isPublic;
@override@JsonKey() final  int upvotesCount;
@override@JsonKey() final  int downvotesCount;
 final  List<Game> _games;
@override@JsonKey() List<Game> get games {
  if (_games is EqualUnmodifiableListView) return _games;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_games);
}

@override final  DateTime createdAt;
@override@JsonKey() final  int myVote;

/// Create a copy of UserList
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserListCopyWith<_UserList> get copyWith => __$UserListCopyWithImpl<_UserList>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'UserList'))
    ..add(DiagnosticsProperty('id', id))..add(DiagnosticsProperty('userId', userId))..add(DiagnosticsProperty('username', username))..add(DiagnosticsProperty('title', title))..add(DiagnosticsProperty('description', description))..add(DiagnosticsProperty('isPublic', isPublic))..add(DiagnosticsProperty('upvotesCount', upvotesCount))..add(DiagnosticsProperty('downvotesCount', downvotesCount))..add(DiagnosticsProperty('games', games))..add(DiagnosticsProperty('createdAt', createdAt))..add(DiagnosticsProperty('myVote', myVote));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserList&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.username, username) || other.username == username)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isPublic, isPublic) || other.isPublic == isPublic)&&(identical(other.upvotesCount, upvotesCount) || other.upvotesCount == upvotesCount)&&(identical(other.downvotesCount, downvotesCount) || other.downvotesCount == downvotesCount)&&const DeepCollectionEquality().equals(other._games, _games)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.myVote, myVote) || other.myVote == myVote));
}


@override
int get hashCode => Object.hash(runtimeType,id,userId,username,title,description,isPublic,upvotesCount,downvotesCount,const DeepCollectionEquality().hash(_games),createdAt,myVote);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'UserList(id: $id, userId: $userId, username: $username, title: $title, description: $description, isPublic: $isPublic, upvotesCount: $upvotesCount, downvotesCount: $downvotesCount, games: $games, createdAt: $createdAt, myVote: $myVote)';
}


}

/// @nodoc
abstract mixin class _$UserListCopyWith<$Res> implements $UserListCopyWith<$Res> {
  factory _$UserListCopyWith(_UserList value, $Res Function(_UserList) _then) = __$UserListCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String username, String title, String? description, bool isPublic, int upvotesCount, int downvotesCount, List<Game> games, DateTime createdAt, int myVote
});




}
/// @nodoc
class __$UserListCopyWithImpl<$Res>
    implements _$UserListCopyWith<$Res> {
  __$UserListCopyWithImpl(this._self, this._then);

  final _UserList _self;
  final $Res Function(_UserList) _then;

/// Create a copy of UserList
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? username = null,Object? title = null,Object? description = freezed,Object? isPublic = null,Object? upvotesCount = null,Object? downvotesCount = null,Object? games = null,Object? createdAt = null,Object? myVote = null,}) {
  return _then(_UserList(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isPublic: null == isPublic ? _self.isPublic : isPublic // ignore: cast_nullable_to_non_nullable
as bool,upvotesCount: null == upvotesCount ? _self.upvotesCount : upvotesCount // ignore: cast_nullable_to_non_nullable
as int,downvotesCount: null == downvotesCount ? _self.downvotesCount : downvotesCount // ignore: cast_nullable_to_non_nullable
as int,games: null == games ? _self._games : games // ignore: cast_nullable_to_non_nullable
as List<Game>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,myVote: null == myVote ? _self.myVote : myVote // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
