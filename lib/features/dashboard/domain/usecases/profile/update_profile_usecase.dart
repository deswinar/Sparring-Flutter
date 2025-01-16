// domain/usecases/edit_profile_usecase.dart

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../auth/data/models/user_model.dart';
import '../../../../auth/domain/entities/user.dart';
import '../../repositories/profile_repository.dart';

class UpdateProfileUseCase {
  final ProfileRepository _profileRepository;

  UpdateProfileUseCase(this._profileRepository);

  Future<Either<Failure, User>> call(UpdateProfileParams params) {
    return _profileRepository.updateProfile(params.user);
  }
}

/// Parameters required for change password
class UpdateProfileParams extends Equatable {
  final User user;

  const UpdateProfileParams({required this.user});

  @override
  List<Object> get props => [user];
}
