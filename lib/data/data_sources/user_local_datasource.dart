import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:idonatio/data/models/user_models/user_data_model.dart';

class UserLocalDataSource {
  Future<void> saveUserData(
    UserData userData,
  ) async {
    final userBox = await Hive.openBox<UserData>('user_box');
    userBox.put('user_data', userData);
    log(userBox.get('user_data').toString());
  }

  Future<void> updateUserData(UserData userData) async {
    Hive.box('user_data').put('user_data', userData);
  }

  Future<UserData?> getUser() async {
    final userBox = await Hive.openBox<UserData>('user_box');
    final user = userBox.get('user_data');
    return user;
  }

  Future<void> deleteUserData() async {
    Hive.box('user_box').delete('user_data');
  }
}
