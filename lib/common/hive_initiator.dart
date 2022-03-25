import 'package:hive_flutter/hive_flutter.dart';

import '../data/models/user_models/donor_model.dart';
import '../data/models/user_models/user_data_model.dart';
import '../data/models/user_models/user_model.dart';

class HiveInitiator {
  HiveInitiator._();
  static Future initialize() async {
    await Hive.initFlutter();
    Hive.registerAdapter(DonorModelAdapter());
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(UserDataAdapter());
  }
}
