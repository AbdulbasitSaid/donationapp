part of 'getdoneebycode_cubit.dart';

abstract class GetdoneebycodeState extends Equatable {
  const GetdoneebycodeState();

  @override
  List<Object> get props => [];
}

class GetdoneebycodeInitial extends GetdoneebycodeState {}

class GetdoneebycodeLoading extends GetdoneebycodeState {}

class GetdoneebycodeSuccess extends GetdoneebycodeState {
  final DoneeResponseData doneeResponseData;

  const GetdoneebycodeSuccess(this.doneeResponseData);
}

class GetdoneebycodeFailed extends GetdoneebycodeState {
  final String errorTitle, errorMessage;
  final AppErrorType appErrorType;
  const GetdoneebycodeFailed(
      {required this.errorTitle,
      required this.errorMessage,
      required this.appErrorType});
}
