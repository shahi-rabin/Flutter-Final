import 'package:json_annotation/json_annotation.dart';
import 'package:tripplanner/features/home/data/model/packagehome_api_model.dart';

part 'get_bookmarked_packages_dto.g.dart';

@JsonSerializable()
class GetBookmarkedPackagesDTO {
  final List<PackagehomeApiModel> data;

  GetBookmarkedPackagesDTO({
    required this.data,
  });

  factory GetBookmarkedPackagesDTO.fromJson(Map<String, dynamic> json) =>
      _$GetBookmarkedPackagesDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetBookmarkedPackagesDTOToJson(this);
}
