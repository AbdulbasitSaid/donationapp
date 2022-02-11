import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/repository/profile_repository.dart';
import 'package:idonatio/domain/entities/app_error.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  final ProfileRepository _profileRepository;

  UpdateProfileCubit(this._profileRepository) : super(UpdateProfileInitial());
  // void editName(String title, String firstName, String lastName) async {
  //   emit(UpdateProfileLoading());
  //   final result = await _profileRepository.updateUser({
  //     'title': title,
  //     'first_name': firstName,
  //     'last_name': lastName,
  //   });

  //   emit(result.fold(
  //       (l) => UpdateProfileFailed(
  //           appErrorType: l.appErrorType,
  //           errorMessage: getErrorMessage(l.appErrorType)),
  //       (r) => const UpdateProfileSuccessfull('Account name updated.')));
  // }
}
