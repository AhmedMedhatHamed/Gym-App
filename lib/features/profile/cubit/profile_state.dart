part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoaded extends ProfileState {
  final int selectedBadgeIndex;
  final Uint8List? avatarBytes;
  final List<ProfileBadgeModel> badges;
  final List<ProfileWorkoutLogModel> workoutLogs;
  final bool isLoggingOut;
  final String userName;

  ProfileLoaded({
    this.selectedBadgeIndex = 0,
    this.avatarBytes,
    required this.badges,
    required this.workoutLogs,
    this.isLoggingOut = false,
    this.userName = '',
  });

  ProfileLoaded copyWith({
    int? selectedBadgeIndex,
    Uint8List? Function()? avatarBytes,
    List<ProfileBadgeModel>? badges,
    List<ProfileWorkoutLogModel>? workoutLogs,
    bool? isLoggingOut,
    String? userName,
  }) {
    return ProfileLoaded(
      selectedBadgeIndex: selectedBadgeIndex ?? this.selectedBadgeIndex,
      avatarBytes: avatarBytes != null ? avatarBytes() : this.avatarBytes,
      badges: badges ?? this.badges,
      workoutLogs: workoutLogs ?? this.workoutLogs,
      isLoggingOut: isLoggingOut ?? this.isLoggingOut,
      userName: userName ?? this.userName,
    );
  }
}

final class ProfileLogoutSuccess extends ProfileState {}

final class ProfileActionError extends ProfileState {
  final String message;
  final ProfileLoaded previousState;

  ProfileActionError({
    required this.message,
    required this.previousState,
  });
}
