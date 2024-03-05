import 'package:json_annotation/json_annotation.dart';
import 'package:tripplanner/features/home/data/model/review_api_model.dart';

import '../model/packagehome_api_model.dart';

part 'get_all_reviews_dto.g.dart';

@JsonSerializable()
class GetAllReviewsDTO {
  final List<ReviewApiModel> reviews;

  GetAllReviewsDTO({
    required this.reviews,
  });

  factory GetAllReviewsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllReviewsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllReviewsDTOToJson(this);
}
