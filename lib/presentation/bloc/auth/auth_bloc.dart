import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/data_sources/authentication_local_datasource.dart';
import 'package:idonatio/data/models/local_user_object.dart';
import 'package:idonatio/enums.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationLocalDataSource authenticationLocalDataSource;
  AuthBloc({required this.authenticationLocalDataSource})
      : super(AuthInitial()) {
    on<ChangeAuth>((event, emit) async {
      switch (event.authStatus) {
        case AuthStatus.appStarted:
          LocalUserObject user = await authenticationLocalDataSource.getUser();
          return emit(
              user.token != null ? UnAuthenticated() : UnSignedAuthenticated());
        default:
          break;
      }
    });
  }
}
