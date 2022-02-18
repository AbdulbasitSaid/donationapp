import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:idonatio/data/core/api_client.dart';
import 'package:idonatio/data/data_sources/authentication_local_datasource.dart';
import 'package:idonatio/data/data_sources/authentication_remote_datasource.dart';
import 'package:idonatio/data/repository/authentication_repository.dart';
import 'package:idonatio/domain/usecases/login_user.dart';
import 'package:idonatio/domain/usecases/register_user.dart';
import 'package:idonatio/presentation/bloc/auth/auth_bloc.dart';
import 'package:idonatio/presentation/bloc/loader_cubit/loading_cubit.dart';
import 'package:idonatio/presentation/bloc/login/login_cubit.dart';

final GetIt getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSource());
  getItInstance.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSource(getItInstance()));
  getItInstance.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepository(getItInstance(), getItInstance()));
  getItInstance.registerLazySingleton<LoadingCubit>(() => LoadingCubit());
  getItInstance
      .registerLazySingleton<LoginUser>(() => LoginUser(getItInstance()));
  getItInstance
      .registerLazySingleton<LoginCubit>(() => LoginCubit(getItInstance()));
  getItInstance.registerLazySingleton<AuthBloc>(
      () => AuthBloc(authenticationLocalDataSource: getItInstance()));
}
