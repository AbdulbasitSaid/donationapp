import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/repository/authentication_repository.dart';
import 'package:idonatio/domain/entities/app_error.dart';
import 'package:idonatio/presentation/bloc/loader_cubit/loading_cubit.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(
    this.loadingCubit,
    this._registerUserRepositoryImpl,
  ) : super(RegisterInitial());
  final LoadingCubit loadingCubit;
  final AuthenticationRepository _registerUserRepositoryImpl;

  void initiateRegistration(Map<String, dynamic> params) async {
    final Either<AppError, dynamic> eitherResponse =
        await _registerUserRepositoryImpl.registerUser(params);
        
    emit(
      eitherResponse.fold((l) {
        var message = getErrorMessage(l.appErrorType);
        return RegisterFailed(message);
      }, (r) => RegisterSuccess()),
    );
  }

  String getErrorMessage(AppErrorType appErrorType) {
    switch (appErrorType) {
      case AppErrorType.network:
        return 'No network';
      case AppErrorType.api:
      case AppErrorType.database:
        return 'Opps something went wrong';
      default:
        return 'Email is already taken';
    }
  }
}
