import 'package:dartz/dartz.dart';
import 'package:idonatio/domain/entities/app_error.dart';
import 'package:idonatio/domain/entities/no_param.dart';
import 'package:idonatio/domain/repository/authentication_repository.dart';
import 'package:idonatio/domain/usecases/usecases.dart';

class LogoutUser extends UseCase<void, NoParams> {
  final AuthenticationRepository _authenticationRepository;

  LogoutUser(this._authenticationRepository);

  @override
  Future<Either<AppError, void>> call(NoParams noParams) async =>
      _authenticationRepository.logoutUser();
}
