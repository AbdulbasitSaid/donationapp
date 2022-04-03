import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:idonatio/data/models/user_models/donor_model.dart';
import 'package:idonatio/data/models/user_models/user_data_model.dart';
import 'package:idonatio/data/models/user_models/user_model.dart';

class UserLocalDataSource {
  Future<void> saveUserData(
    UserData userData,
  ) async {
    final userBox = await Hive.openBox<UserData>('user_box');
    userBox.put('user_data', userData);
    log(userBox.get('user_data').toString());
  }

  Future<void> updateUserData(UserData userData) async {
    Hive.box<UserData>('user_box').put('user_data', userData);
  }

  Future<void> saveResetPasswordEmail(String email) async {
    final userResetPasswordEmail =
        await Hive.openBox('reset_password_email_store');
    userResetPasswordEmail.put('reset_password_email', email);
    log(userResetPasswordEmail.get('reset_password_email'));
  }

  Future<String> getPasswordResetEmail() async {
    final emailBox = await Hive.openBox('reset_password_email_store');
    final String email = emailBox.get('reset_password_email');
    return email;
  }

  Future<String?> getRememberMeEmail() async {
    final emailBox = await Hive.openBox('remember_me_box');

    return emailBox.get('remember_me_email');
  }

  Future<void> deleteResetPasswordEmail() async {
    Hive.box<UserData>('reset_password_email_store')
        .delete('reset_password_email');
  }

  Future<void> rememberMeEmail(String email) async {
    final userResetPasswordEmail = await Hive.openBox('remember_me_box');
    userResetPasswordEmail.put('remember_me_email', email);
    log(userResetPasswordEmail.get('remember_me_email'));
  }

  Future<void> deleteResetRememberMeEmail() async {
    await Hive.box('remember_me_box').delete('remember_me_email');
  }

  //
  Future<UserData> getUser() async {
    final userBox = await Hive.openBox<UserData>('user_box');
    final user = userBox.get('user_data') ??
        UserData(
            token: '',
            tokenType: '',
            expiresIn: 0,
            isDeviceSaved: false,
            user: UserModel(
                donor: DonorModel(
                  address: null,
                  city: null,
                  countryId: null,
                  firstName: '',
                  giftAidEnabled: false,
                  id: '',
                  isOnboarded: false,
                  lastName: '',
                  paymentMethod: null,
                  phoneNumber: '',
                  phoneReceiveSecurityAlert: false,
                  phoneVerifiedAt: null,
                  postalCode: null,
                  sendMarketingMail: false,
                  stripeCustomerId: '',
                  title: '',
                  donateAnonymously: false,
                ),
                email: '',
                emailVerifiedAt: null,
                id: '',
                isActive: false),
            stripeCustomerId: '');
    return user;
  }

  Future<void> deleteUserData() async {
    Hive.box<UserData>('user_box').delete('user_data');
  }
}
