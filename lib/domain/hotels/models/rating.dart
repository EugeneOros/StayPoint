import 'package:equatable/equatable.dart';

class Rating extends Equatable {
  final int recommendationRate;
  final int reviewsCount;
  final double score;
  final String scoreDescription;

  const Rating({
    required this.recommendationRate,
    required this.reviewsCount,
    required this.score,
    required this.scoreDescription,
  });

  @override
  List<Object> get props => [
        recommendationRate,
        reviewsCount,
        score,
        scoreDescription,
      ];
}
