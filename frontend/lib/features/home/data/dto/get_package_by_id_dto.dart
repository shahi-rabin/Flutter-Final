import 'package:json_annotation/json_annotation.dart';

import '../model/packagehome_api_model.dart';

part 'get_package_by_id_dto.g.dart';

@JsonSerializable()
class GetPackageByIdDTO {
  final List<PackagehomeApiModel> data;

  GetPackageByIdDTO({
    required this.data,
  });

  factory GetPackageByIdDTO.fromJson(Map<String, dynamic> json) =>
      _$GetPackageByIdDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetPackageByIdDTOToJson(this);
}
