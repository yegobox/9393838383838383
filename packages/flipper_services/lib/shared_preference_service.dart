library flipper_services;

import 'package:get_storage/get_storage.dart';

class SharedPreferenceService {
  final box = GetStorage();
  Future<void> setUserLoggedIn({String userId}) async {
    await box.write('userId', userId);
  }

  Future<void> setToken({String token}) async {
    await box.write('token', token);
  }

  String getUserId() {
    return box.read('userId');
  }

  bool logout() {
    box.remove('userId');
    return true;
  }

  Future<void> setIsAppConstantsInitialized({String userId}) async {
    await box.write('isAppConstantsInitialized', true);
  }


  Future<bool> isAppConstantsInitialized() async {
    return box.read('isAppConstantsInitialized') ?? false;
  }
}
