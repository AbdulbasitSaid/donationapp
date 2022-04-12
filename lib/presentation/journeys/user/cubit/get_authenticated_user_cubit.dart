import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/models/user_models/get_authenticated_user_model.dart';
import 'package:idonatio/data/repository/user_repository.dart';

part 'get_authenticated_user_state.dart';

class GetAuthenticatedUserCubit extends Cubit<GetAuthenticatedUserState> {
  final UserRepository userRepository;
  GetAuthenticatedUserCubit(this.userRepository)
      : super(GetAuthenticatedUserInitial());

  void getAuthenticatedUser() async {
    emit(GetAuthenticatedUserLoading());
    final result = await userRepository.getAuthenticatedUser();
    emit(result.fold((l) => GetAuthenticatedUserFailed(), (r) {
      log('get authenticated user $r');
      return GetAuthenticatedUserSuccess(r);
    }));
  }
}
