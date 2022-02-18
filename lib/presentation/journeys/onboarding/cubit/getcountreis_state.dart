part of 'getcountreis_cubit.dart';

abstract class GetcountreisState extends Equatable {
  const GetcountreisState();

  @override
  List<Object> get props => [];
}

class GetcountreisInitial extends GetcountreisState {}

class GetcountreisLoading extends GetcountreisState {}

class GetcountreisSuccessfull extends GetcountreisState {
  final CountriesModel countries;

  const GetcountreisSuccessfull({required this.countries});
}

class GetcountreisFailed extends GetcountreisState {
  final String errorMessage;

  const GetcountreisFailed({required this.errorMessage});
}
