import 'package:equatable/equatable.dart';

class LocalUserObject extends Equatable {
  final String? token;
  final bool? isBoarded, isEmailVerified;

  LocalUserObject(
      {required this.token,
      required this.isBoarded,
      required this.isEmailVerified});

  @override
  // TODO: implement props
  List<Object?> get props => [token, isBoarded, isEmailVerified];
}
