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
          print(user.toString());
          return emit(
              user.token != null ? UnAuthenticated() : UnSignedAuthenticated());
        case AuthStatus.authenticated:
          LocalUserObject user = await authenticationLocalDataSource.getUser();
          return emit(user.isEmailVerified != null
              ? Authenticated()
              : EmailNotVerified());

        case AuthStatus.verifiedEmail:
          LocalUserObject user = await authenticationLocalDataSource.getUser();

          return emit(user.isBoarded != null && user.isBoarded == true
              ? Authenticated()
              : NotBoarded());
        default:
          break;
      }
    });
  }
}
