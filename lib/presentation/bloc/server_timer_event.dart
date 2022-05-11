part of 'server_timer_bloc.dart';

abstract class ServerTimerEvent extends Equatable {
  const ServerTimerEvent();

  @override
  List<Object> get props => [];
}

class ServerTimerStarted extends ServerTimerEvent {}

class ServerTimerReset extends ServerTimerEvent {}

class ServerTimerStop extends ServerTimerEvent {}

class ServerTimerTicked extends ServerTimerEvent {
  const ServerTimerTicked({required this.duration});
  final int duration;

  @override
  List<Object> get props => [duration];
}
