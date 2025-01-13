part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  final User user;

  const ProfileSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class ProfileError extends ProfileState {
  final String message;
  const ProfileError({required this.message});
  @override
  List<Object> get props => [message];
}
