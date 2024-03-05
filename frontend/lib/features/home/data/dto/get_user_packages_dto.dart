import 'package:json_annotation/json_annotation.dart';
import 'package:tripplanner/features/home/data/model/packagehome_api_model.dart';

part 'get_user_packages_dto.g.dart';

@JsonSerializable()
class GetUserPackagesDTO {
  final List<PackagehomeApiModel> data;

  GetUserPackagesDTO({
    required this.data,
  });

  factory GetUserPackagesDTO.fromJson(Map<String, dynamic> json) =>
      _$GetUserPackagesDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetUserPackagesDTOToJson(this);
}
