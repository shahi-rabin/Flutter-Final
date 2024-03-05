// import 'package:equatable/equatable.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// import '../../domain/entity/package_entity.dart';

// part 'packagehome_api_model.g.dart';

// final homeApiModelProvider =
//     Provider<HomeApiModel>((ref) => HomeApiModel.empty());

// @JsonSerializable()
// class HomeApiModel extends Equatable {
//   @JsonKey(name: '_id')
//   final String? packageId;
//   final String title;
//   final String author;
//   final String description;
//   final String genre;
//   final String language;
//   final String? packageCover;
//   final String? date;
//   final String? formattedCreatedAt;
//   final bool? isPackagemarked;
//   final Map<String, dynamic>? user;

//   const HomeApiModel({
//     this.packageId,
//     required this.title,
//     required this.author,
//     required this.description,
//     required this.genre,
//     required this.language,
//     this.packageCover,
//     this.date,
//     this.formattedCreatedAt,
//     this.isPackagemarked,
//     this.user,
//   });

//   HomeApiModel.empty()
//       : packageId = '',
//         title = '',
//         author = '',
//         description = '',
//         genre = '',
//         language = '',
//         packageCover = '',
//         date = '',
//         formattedCreatedAt = '',
//         isPackagemarked = false,
//         user = {};

//   // Convert API Object to Entity
//   PackageEntity toEntity() => PackageEntity(
//         packageId: packageId ?? '',
//         title: title,
//         author: author,
//         description: description,
//         genre: genre,
//         language: language,
//         packageCover: packageCover,
//         date: date,
//         formattedCreatedAt: formattedCreatedAt ?? '',
//         isPackagemarked: isPackagemarked ?? false,
//         user: user,
//       );

//   // Convert Entity to API Object
//   HomeApiModel fromEntity(PackageEntity entity) => HomeApiModel(
//         packageId: packageId ?? '',
//         title: title,
//         author: author,
//         description: description,
//         genre: genre,
//         language: language,
//         packageCover: packageCover,
//         date: date,
//         formattedCreatedAt: formattedCreatedAt,
//         isPackagemarked: isPackagemarked,
//         user: user,
//       );

//   // Convert API List to Entity List
//   List<PackageEntity> toEntityList(List<HomeApiModel> models) =>
//       models.map((model) => model.toEntity()).toList();

//   @override
//   List<Object?> get props => [
//         packageId,
//         title,
//         author,
//         description,
//         genre,
//         language,
//         packageCover,
//         date,
//         formattedCreatedAt,
//         isPackagemarked,
//         user,
//       ];

//   factory HomeApiModel.fromJson(Map<String, dynamic> json) =>
//       _$HomeApiModelFromJson(json);

//   Map<String, dynamic> toJson() => _$HomeApiModelToJson(this);
// }
