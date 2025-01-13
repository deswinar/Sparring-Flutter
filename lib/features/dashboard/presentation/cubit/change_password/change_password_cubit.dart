import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../auth/domain/entities/user.dart';
import '../../../domain/usecases/change_password_usecase.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  final ChangePasswordUseCase changePasswordUseCase;

  ChangePasswordCubit({required this.changePasswordUseCase})
      : super(ChangePasswordInitial());

  /// Perform change password
  Future<void> changePassword(
      String currentPassword, String newPassword) async {
    emit(ChangePasswordLoading());
    final result = await changePasswordUseCase(ChangePasswordParams(
        currentPassword: currentPassword, newPassword: newPassword));
    result.fold(
      (failure) => emit(ChangePasswordError(failure.message)),
      (user) => emit(ChangePasswordSuccess(user)),
    );
  }
}
