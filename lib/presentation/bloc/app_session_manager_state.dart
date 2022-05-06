part of 'app_session_manager_bloc.dart';

abstract class AppSessionManagerState extends Equatable {
  const AppSessionManagerState(this.duration);
  final int duration;
  @override
  List<Object> get props => [duration];
}

class AppSessionManagerInitial extends AppSessionManagerState {
  const AppSessionManagerInitial(int duration) : super(duration);
  @override
  String toString() {
    return 'SessionTimerInitial { duration: $duration }';
  }
}

class AppSessionManagerInProgress extends AppSessionManagerState {
  const AppSessionManagerInProgress(int duration) : super(duration);
  @override
  String toString() {
    return 'SessionManagerInProgress { duration: $duration }';
  }
}

class AppSessionManagerCompleted extends AppSessionManagerState {
  const AppSessionManagerCompleted() : super(0);
  @override
  String toString() {
    return 'SessionManagerCompleted { duration: $duration }';
  }
}
