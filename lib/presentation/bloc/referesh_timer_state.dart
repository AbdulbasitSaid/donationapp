part of 'referesh_timer_bloc.dart';

abstract class RefereshTimerState extends Equatable {
  const RefereshTimerState(this.duration);
  final int duration;
  @override
  List<Object> get props => [duration];
}

class RefereshTimerInitial extends RefereshTimerState {
  const RefereshTimerInitial(int duration) : super(duration);
  @override
  String toString() {
    return 'RefereshTimerInitial {duration: $duration }';
  }
}

class RefereshTimerRunInProgress extends RefereshTimerState {
  const RefereshTimerRunInProgress(int duration) : super(duration);

  @override
  String toString() => 'TimerRunInProgress { duration: $duration }';
}

class RefereshTimerRunComplete extends RefereshTimerState {
  const RefereshTimerRunComplete() : super(0);
}
