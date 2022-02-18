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
                    userId: ''),
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
