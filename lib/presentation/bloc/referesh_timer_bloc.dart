import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:idonatio/common/referesh_ticker.dart';
import 'package:idonatio/data/data_sources/user_local_datasource.dart';
import 'package:idonatio/data/data_sources/user_remote_datasource.dart';

part 'referesh_timer_event.dart';
part 'referesh_timer_state.dart';

class RefereshTimerBloc extends Bloc<RefereshTimerEvent, RefereshTimerState> {
  static const int _duration = 60;
  final RefereshTicker _ticker;
  StreamSubscription<int>? _tickerSubscription;
  final UserLocalDataSource localDataSource;
  final UserRemoteDataSource userRemoteDataSource;
  RefereshTimerBloc(
      {required RefereshTicker refereshTicker,
      required this.userRemoteDataSource,
      required this.localDataSource})
      : _ticker = refereshTicker,
        super(const RefereshTimerInitial(_duration)) {
    on<RefereshTimerStarted>(_onStarted);
    on<RefereshTimerTicked>(_onTicked);
    on<RefereshTimerReset>(_onReset);
  }
  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(
      RefereshTimerStarted event, Emitter<RefereshTimerState> emit) {
    emit(RefereshTimerRunInProgress(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(RefereshTimerTicked(duration: duration)));
  }

  void _onTicked(RefereshTimerTicked event, Emitter<RefereshTimerState> emit) {
    emit(
      event.duration > 0
          ? RefereshTimerRunInProgress(event.duration)
          : const RefereshTimerRunComplete(),
    );
  }

  void _onReset(
      RefereshTimerReset event, Emitter<RefereshTimerState> emit) async {
    _tickerSubscription?.cancel();
    final user = await localDataSource.getUser();
    await userRemoteDataSource.getRefereshToken(token: user.token);
    emit(const RefereshTimerInitial(_duration));
  }
}
