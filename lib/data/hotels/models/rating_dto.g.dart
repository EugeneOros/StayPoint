// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingDto _$RatingDtoFromJson(Map<String, dynamic> json) => RatingDto(
      recommendationRate: (json['recommendation-rate'] as num).toInt(),
      reviewsCount: (json['reviews-count'] as num).toInt(),
      score: (json['score'] as num).toDouble(),
      scoreDescription: json['score-description'] as String,
    );

Map<String, dynamic> _$RatingDtoToJson(RatingDto instance) => <String, dynamic>{
      'recommendation-rate': instance.recommendationRate,
      'reviews-count': instance.reviewsCount,
      'score': instance.score,
      'score-description': instance.scoreDescription,
    };
