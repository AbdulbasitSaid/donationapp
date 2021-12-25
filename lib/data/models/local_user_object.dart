import 'package:equatable/equatable.dart';

class LocalUserObject extends Equatable {
  final String? token;
  final bool? isBoarded;
  final String? isEmailVerified;
  final String? firstName;
  final String? lastName;

  const LocalUserObject(
      {required this.token,
      required this.isBoarded,
      required this.firstName,
      required this.lastName,
      required this.isEmailVerified});

  @override
  List<Object?> get props => [
        token,
        isBoarded,
        isEmailVerified,
        firstName,
        lastName,
      ];
}
