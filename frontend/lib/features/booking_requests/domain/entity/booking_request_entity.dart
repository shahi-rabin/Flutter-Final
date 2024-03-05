import 'package:equatable/equatable.dart';

class BookingRequestEntity extends Equatable {
  final String? bookingId;
  final Map<String, dynamic>? requester;
  final String? requestedUserId;
  final String? email;
  final String? contactNum;
  final String furtherRequirements;
  final String status;
  final Map<String, dynamic>? requestedPackage;
 

  const BookingRequestEntity({
    this.bookingId,
    this.requester,
    this.requestedPackage,
    this.requestedUserId,
    this.email,
    this.contactNum,
    this.furtherRequirements = "",
    this.status = "pending",
    
  });

  factory BookingRequestEntity.fromJson(Map<String, dynamic> json) {

    return BookingRequestEntity(
      bookingId: json["_id"],
      requestedPackage: json["requestedPackage"],
      requester: json["requester"],
      requestedUserId: json["requestedUser"],
      email: json["email"],
      contactNum: json["contactNum"],
      furtherRequirements: json["furtherRequirements"] ?? "",
      status: json["status"] ?? "pending",
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": bookingId,
      'requestedPackage': requestedPackage,
      "requester": requester,
      "requestedUser": requestedUserId,
      "email": email,
      "contactNum": contactNum,
      "furtherRequirements": furtherRequirements,
      "status": status,
     
    };
  }

  @override
  List<Object?> get props => [
        bookingId,
        requestedPackage,
        requester,
        requestedUserId,
        email,
        contactNum,
        furtherRequirements,
        status,
      
      ];
}