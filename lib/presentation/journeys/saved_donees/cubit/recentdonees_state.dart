part of 'recentdonees_cubit.dart';

abstract class RecentdoneesState extends Equatable {
  const RecentdoneesState();

  @override
  List<Object> get props => [];
}

class RecentdoneesInitial extends RecentdoneesState {}

class RecentdoneesLoading extends RecentdoneesState {}

class RecentdoneesSuccessful extends RecentdoneesState {
  final RecentDoneesResponseModel recentDoneesResponseModel;

  const RecentdoneesSuccessful(this.recentDoneesResponseModel);
}

class RecentdoneesFailed extends RecentdoneesState {
  final String errorMessage;

  const RecentdoneesFailed(this.errorMessage);
}
