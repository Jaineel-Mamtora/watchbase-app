// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'popular_movies_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PopularMoviesModel {

 num get page; List<MovieModel> get results;@JsonKey(name: 'total_pages') num get totalPages;@JsonKey(name: 'total_results') num get totalResults;
/// Create a copy of PopularMoviesModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PopularMoviesModelCopyWith<PopularMoviesModel> get copyWith => _$PopularMoviesModelCopyWithImpl<PopularMoviesModel>(this as PopularMoviesModel, _$identity);

  /// Serializes this PopularMoviesModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PopularMoviesModel&&(identical(other.page, page) || other.page == page)&&const DeepCollectionEquality().equals(other.results, results)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalResults, totalResults) || other.totalResults == totalResults));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,const DeepCollectionEquality().hash(results),totalPages,totalResults);

@override
String toString() {
  return 'PopularMoviesModel(page: $page, results: $results, totalPages: $totalPages, totalResults: $totalResults)';
}


}

/// @nodoc
abstract mixin class $PopularMoviesModelCopyWith<$Res>  {
  factory $PopularMoviesModelCopyWith(PopularMoviesModel value, $Res Function(PopularMoviesModel) _then) = _$PopularMoviesModelCopyWithImpl;
@useResult
$Res call({
 num page, List<MovieModel> results,@JsonKey(name: 'total_pages') num totalPages,@JsonKey(name: 'total_results') num totalResults
});




}
/// @nodoc
class _$PopularMoviesModelCopyWithImpl<$Res>
    implements $PopularMoviesModelCopyWith<$Res> {
  _$PopularMoviesModelCopyWithImpl(this._self, this._then);

  final PopularMoviesModel _self;
  final $Res Function(PopularMoviesModel) _then;

/// Create a copy of PopularMoviesModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? page = null,Object? results = null,Object? totalPages = null,Object? totalResults = null,}) {
  return _then(_self.copyWith(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as num,results: null == results ? _self.results : results // ignore: cast_nullable_to_non_nullable
as List<MovieModel>,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as num,totalResults: null == totalResults ? _self.totalResults : totalResults // ignore: cast_nullable_to_non_nullable
as num,
  ));
}

}


/// Adds pattern-matching-related methods to [PopularMoviesModel].
extension PopularMoviesModelPatterns on PopularMoviesModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PopularMoviesModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PopularMoviesModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PopularMoviesModel value)  $default,){
final _that = this;
switch (_that) {
case _PopularMoviesModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PopularMoviesModel value)?  $default,){
final _that = this;
switch (_that) {
case _PopularMoviesModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( num page,  List<MovieModel> results, @JsonKey(name: 'total_pages')  num totalPages, @JsonKey(name: 'total_results')  num totalResults)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PopularMoviesModel() when $default != null:
return $default(_that.page,_that.results,_that.totalPages,_that.totalResults);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( num page,  List<MovieModel> results, @JsonKey(name: 'total_pages')  num totalPages, @JsonKey(name: 'total_results')  num totalResults)  $default,) {final _that = this;
switch (_that) {
case _PopularMoviesModel():
return $default(_that.page,_that.results,_that.totalPages,_that.totalResults);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( num page,  List<MovieModel> results, @JsonKey(name: 'total_pages')  num totalPages, @JsonKey(name: 'total_results')  num totalResults)?  $default,) {final _that = this;
switch (_that) {
case _PopularMoviesModel() when $default != null:
return $default(_that.page,_that.results,_that.totalPages,_that.totalResults);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PopularMoviesModel implements PopularMoviesModel {
   _PopularMoviesModel({required this.page, required final  List<MovieModel> results, @JsonKey(name: 'total_pages') required this.totalPages, @JsonKey(name: 'total_results') required this.totalResults}): _results = results;
  factory _PopularMoviesModel.fromJson(Map<String, dynamic> json) => _$PopularMoviesModelFromJson(json);

@override final  num page;
 final  List<MovieModel> _results;
@override List<MovieModel> get results {
  if (_results is EqualUnmodifiableListView) return _results;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_results);
}

@override@JsonKey(name: 'total_pages') final  num totalPages;
@override@JsonKey(name: 'total_results') final  num totalResults;

/// Create a copy of PopularMoviesModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PopularMoviesModelCopyWith<_PopularMoviesModel> get copyWith => __$PopularMoviesModelCopyWithImpl<_PopularMoviesModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PopularMoviesModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PopularMoviesModel&&(identical(other.page, page) || other.page == page)&&const DeepCollectionEquality().equals(other._results, _results)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.totalResults, totalResults) || other.totalResults == totalResults));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,const DeepCollectionEquality().hash(_results),totalPages,totalResults);

@override
String toString() {
  return 'PopularMoviesModel(page: $page, results: $results, totalPages: $totalPages, totalResults: $totalResults)';
}


}

/// @nodoc
abstract mixin class _$PopularMoviesModelCopyWith<$Res> implements $PopularMoviesModelCopyWith<$Res> {
  factory _$PopularMoviesModelCopyWith(_PopularMoviesModel value, $Res Function(_PopularMoviesModel) _then) = __$PopularMoviesModelCopyWithImpl;
@override @useResult
$Res call({
 num page, List<MovieModel> results,@JsonKey(name: 'total_pages') num totalPages,@JsonKey(name: 'total_results') num totalResults
});




}
/// @nodoc
class __$PopularMoviesModelCopyWithImpl<$Res>
    implements _$PopularMoviesModelCopyWith<$Res> {
  __$PopularMoviesModelCopyWithImpl(this._self, this._then);

  final _PopularMoviesModel _self;
  final $Res Function(_PopularMoviesModel) _then;

/// Create a copy of PopularMoviesModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = null,Object? results = null,Object? totalPages = null,Object? totalResults = null,}) {
  return _then(_PopularMoviesModel(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as num,results: null == results ? _self._results : results // ignore: cast_nullable_to_non_nullable
as List<MovieModel>,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as num,totalResults: null == totalResults ? _self.totalResults : totalResults // ignore: cast_nullable_to_non_nullable
as num,
  ));
}


}

// dart format on
