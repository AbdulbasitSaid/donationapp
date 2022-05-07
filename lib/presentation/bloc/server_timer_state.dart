part of 'server_timer_bloc.dart';

abstract class ServerTimerState extends Equatable {
  const ServerTimerState(this.duration);
  final int duration;
  @override
  List<Object> get props => [duration];
}

class ServerTimerInitial extends ServerTimerState {
  const ServerTimerInitial(int duration) : super(duration);
  @override
  String toString() {
    return 'SeverTimerInitial {duration: $duration }';
  }
}

class ServerTimerRunInProgress extends ServerTimerState {
  const ServerTimerRunInProgress(int duration) : super(duration);

  @override
  String toString() => 'TimerRunInProgress { duration: $duration }';
}

class ServerTimerRunComplete extends ServerTimerState {
  const ServerTimerRunComplete() : super(0);
}
