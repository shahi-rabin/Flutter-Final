// Mocks generated by Mockito 5.4.2 from annotations
// in tripplanner/test/unit_test/booking_unit_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:dartz/dartz.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;
import 'package:tripplanner/core/failure/failure.dart' as _i6;
import 'package:tripplanner/features/booking_requests/domain/entity/booking_request_entity.dart'
    as _i7;
import 'package:tripplanner/features/booking_requests/domain/repository/booking_request_repository.dart'
    as _i2;
import 'package:tripplanner/features/booking_requests/domain/use_case/booking_request_use_case.dart'
    as _i4;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeIBookingRequestRepository_0 extends _i1.SmartFake
    implements _i2.IBookingRequestRepository {
  _FakeIBookingRequestRepository_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeEither_1<L, R> extends _i1.SmartFake implements _i3.Either<L, R> {
  _FakeEither_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [BookingRequestUseCase].
///
/// See the documentation for Mockito's code generation for more information.
class MockBookingRequestUseCase extends _i1.Mock
    implements _i4.BookingRequestUseCase {
  @override
  _i2.IBookingRequestRepository get bookingRequestRepository =>
      (super.noSuchMethod(
        Invocation.getter(#bookingRequestRepository),
        returnValue: _FakeIBookingRequestRepository_0(
          this,
          Invocation.getter(#bookingRequestRepository),
        ),
        returnValueForMissingStub: _FakeIBookingRequestRepository_0(
          this,
          Invocation.getter(#bookingRequestRepository),
        ),
      ) as _i2.IBookingRequestRepository);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.BookingRequestEntity>>>
      getBookingRequests() => (super.noSuchMethod(
            Invocation.method(
              #getBookingRequests,
              [],
            ),
            returnValue: _i5.Future<
                    _i3
                    .Either<_i6.Failure, List<_i7.BookingRequestEntity>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.BookingRequestEntity>>(
              this,
              Invocation.method(
                #getBookingRequests,
                [],
              ),
            )),
            returnValueForMissingStub: _i5.Future<
                    _i3
                    .Either<_i6.Failure, List<_i7.BookingRequestEntity>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.BookingRequestEntity>>(
              this,
              Invocation.method(
                #getBookingRequests,
                [],
              ),
            )),
          ) as _i5
              .Future<_i3.Either<_i6.Failure, List<_i7.BookingRequestEntity>>>);

  @override
  _i5.Future<_i3.Either<_i6.Failure, bool>> createBookingRequest(
    _i7.BookingRequestEntity? bookingRequest,
    String? requestedBook,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #createBookingRequest,
          [
            bookingRequest,
            requestedBook,
          ],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, bool>>.value(
            _FakeEither_1<_i6.Failure, bool>(
          this,
          Invocation.method(
            #createBookingRequest,
            [
              bookingRequest,
              requestedBook,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, bool>>.value(
                _FakeEither_1<_i6.Failure, bool>(
          this,
          Invocation.method(
            #createBookingRequest,
            [
              bookingRequest,
              requestedBook,
            ],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, bool>>);

  @override
  _i5.Future<_i3.Either<_i6.Failure, bool>> acceptBookingRequest(
          String? requestId) =>
      (super.noSuchMethod(
        Invocation.method(
          #acceptBookingRequest,
          [requestId],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, bool>>.value(
            _FakeEither_1<_i6.Failure, bool>(
          this,
          Invocation.method(
            #acceptBookingRequest,
            [requestId],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, bool>>.value(
                _FakeEither_1<_i6.Failure, bool>(
          this,
          Invocation.method(
            #acceptBookingRequest,
            [requestId],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, bool>>);

  @override
  _i5.Future<_i3.Either<_i6.Failure, bool>> declineBookingRequest(
          String? requestId) =>
      (super.noSuchMethod(
        Invocation.method(
          #declineBookingRequest,
          [requestId],
        ),
        returnValue: _i5.Future<_i3.Either<_i6.Failure, bool>>.value(
            _FakeEither_1<_i6.Failure, bool>(
          this,
          Invocation.method(
            #declineBookingRequest,
            [requestId],
          ),
        )),
        returnValueForMissingStub:
            _i5.Future<_i3.Either<_i6.Failure, bool>>.value(
                _FakeEither_1<_i6.Failure, bool>(
          this,
          Invocation.method(
            #declineBookingRequest,
            [requestId],
          ),
        )),
      ) as _i5.Future<_i3.Either<_i6.Failure, bool>>);

  @override
  _i5.Future<_i3.Either<_i6.Failure, List<_i7.BookingRequestEntity>>>
      getAcceptedBookingRequest() => (super.noSuchMethod(
            Invocation.method(
              #getAcceptedBookingRequest,
              [],
            ),
            returnValue: _i5.Future<
                    _i3
                    .Either<_i6.Failure, List<_i7.BookingRequestEntity>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.BookingRequestEntity>>(
              this,
              Invocation.method(
                #getAcceptedBookingRequest,
                [],
              ),
            )),
            returnValueForMissingStub: _i5.Future<
                    _i3
                    .Either<_i6.Failure, List<_i7.BookingRequestEntity>>>.value(
                _FakeEither_1<_i6.Failure, List<_i7.BookingRequestEntity>>(
              this,
              Invocation.method(
                #getAcceptedBookingRequest,
                [],
              ),
            )),
          ) as _i5
              .Future<_i3.Either<_i6.Failure, List<_i7.BookingRequestEntity>>>);
}