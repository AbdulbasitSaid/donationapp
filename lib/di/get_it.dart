import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:idonatio/data/core/api_client.dart';
import 'package:idonatio/data/data_sources/change_password_datasource.dart';
import 'package:idonatio/data/data_sources/donee_remote_datasource.dart';
import 'package:idonatio/data/data_sources/profile_remote_datasource.dart';
import 'package:idonatio/data/data_sources/recent_donee_datasource.dart';
import 'package:idonatio/data/data_sources/saved_donees_datasource.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';
import 'package:idonatio/data/data_sources/user_remote_datasource.dart';
import 'package:idonatio/data/data_sources/country_remote_datasource.dart';
import 'package:idonatio/data/repository/change_password_repository.dart';
import 'package:idonatio/data/repository/donee_repository.dart';
import 'package:idonatio/data/repository/profile_repository.dart';
import 'package:idonatio/data/repository/recent_doness_repository.dart';
import 'package:idonatio/data/repository/saved_donees_repository.dart';
import 'package:idonatio/data/repository/user_repository.dart';
import 'package:idonatio/data/repository/countries_repository.dart';
import 'package:idonatio/data/repository/payment_repository.dart';

import 'package:idonatio/presentation/bloc/loader_cubit/loading_cubit.dart';
import 'package:idonatio/presentation/bloc/login/login_cubit.dart';

final GetIt getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());

  getItInstance.registerLazySingleton<ApiClient>(() => ApiClient());

  getItInstance
      .registerLazySingleton<UserLocalDataSource>(() => UserLocalDataSource());
  getItInstance.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSource(getItInstance()));
  getItInstance.registerLazySingleton<UserRepository>(
      () => UserRepository(getItInstance(), getItInstance()));
  getItInstance.registerLazySingleton<LoadingCubit>(() => LoadingCubit());

  getItInstance
      .registerLazySingleton<LoginCubit>(() => LoginCubit(getItInstance()));

  getItInstance.registerLazySingleton<CountryRemoteDataSource>(
      () => CountryRemoteDataSource(getItInstance()));
  getItInstance.registerLazySingleton<CountriesRepository>(
      () => CountriesRepository(getItInstance()));
  getItInstance.registerLazySingleton<PaymentRepository>(
      () => PaymentRepository(getItInstance()));
  getItInstance.registerLazySingleton<DoneeRemoteDataSource>(
      () => DoneeRemoteDataSource(getItInstance()));
  getItInstance.registerLazySingleton<DoneeRepository>(
      () => DoneeRepository(getItInstance(), getItInstance()));
  getItInstance.registerLazySingleton<RecentDoneesDataSource>(
      () => RecentDoneesDataSource(getItInstance()));
  getItInstance.registerLazySingleton<RecentDoneesRepository>(
      () => RecentDoneesRepository(getItInstance(), getItInstance()));
  getItInstance.registerLazySingleton<SavedDoneeDataSource>(
      () => SavedDoneeDataSource(getItInstance()));
  getItInstance.registerLazySingleton<ProfileRemoteDataSource>(
      () => ProfileRemoteDataSource(getItInstance()));
  getItInstance.registerLazySingleton<ProfileRepository>(
      () => ProfileRepository(getItInstance(), getItInstance()));

  getItInstance.registerLazySingleton<SavedDoneesRepository>(
      () => SavedDoneesRepository(getItInstance(), getItInstance()));
  getItInstance.registerLazySingleton<ChangePasswordDataSource>(
      () => ChangePasswordDataSource(getItInstance()));
  getItInstance.registerLazySingleton<ChangePasswordRepository>(
      () => ChangePasswordRepository(getItInstance(), getItInstance()));
}
