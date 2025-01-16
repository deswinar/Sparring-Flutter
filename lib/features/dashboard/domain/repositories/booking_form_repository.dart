import 'package:dartz/dartz.dart';
import '../../../../core/errors/failure.dart';
import '../entities/booking.dart';
import '../usecases/booking_form/create_booking_usecase.dart';

/// Abstract repository for authentication-related operations
abstract class BookingFormRepository {
  Future<Either<Failure, Booking>> createBooking(CreateBookingParams params);
}
