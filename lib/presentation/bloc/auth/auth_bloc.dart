import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/data_sources/authentication_local_datasource.dart';
import 'package:idonatio/data/models/local_user_object.dart';
import 'package:idonatio/enums.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthenticationLocalDataSource authenticationLocalDataSource;
  AuthBloc({required this.authenticationLocalDataSource})
      : super(const AuthInitial()) {
    on<ChangeAuth>((event, emit) async {
      switch (event.authStatus) {
        case AuthStatus.appStarted:
          LocalUserObject user = await authenticationLocalDataSource.getUser();
          return emit(
              user.token != null ? UnAuthenticated() : UnSignedAuthenticated());
        case AuthStatus.authenticated:
          LocalUserObject user = await authenticationLocalDataSource.getUser();
          if (user.isEmailVerified == null) {
            return emit(EmailNotVerified());
          } else if (user.isBoarded == null || user.isBoarded == false) {
            return emit(NotBoarded(userObject: user));
          } else {
            return emit(Authenticated());
          }

        case AuthStatus.verifiedEmail:
          LocalUserObject user = await authenticationLocalDataSource.getUser();
          if (user.isEmailVerified != null && user.isBoarded != false) {
            return emit(Authenticated());
          } else if (user.isBoarded == false) {
            return emit(NotBoarded(userObject: user));
          } else {
            return emit(UnAuthenticated());
          }
        case AuthStatus.notboarded:
          LocalUserObject user = await authenticationLocalDataSource.getUser();
          return emit(NotBoarded(userObject: user));
        default:
          break;
      }
    });
  }
}
