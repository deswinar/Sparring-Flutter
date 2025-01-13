import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../auth/data/models/user_model.dart';
import '../../../../auth/domain/entities/user.dart';
import '../../../domain/usecases/get_profle_usecase.dart';
import '../../../domain/usecases/update_profile_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final UpdateProfileUseCase updateProfileUseCase;
  final GetProfileUseCase getProfileUseCase;

  ProfileCubit(
      {required this.updateProfileUseCase, required this.getProfileUseCase})
      : super(ProfileInitial());

  Future<void> updateProfile(User user) async {
    emit(ProfileLoading());
    final result =
        await updateProfileUseCase.call(UpdateProfileParams(user: user));
    result.fold((failure) => emit(ProfileError(message: failure.message)),
        (user) => emit(ProfileSuccess(user)));
  }

  Future<void> getProfile() async {
    emit(ProfileLoading());
    final result = await getProfileUseCase.call();
    result.fold((failure) => emit(ProfileError(message: failure.message)),
        (user) => emit(ProfileSuccess(user)));
  }
}
