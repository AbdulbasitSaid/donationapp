part of 'app_session_manager_bloc.dart';

abstract class AppSessionManagerEvent extends Equatable {
  const AppSessionManagerEvent();

  @override
  List<Object> get props => [];
}

class AppSessionStarted extends AppSessionManagerEvent {
  final int duration;

  const AppSessionStarted({required this.duration});
}

class AppSessionReset extends AppSessionManagerEvent {
  const AppSessionReset();
}

class AppSessionTicked extends AppSessionManagerEvent {
  final int duration;

  const AppSessionTicked({required this.duration});
  @override
  List<Object> get props => [duration];
}
