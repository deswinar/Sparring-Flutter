import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/booking.dart';
import '../../../domain/usecases/booking_form/create_booking_usecase.dart';

part 'booking_form_state.dart';

class BookingFormCubit extends Cubit<BookingFormState> {
  final CreateBookingUseCase createBookingUseCase;

  BookingFormCubit({required this.createBookingUseCase})
      : super(BookingFormInitial());

  Future<void> createBooking({
    required String arenaId,
    required String fieldId,
    required String userId,
    required List<Map<String, DateTime>> bookings,
    required double totalPrice,
  }) async {
    emit(BookingFormLoading());
    final result = await createBookingUseCase.call(CreateBookingParams(
      arenaId: arenaId,
      fieldId: fieldId,
      userId: userId,
      bookings: bookings,
      totalPrice: totalPrice,
    ));
    result.fold(
      (failure) => emit(BookingFormError(message: failure.message)),
      (booking) => emit(BookingFormSuccess(booking: booking)),
    );
  }
}
