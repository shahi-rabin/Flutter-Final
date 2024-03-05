import 'package:json_annotation/json_annotation.dart';

import '../model/packagehome_api_model.dart';

part 'get_all_packages_dto.g.dart';

@JsonSerializable()
class GetAllPackagesDTO {
  final List<PackagehomeApiModel> data;

  GetAllPackagesDTO({
    required this.data,
  });

  factory GetAllPackagesDTO.fromJson(Map<String, dynamic> json) =>
      _$GetAllPackagesDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetAllPackagesDTOToJson(this);
}
