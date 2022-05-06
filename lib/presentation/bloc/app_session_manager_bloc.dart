import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/core/session_ticker.dart';

part 'app_session_manager_event.dart';
part 'app_session_manager_state.dart';

class AppSessionManagerBloc
    extends Bloc<AppSessionManagerEvent, AppSessionManagerState> {
  final SessionTicker _sessionTicker;
  StreamSubscription<int>? _streamSubscription;
  static const int _duration = 60;
  AppSessionManagerBloc(this._sessionTicker)
      : super(const AppSessionManagerInitial(_duration)) {
    on<AppSessionManagerEvent>((event, emit) {});
    on<AppSessionStarted>(_onStarted);
    on<AppSessionTicked>(_onTicked);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  void _onStarted(
      AppSessionStarted event, Emitter<AppSessionManagerState> emit) {
    emit(AppSessionManagerInProgress(event.duration));
    _streamSubscription?.cancel();
    _streamSubscription =
        _sessionTicker.tick(ticks: event.duration).listen((duration) {
      add(AppSessionTicked(duration: duration));
    });
  }

  void _onTicked(AppSessionTicked event, Emitter<AppSessionManagerState> emit) {
    log(event.toString());
    emit(event.duration > 0
        ? AppSessionManagerInProgress(event.duration)
        : const AppSessionManagerCompleted());
  }
}
