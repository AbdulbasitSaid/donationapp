import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:idonatio/data/core/api_client.dart';
import 'package:idonatio/data/data_sources/repository/authentication_local_datasource.dart';
import 'package:idonatio/data/data_sources/repository/authentication_remote_datasource.dart';
import 'package:idonatio/data/data_sources/repository/authentication_repository_implementation.dart';
import 'package:idonatio/domain/repository/authentication_repository.dart';
import 'package:idonatio/domain/usecases/login_user.dart';
import 'package:idonatio/domain/usecases/logout_user.dart';
import 'package:idonatio/presentation/bloc/login/cubit/loading_cubit.dart';
import 'package:idonatio/presentation/bloc/login/login_cubit.dart';

final GetIt getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  getItInstance.registerLazySingleton<AuthenticationRemoteDataSourceImpl>(
      () => AuthenticationRemoteDataSourceImpl(getItInstance()));

  getItInstance.registerLazySingleton<AuthenticationLocalDataSourceImpl>(
      () => AuthenticationLocalDataSourceImpl());

  getItInstance.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(getItInstance(), getItInstance()));

  getItInstance
      .registerLazySingleton<LoginUser>(() => LoginUser(getItInstance()));
  getItInstance.registerLazySingleton<LoadingCubit>(() => LoadingCubit());
  getItInstance
      .registerLazySingleton<LogoutUser>(() => LogoutUser(getItInstance()));
  getItInstance.registerLazySingleton<LoginCubit>(() => LoginCubit(
      loginUser: getItInstance(),
      loadingCubit: getItInstance(),
      logoutUser: getItInstance()));
}
