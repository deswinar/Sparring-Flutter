import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../entities/booking.dart';
import '../../repositories/booking_form_repository.dart';

class CreateBookingParams {
  final String arenaId;
  final String fieldId;
  final String userId;
  final DateTime startTime;
  final DateTime endTime;
  final double totalPrice;

  CreateBookingParams({
    required this.arenaId,
    required this.fieldId,
    required this.userId,
    required this.startTime,
    required this.endTime,
    required this.totalPrice,
  });
}

class CreateBookingUseCase {
  final BookingFormRepository repository;

  CreateBookingUseCase(this.repository);

  Future<Either<Failure, Booking>> call(CreateBookingParams params) {
    return repository.createBooking(params);
  }
}
