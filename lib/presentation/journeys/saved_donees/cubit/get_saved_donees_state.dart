part of 'get_saved_donees_cubit.dart';

abstract class GetSavedDoneesState extends Equatable {
  const GetSavedDoneesState();

  @override
  List<Object> get props => [];
}

class GetSavedDoneesInitial extends GetSavedDoneesState {}

class GetSavedDoneesLoading extends GetSavedDoneesState {}

class GetSavedDoneesSuccess extends GetSavedDoneesState {
  final SavedDoneesResponseModel savedDoneesResponseModel;

  const GetSavedDoneesSuccess(this.savedDoneesResponseModel);
}

class GetSavedDoneesFailed extends GetSavedDoneesState {
  final String errorMessage;

  const GetSavedDoneesFailed(this.errorMessage);
}
