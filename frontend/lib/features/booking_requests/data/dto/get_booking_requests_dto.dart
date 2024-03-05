import 'package:json_annotation/json_annotation.dart';
import 'package:tripplanner/features/booking_requests/data/model/booking_request_api_model.dart';

part 'get_booking_requests_dto.g.dart';

@JsonSerializable()
class GetBookingRequestsDTO {
  final List<BookingRequestApiModel> data;

  GetBookingRequestsDTO({
    required this.data,
  });

  factory GetBookingRequestsDTO.fromJson(Map<String, dynamic> json) =>
      _$GetBookingRequestsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$GetBookingRequestsDTOToJson(this);
}
