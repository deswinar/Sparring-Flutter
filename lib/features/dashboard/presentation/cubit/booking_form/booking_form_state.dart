part of 'booking_form_cubit.dart';

abstract class BookingFormState extends Equatable {
  const BookingFormState();

  @override
  List<Object?> get props => [];
}

class BookingFormInitial extends BookingFormState {}

class BookingFormLoading extends BookingFormState {}

class BookingFormSuccess extends BookingFormState {
  final Booking booking;

  const BookingFormSuccess({required this.booking});

  @override
  List<Object?> get props => [booking];
}

class BookingFormError extends BookingFormState {
  final String message;

  const BookingFormError({required this.message});

  @override
  List<Object?> get props => [message];
}
