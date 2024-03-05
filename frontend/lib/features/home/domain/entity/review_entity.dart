import 'package:equatable/equatable.dart';
class ReviewEntity extends Equatable{
 final String? id;
 final String packageId;
 final String userId;
 final String review;
  final double rating;
  

  const ReviewEntity({
    this.id,
    required this.packageId,
    required this.userId,
    required this.review,
    required this.rating,
   
  });

  factory ReviewEntity.fromJson(Map<String, dynamic> json) {
    return ReviewEntity(
      id: json['_id'] as String,
      packageId: json['package_id'] as String,
      userId: json['user_id'] as String,
      review: json['review'] as String,
      rating: json['ratings'] as double,
     
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'package_id': packageId,
      'user_id': userId,
      'review': review,
      'rating': rating
      
    };
  }
  
  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    packageId,
    userId,
    review,
    rating
  ];
}