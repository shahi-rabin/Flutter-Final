import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/profile_entity.dart';

part 'profile_api_model.g.dart';

final profileApiModelProvider =
    Provider<ProfileApiModel>((ref) => const ProfileApiModel.empty());

@JsonSerializable()
class ProfileApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? userId;
  final String? userType;
  final String username;
  final String fullname;
  final String email;
  final String? phoneNumber;
  final String? bio;
  final String? image;

  const ProfileApiModel({
    this.userId,
    this.userType,
    required this.username,
    required this.fullname,
    required this.email,
    this.phoneNumber,
    this.bio,
    this.image,

  });

  const ProfileApiModel.empty()
      : userId = '',
        userType = '',
        username = '',
        fullname = '',
        email = '',
        phoneNumber = '',
        bio = '',
        image = '';


  // Convert API Object to Entity
  ProfileEntity toEntity() => ProfileEntity(
        userId: userId ?? '',
        userType: userType ?? '',
        username: username,
        fullname: fullname,
        email: email,
        phoneNumber: phoneNumber,
        bio: bio,
        image: image,
       
      );

  // Convert Entity to API Object
  ProfileApiModel fromEntity(ProfileEntity entity) => ProfileApiModel(
        userId: userId ?? '',
        userType: entity.userType,
        username: username,
        fullname: fullname,
        email: email,
        phoneNumber: phoneNumber,
        bio: bio,
        image: image,
      
      );

  // Convert API List to Entity List
  List<ProfileEntity> toEntityList(List<ProfileApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  List<Object?> get props => [
        userId,
        userType,
        username,
        fullname,
        email,
        phoneNumber,
        bio,
        image,
        
      ];

  factory ProfileApiModel.fromJson(Map<String, dynamic> json) =>
      _$ProfileApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileApiModelToJson(this);
}
