import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(HideloadingState());

  void show() => emit(ShowloadingState());

  void hide() => emit(HideloadingState());
}

abstract class LoadingState extends Equatable {}

class ShowloadingState extends LoadingState {
  @override
  List<Object?> get props => [];
}

class HideloadingState extends LoadingState {
  @override
  List<Object?> get props => [];
}
