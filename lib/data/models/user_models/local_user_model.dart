import 'package:equatable/equatable.dart';

class LocalUserObject extends Equatable {
  final String? token;
  final bool? isBoarded;
  final String? isEmailVerified;
  final String? firstName;
  final String? lastName;
  final String? stripeCustomerId;
  final String? userEmail;
  const LocalUserObject(
      {required this.token,
      required this.isBoarded,
      required this.firstName,
      required this.lastName,
      required this.isEmailVerified,
      required this.stripeCustomerId,
      required this.userEmail});

  @override
  List<Object?> get props => [
        token,
        {'user has boarded?': isBoarded},
        isEmailVerified,
        firstName,
        lastName,
        stripeCustomerId,
        userEmail,
      ];
}
