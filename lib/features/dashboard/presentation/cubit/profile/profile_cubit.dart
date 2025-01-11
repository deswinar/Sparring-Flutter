// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:sparring/core/error/failures.dart';
// import 'package:sparring/features/profile/domain/entities/profile.dart';
// import 'package:sparring/features/profile/domain/usecases/get_profile.dart';

// import '../../../../auth/domain/entities/user.dart';

// part 'profile_state.dart';

// class ProfileCubit extends Cubit<ProfileState> {
//   final GetProfileUseCase getProfileUseCase;

//   ProfileCubit({required this.getProfileUseCase}) : super(ProfileInitial());

//   Future<void> fetchProfile() async {
//     emit(ProfileLoading());
//     final result = await getProfile();
//     result.fold(
//       (failure) => emit(ProfileError(_mapFailureToMessage(failure))),
//       (profile) => emit(ProfileLoaded(profile)),
//     );
//   }

//   String _mapFailureToMessage(Failure failure) {
//     if (failure is NetworkFailure) return 'No internet connection.';
//     if (failure is ServerFailure) return 'Server error. Please try again.';
//     return 'Unexpected error.';
//   }
// }
