// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'booking_request_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BookingRequestApiModel _$BookingRequestApiModelFromJson(
        Map<String, dynamic> json) =>
    BookingRequestApiModel(
      bookingId: json['_id'] as String?,
      requester: json['requester'] as Map<String, dynamic>?,
      requestedPackage: json['requestedPackage'] as Map<String, dynamic>?,
      requestedUserId: json['requestedUser'] as String?,
      email: json['email'] as String?,
      contactNum: json['contactNum'] as String?,
      furtherRequirements: json['furtherRequirements'] as String? ?? "",
      status: json['status'] as String? ?? "pending",
    );

Map<String, dynamic> _$BookingRequestApiModelToJson(
        BookingRequestApiModel instance) =>
    <String, dynamic>{
      '_id': instance.bookingId,
      'requester': instance.requester,
      'requestedPackage': instance.requestedPackage,
      'requestedUser': instance.requestedUserId,
      'email': instance.email,
      'contactNum': instance.contactNum,
      'furtherRequirements': instance.furtherRequirements,
      'status': instance.status,
    };
