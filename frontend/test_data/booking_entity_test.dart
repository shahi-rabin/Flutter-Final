import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:tripplanner/features/booking_requests/domain/entity/booking_request_entity.dart';


Future<List<BookingRequestEntity>> getBookingRequestsList() async {
  final response =
      await rootBundle.loadString('test_data/booking_entity_test.json');
  final jsonList = await json.decode(response);

  final List<BookingRequestEntity> exchangeList = jsonList
      .map<BookingRequestEntity>(
        (json) => BookingRequestEntity.fromJson(json),
      )
      .toList();

  return Future.value(exchangeList);
}