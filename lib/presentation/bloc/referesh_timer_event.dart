part of 'referesh_timer_bloc.dart';

abstract class RefereshTimerEvent extends Equatable {
  const RefereshTimerEvent();

  @override
  List<Object> get props => [];
}

class RefereshTimerStarted extends RefereshTimerEvent {
  const RefereshTimerStarted({required this.duration});
  final int duration;
}

class RefereshTimerReset extends RefereshTimerEvent {
  const RefereshTimerReset();
}

class RefereshTimerTicked extends RefereshTimerEvent {
  const RefereshTimerTicked({required this.duration});
  final int duration;

  @override
  List<Object> get props => [duration];
}

