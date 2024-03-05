import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/password_entity.dart';
import '../entity/profile_entity.dart';
import '../repository/profile_repository.dart';

final profileUsecaseProvider = Provider.autoDispose<ProfileUseCase>(
  (ref) => ProfileUseCase(
    profileRepository: ref.watch(profileRepositoryProvider),
  ),
);

class ProfileUseCase {
  final IProfileRepository profileRepository;

  ProfileUseCase({required this.profileRepository});

  Future<Either<Failure, List<ProfileEntity>>> getUserInfo() {
    return profileRepository.getUserInfo();
  }

  Future<Either<Failure, bool>> changePassword(PasswordEntity password) {
    return profileRepository.changePassword(password);
  }

  Future<Either<Failure, bool>> editProfile(ProfileEntity profile) {
    return profileRepository.editProfile(profile);
  }

  Future<Either<Failure, String>> uploadProfilePicture(File file) async {
    return await profileRepository.uploadProfilePicture(file);
  }
}
