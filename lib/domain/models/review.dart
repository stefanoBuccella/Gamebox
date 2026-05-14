import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.freezed.dart';
part 'review.g.dart';

@freezed
abstract class Review with _$Review {
  const factory Review({
    required String gameId,
    required double rating,
    required String note,
    required DateTime createdAt,
  }) = _Review;

  factory Review.fromJson(Map<String, Object?> json) => _$ReviewFromJson(json);
}
