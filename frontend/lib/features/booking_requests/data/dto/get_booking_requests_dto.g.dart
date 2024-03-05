// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_booking_requests_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetBookingRequestsDTO _$GetBookingRequestsDTOFromJson(
        Map<String, dynamic> json) =>
    GetBookingRequestsDTO(
      data: (json['data'] as List<dynamic>)
          .map(
              (e) => BookingRequestApiModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetBookingRequestsDTOToJson(
        GetBookingRequestsDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
