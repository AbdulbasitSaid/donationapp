import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/data/core/session_ticker.dart';

part 'app_session_manager_event.dart';
part 'app_session_manager_state.dart';

class AppSessionManagerBloc
    extends Bloc<AppSessionManagerEvent, AppSessionManagerState> {
  final SessionTicker _sessionTicker;
  StreamSubscription<int>? _streamSubscription;
  // static const int _duration = 30;d
  static const int _duration = 300;
  AppSessionManagerBloc(this._sessionTicker)
      : super(const AppSessionManagerInitial(_duration)) {
    on<AppSessionManagerEvent>((event, emit) {});
    on<AppSessionStarted>(_onStarted);
    on<AppSessionTicked>(_onTicked);
    on<AppSessionInitialized>(_onInitialzed);
    on<AppSessionReset>(_onReseted);
    on<AppSessionStoped>(_onStop);
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }

  void _onStarted(
      AppSessionStarted event, Emitter<AppSessionManagerState> emit) {
    emit(const AppSessionManagerInProgress(_duration));
    _streamSubscription?.cancel();
    _streamSubscription =
        _sessionTicker.tick(ticks: _duration).listen((duration) {
      add(AppSessionTicked(duration: duration));
    });
  }

  void _onReseted(AppSessionReset event, Emitter<AppSessionManagerState> emit) {
    emit(AppSessionManagerInProgress(event.duration));
    _streamSubscription?.cancel();
    _streamSubscription =
        _sessionTicker.tick(ticks: event.duration).listen((duration) {
      add(AppSessionTicked(duration: duration));
    });
  }

  void _onTicked(AppSessionTicked event, Emitter<AppSessionManagerState> emit) {
    emit(event.duration > 0
        ? AppSessionManagerInProgress(event.duration)
        : const AppSessionManagerCompleted());
  }

  void _onStop(AppSessionStoped event, Emitter<AppSessionManagerState> emit) {
    _streamSubscription?.cancel();
    emit(const AppSessionManagerCompleted());
  }

  FutureOr<void> _onInitialzed(
      AppSessionInitialized event, Emitter<AppSessionManagerState> emit) {
    _streamSubscription?.cancel();

    emit(const AppSessionManagerInitial(_duration));
  }
}
