import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entity/booking_request_entity.dart';

part 'booking_request_api_model.g.dart';

final bookingRequestApiModelProvider = Provider<BookingRequestApiModel>(
    (ref) => const BookingRequestApiModel.empty());

@JsonSerializable()
class BookingRequestApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? bookingId;
  @JsonKey(name: 'requester')
  final Map<String, dynamic>? requester;
  @JsonKey(name: 'requestedPackage')
  final Map<String, dynamic>? requestedPackage;
  @JsonKey(name: 'requestedUser')
  final String? requestedUserId;
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'contactNum')
  final String? contactNum;
  @JsonKey(name: 'furtherRequirements')
  final String furtherRequirements;
  @JsonKey(name: 'status')
  final String status;
  

  const BookingRequestApiModel({
    this.bookingId,
    this.requester,
    this.requestedPackage,
    this.requestedUserId,
     this.email,
    this.contactNum,
    this.furtherRequirements = "",
    this.status = "pending"
   
  });

  const BookingRequestApiModel.empty()
      : bookingId = '',

        requester = null,
        requestedPackage = null,
        requestedUserId = null,
        email = '',
        contactNum = '',
        furtherRequirements = '',
        status = '';
        

  // Convert API Object to Entity
  BookingRequestEntity toEntity() => BookingRequestEntity(
        bookingId: bookingId ??'',
        requester: requester,
        requestedPackage: requestedPackage,
        requestedUserId: requestedUserId,
        email: email,
        contactNum: contactNum,
        furtherRequirements: furtherRequirements,
        status: status
        
      );

  // Convert Entity to API Object
  BookingRequestApiModel fromEntity(BookingRequestEntity entity) =>
      BookingRequestApiModel(
        bookingId: entity.bookingId,
        requester: entity.requester,
        requestedPackage: entity.requestedPackage,
        requestedUserId: entity.requestedUserId,
        email: entity.email,
        contactNum: entity.contactNum,
        furtherRequirements: entity.furtherRequirements,
        status: entity.status,
      );

  // Convert API List to Entity List
  List<BookingRequestEntity> toEntityList(
          List<BookingRequestApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

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

  factory BookingRequestApiModel.fromJson(Map<String, dynamic> json) =>
      _$BookingRequestApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$BookingRequestApiModelToJson(this);
}
