part of 'app_session_manager_bloc.dart';

abstract class AppSessionManagerEvent extends Equatable {
  const AppSessionManagerEvent();

  @override
  List<Object> get props => [];
}

class AppSessionInitialized extends AppSessionManagerEvent {
  final int duration;

  const AppSessionInitialized({this.duration = 0});
}

class AppSessionStarted extends AppSessionManagerEvent {
  const AppSessionStarted();
}

class AppSessionReset extends AppSessionManagerEvent {
  final int duration;
  const AppSessionReset({this.duration = 300});
}

class AppSessionTicked extends AppSessionManagerEvent {
  final int duration;

  const AppSessionTicked({required this.duration});
  @override
  List<Object> get props => [duration];
}
