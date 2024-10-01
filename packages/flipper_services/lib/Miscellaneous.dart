import 'dart:developer';
import 'dart:io';

import 'package:flipper_models/helperModels/random.dart';
import 'package:flipper_models/realm/schemas.dart';
import 'package:flipper_services/proxy.dart';
import 'package:firebase_auth/firebase_auth.dart';

mixin CoreMiscellaneous {
  Future<bool> logOut() async {
    try {
      ProxyService.box.remove(key: 'authComplete');
      if (ProxyService.box.getUserId() != null &&
          ProxyService.box.getBusinessId() != null) {
        ProxyService.event.publish(loginDetails: {
          'channel': "${ProxyService.box.getUserId()!}-logout",
          'userId': ProxyService.box.getUserId(),
          'businessId': ProxyService.box.getBusinessId(),
          'branchId': ProxyService.box.getBranchId(),
          'phone': ProxyService.box.getUserPhone(),
          'defaultApp': ProxyService.box.getDefaultApp(),
          'deviceName': Platform.operatingSystem,
          'uid': (await FirebaseAuth.instance.currentUser?.getIdToken()) ?? "",
          'deviceVersion': Platform.operatingSystemVersion,
          'linkingCode': randomNumber().toString()
        });
      }
      ProxyService.box.remove(key: 'userId');
      ProxyService.box.remove(key: 'getIsTokenRegistered');
      ProxyService.box.remove(key: 'defaultApp');

      // but for shared preference we can just clear them all
      /// We do not clear all variable, this is because even on logout
      /// a user log in back and there is values such as tinNumber,bhfId,URI that we will still need to re-use
      /// therefore why the bellow line is commented out.

      await FirebaseAuth.instance.signOut();

      /// refreshing the user token will invalidate any session
      await FirebaseAuth.instance.currentUser?.getIdToken(true);

      await ProxyService.local.amplifyLogout();

      /// calling close on logout inroduced error where another attempt to login will fail since
      /// the instance of realm is instantiated at app start level.
      // resetDependencies(dispose: true);
      /// wait to sync data for this eod
      // await ProxyService.local.realm!.syncSession.waitForUpload();

      /// get all business and unset default
      if (ProxyService.local.realm != null &&
          ProxyService.box.getBranchId() != null) {
        List<Business> businesses = ProxyService.local.businesses();
        for (Business business in businesses) {
          ProxyService.local.realm!.write(() {
            business.isDefault = false;
            business.active = false;
          });
        }
      }
      ProxyService.local.close();
      ProxyService.local.realm = null;
      ProxyService.local.realm = null;
      return Future.value(true);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      rethrow;
    }
  }

  /// Ensures that the Realm database is initialized and ready to use.
  Future<void> ensureRealmInitialized() async {
    if (ProxyService.box.encryptionKey().isNotEmpty) {
      await ProxyService.local.configureLocal(useInMemory: false);
    }
  }
}
