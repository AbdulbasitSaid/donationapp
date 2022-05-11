import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/common/server_ticker.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';
import 'package:idonatio/data/data_sources/user_remote_datasource.dart';

part 'server_timer_event.dart';
part 'server_timer_state.dart';

class ServerTimerBloc extends Bloc<ServerTimerEvent, ServerTimerState> {
  // static const int _duration = 30;
  static const int _duration = 1500;
  final ServerTicker _ticker;
  StreamSubscription<int>? _tickerSubscription;
  final UserLocalDataSource localDataSource;
  final UserRemoteDataSource userRemoteDataSource;
  ServerTimerBloc(
      {required ServerTicker refereshTicker,
      required this.userRemoteDataSource,
      required this.localDataSource})
      : _ticker = refereshTicker,
        super(const ServerTimerInitial(_duration)) {
    on<ServerTimerStarted>(_onStarted);
    on<ServerTimerTicked>(_onTicked);
    on<ServerTimerStop>(_onStoped);
  }
  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(ServerTimerStarted event, Emitter<ServerTimerState> emit) {
    emit(const ServerTimerRunInProgress(_duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: _duration)
        .listen((duration) => add(ServerTimerTicked(duration: duration)));
  }

  void _onTicked(ServerTimerTicked event, Emitter<ServerTimerState> emit) {
    emit(
      event.duration > 0
          ? ServerTimerRunInProgress(event.duration)
          : const ServerTimerRunComplete(),
    );
  }

  void _onStoped(ServerTimerStop event, Emitter<ServerTimerState> emit) {
    _tickerSubscription?.cancel();

    emit(const ServerTimerRunComplete());
  }
}
