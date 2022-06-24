import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/domain/entities/app_error.dart';

import '../../../../domain/repository/profile_repository.dart';
import '../../../reusables.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final ProfileRepository _profileRepository;

  UpdateProfileCubit(this._profileRepository) : super(UpdateProfileInitial());
  void editName(
      {required String title,
      required String firstName,
      required String lastName}) async {
    emit(UpdateProfileLoading());
    final result = await _profileRepository.updateUser({
      'title': title,
      'first_name': firstName,
      'last_name': lastName,
    });
    log(result.toString());
    emit(result.fold(
        (l) => UpdateProfileFailed(
            appErrorType: l.appErrorType,
            errorMessage: getErrorMessage(l.appErrorType)),
        (r) => const UpdateProfileSuccessfull('Account name updated.')));
  }

  void editPhoneNumber(
      {required String phoneNumber, required bool isSecurityAlert}) async {
    emit(UpdateProfileLoading());
    final result = await _profileRepository.updateUser({
      'phone_number': phoneNumber,
      'phone_receive_security_alert': isSecurityAlert,
    });
    log(result.toString());
    emit(result.fold(
        (l) => UpdateProfileFailed(
            appErrorType: l.appErrorType,
            errorMessage: getErrorMessage(l.appErrorType)),
        (r) => const UpdateProfileSuccessfull('Phone number updated.')));
  }

  void editAddress(
      {required String address,
      required String city,
      required String postCode,
      required String county,
      required String country}) async {
    emit(UpdateProfileLoading());
    final result = await _profileRepository.updateUser({
      'address': address,
      'city': city,
      'county': county,
      'postal_code': postCode,
      'country_id': country,
    });
    log(result.toString());
    emit(result.fold(
        (l) => UpdateProfileFailed(
            appErrorType: l.appErrorType,
            errorMessage: getErrorMessage(l.appErrorType)),
        (r) =>
            const UpdateProfileSuccessfull('Address updated successfully.')));
  }

  void editEmail({required String email}) async {
    emit(UpdateProfileLoading());
    final result = await _profileRepository.updateUser({'email': email});
    emit(result.fold(
        (l) => UpdateProfileFailed(
            appErrorType: l.appErrorType,
            errorMessage: getErrorMessage(l.appErrorType)),
        (r) => const UpdateProfileSuccessfull('Email updated successfully.')));
  }

  void editGiftAidOption({required bool giftAidOption}) async {
    emit(UpdateProfileLoading());
    final result = await _profileRepository
        .updateUser({'gift_aid_enabled': giftAidOption});
    emit(result.fold(
        (l) => UpdateProfileFailed(
            appErrorType: l.appErrorType,
            errorMessage: getErrorMessage(l.appErrorType)),
        (r) => const UpdateProfileSuccessfull('updated successfully.')));
  }

  void editSendMarketingEmailOption(
      {required bool editSendMarketingEmailOption}) async {
    emit(UpdateProfileLoading());
    final result = await _profileRepository
        .updateUser({'send_marketing_mail': editSendMarketingEmailOption});
    emit(result.fold(
        (l) => UpdateProfileFailed(
            appErrorType: l.appErrorType,
            errorMessage: getErrorMessage(l.appErrorType)),
        (r) => const UpdateProfileSuccessfull(' updated successfully.')));
  }

  void editAnonymousOption({required bool anonymousOption}) async {
    emit(UpdateProfileLoading());
    final result = await _profileRepository
        .updateUser({'donate_anonymously': anonymousOption});
    emit(result.fold(
        (l) => UpdateProfileFailed(
            appErrorType: l.appErrorType,
            errorMessage: getErrorMessage(l.appErrorType)),
        (r) => const UpdateProfileSuccessfull(' updated successfully.')));
  }
}
