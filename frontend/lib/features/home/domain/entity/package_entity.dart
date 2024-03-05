import 'package:equatable/equatable.dart';

class PackageEntity extends Equatable {
  final String? destinationName;
  final String? packageId;
  final String packageName;
  final String packageDescription;
  final String packageTime;
  final String location;
  final int? price;
  final int? remaining;
  final String? route;
  final String? packageCover;
  final String packagePlan;
  final bool? isBookmarked;
  final Map<String, dynamic>? user;
  
  

  const PackageEntity({
    this.destinationName,
    this.packageId,
    required this.packageName,
    required this.packageDescription,
    required this.packageTime,
    required this.location,
    this.price,
    this.remaining,
    this.route,
    this.packageCover,
    required this.packagePlan,
    this.isBookmarked,
    this.user,


  });

  factory PackageEntity.fromJson(Map<String, dynamic> json) => PackageEntity(
    destinationName: json["destination_name"],
        packageId: json["_id"],
        packageName: json["package_name"],
        packageDescription: json["package_description"],
        packageTime: json["package_time"],
        location: json["location"],
        price: json["price"],
        remaining: json["remaining"],
        route: json["route"],
        packageCover: json["package_cover"],
        packagePlan: json["package_plan"],
        isBookmarked: json["isBookmarked"],
        user: json["user"] as Map<String, dynamic>?,

        
        
      );

  Map<String, dynamic> toJson() => {

        "_id": packageId,
        "destinationName": destinationName,
        "packageName": packageName,
        "packageDescription": packageDescription,
        "packageTime": packageTime,
        "location": location,
        "price": price,
        "remaining": remaining,
        "route": route,
        "packageCover": packageCover,
        "packagePlan": packagePlan,
        "isBookmarked": isBookmarked,
        "user": user,
        
      };

  @override
  List<Object?> get props => [
        packageId,
        destinationName,
        packageName,
        packageDescription,
        packageTime,
        location,
        price,
        remaining,
        route,
        packageCover,
        packagePlan,
        isBookmarked,
        user,
        
        
      ];
}
