import 'package:json_annotation/json_annotation.dart';
import 'package:hotel_booking_app/domain/hotels/models/rating.dart';

part 'rating_dto.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
final class RatingDto {
  const RatingDto({
    required this.recommendationRate,
    required this.reviewsCount,
    required this.score,
    required this.scoreDescription,
  });

  @JsonKey(name: 'recommendation-rate')
  final int recommendationRate;

  @JsonKey(name: 'reviews-count')
  final int reviewsCount;

  final double score;

  @JsonKey(name: 'score-description')
  final String scoreDescription;

  factory RatingDto.fromJson(Map<String, dynamic> json) =>
      _$RatingDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RatingDtoToJson(this);
}

extension RatingDtoExtension on RatingDto {
  Rating toDomain() {
    return Rating(
      recommendationRate: recommendationRate,
      reviewsCount: reviewsCount,
      score: score,
      scoreDescription: scoreDescription,
    );
  }
}

extension RatingExtension on Rating {
  RatingDto toDto() {
    return RatingDto(
      recommendationRate: recommendationRate,
      reviewsCount: reviewsCount,
      score: score,
      scoreDescription: scoreDescription,
    );
  }
}
