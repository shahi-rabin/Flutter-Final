import 'package:json_annotation/json_annotation.dart';
import 'package:tripplanner/features/home/data/model/packagehome_api_model.dart';

part 'get_searched_packages_dto.g.dart';

@JsonSerializable()
class GetSearchedPackagesDTO {
  final List<PackagehomeApiModel> data;

  GetSearchedPackagesDTO({
    required this.data,
  });

  factory GetSearchedPackagesDTO.fromJson(Map<String, dynamic> json) =>
      _$GetSearchedPackagesDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetSearchedPackagesDTOToJson(this);
}
