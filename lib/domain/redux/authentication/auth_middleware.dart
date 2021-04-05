import 'package:couchbase_lite_dart/couchbase_lite_dart.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flipper/domain/redux/user/user_actions.dart';
import 'package:flipper/routes/router.gr.dart';
import 'package:flipper/utils/constant.dart';
import 'package:flipper/utils/data_manager.dart';
import 'package:flipper/utils/logger.dart';
import 'package:flipper_models/branch.dart';
import 'package:flipper_models/business.dart';
import 'package:flipper_models/fuser.dart';
import 'package:flipper_models/pcolor.dart';
import 'package:flipper_services/database_service.dart';
import 'package:flipper_services/flipperNavigation_service.dart';
import 'package:flipper_services/locator.dart';
import 'package:flipper_services/proxy.dart';
import 'package:flipper_services/shared_state_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:logger/logger.dart';
import 'package:redux/redux.dart';

import '../app_state.dart';
import 'auth_actions.dart';

List<Middleware<AppState>> createAuthenticationMiddleware(
  GlobalKey<NavigatorState> navigatorKey,
) {
  return [
    TypedMiddleware<AppState, VerifyAuthenticationState>(
        _verifyAuthState(navigatorKey)),
    TypedMiddleware<AppState, LogOutAction>(_authLogout(navigatorKey)),
    TypedMiddleware<AppState, AfterLoginAction>(_verifyAuthState(navigatorKey)),
  ];
}

void Function(Store<AppState> store, dynamic action, NextDispatcher next)
    _verifyAuthState(
  GlobalKey<NavigatorState> navigatorKey,
) {
  // ignore: always_specify_types
  return (Store<AppState> store, action, next) async {
    next(action);
    //start by opening DB if not open
    // ProxyService.database.openDB();
    final FlipperNavigationService _navigationService = ProxyService.nav;

    final String loggedInUserId = await isUserCurrentlyLoggedIn(store);
    if (loggedInUserId == null) {
      _navigationService.navigateTo(Routing.afterSplash);
      return;
    } else {
      //TODO: rename signup as startupView
      getBusiness(userId: loggedInUserId);
      getBranches(userId: loggedInUserId);
      final FlipperNavigationService _navigationService = ProxyService.nav;
      _navigationService.navigateTo(Routing.signUpView,
          arguments:
              SignUpViewArguments(userId: loggedInUserId, avatar: 'avatar'));
    }
    await getAppColors();
  };
}

//TODO: fix dups from drawer_viewmodel and have one method
Future getBranches({String userId}) async {
  final q = Query(ProxyService.database.db,
      'SELECT id,businessId,createdAt,name,mapLatitude,mapLongitude,updatedAt,description,active,channels,location WHERE table=\$VALUE');

  q.parameters = {'VALUE': AppTables.branch};

  final results = q.execute();
  final state = locator<SharedStateService>();
  for (Map map in results.allResults) {
    state.setBranch(branch: Branch.fromMap(map));
  }
}

Future getBusiness({String userId}) async {
  //final Logger log = Logging.getLogger('get business:');

  final q = Query(ProxyService.database.db,
      'SELECT id,name,active,currency,categoryId,latitude,longitude,userId,typeId,timeZone,createdAt,updatedAt,channels,country,businessUrl,hexColor,image,type,table WHERE table=\$VALUE AND userId=\$USERID');

  q.parameters = {'VALUE': AppTables.business, 'USERID': userId};

  final business = q.execute();
  final state = locator<SharedStateService>();

  for (Map map in business.allResults) {
    state.setBusiness(business: Business.fromMap(map));
  }
}
//TODO: end of dups

Future getAppColors() async {
  final Logger log = Logging.getLogger('Get business: ');
  final DatabaseService _databaseService = ProxyService.database;

  final List<PColor> colors = [];

  final q = Query(_databaseService.db, 'SELECT * WHERE table=\$VALUE');

  q.parameters = {'VALUE': AppTables.color};

  q.addChangeListener((results) {
    for (Map map in results.allResults) {
      map.forEach((key, value) {
        colors.add(PColor.fromMap(value));
      });
    }
  });
}

/// the mthod login and connect to a database`
/// it also clear any pedning order too if any
Future<String> isUserCurrentlyLoggedIn(Store<AppState> store) async {
  final DatabaseService _databaseService = ProxyService.database;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final String loggedInuserId = ProxyService.sharedPref.getUserId();

  if (loggedInuserId == null) {
    await _databaseService.login();
    return null;
  } else {
    final List<String> channels = [];
    //save user in firebase contacts if he does not exist
    _firebaseMessaging.subscribeToTopic(
        loggedInuserId); //register this specific user to notification custom to him.
    channels.add(loggedInuserId);
    ProxyService.keypad.cleanKeypad();
    await _databaseService.login(channels: channels);

    //save a device token

    final q = Query(_databaseService.db, 'SELECT * WHERE table=\$VALUE');

    q.parameters = {
      'VALUE': AppTables.user,
    };

    q.addChangeListener((results) {
      for (Map map in results.allResults) {
        map.forEach((key, value) async {
          if (value.containsKey('userId') &&
              loggedInuserId == FUser.fromMap(value).userId) {
            ProxyService.sharedState.setUser(user: FUser.fromMap(value));

            store.dispatch(WithUser(user: FUser.fromMap(value)));
            try {
              saveDeviceToken(value);
              // ignore: empty_catches
            } catch (e) {}
          }
        });
      }
      // results.dispose();
    });
    return loggedInuserId;
  }
}

Future saveDeviceToken(value) async {
  // final String token = await ProxyService.sharedPref.getToken();
  // await http.post('https://flipper.yegobox.com/save-token', body: {
  //   'phone': FUser.fromMap(value).name, // a name is a phone number in flipper!
  //   'token': token
  // }, headers: {
  //   'Content-Type': 'application/x-www-form-urlencoded',
  //   'Accept': 'application/json'
  // });
}

Future<bool> isCategory({String branchId}) async {
  final DatabaseService _databaseService = ProxyService.database;

  final q = Query(_databaseService.db, 'SELECT * WHERE table=\$VALUE');

  q.parameters = {
    'VALUE': AppTables.category,
  };

  return q.execute().allResults.isNotEmpty;
}

Future<void> createSystemStockReasons(Store<AppState> store) async {
  // FIXME:
  // final List<ReasonTableData> reasons =
  //     await store.state.database.reasonDao.getReasons();
  // if (reasons.isEmpty) {
  //   await store.state.database.reasonDao.insert(
  //       //ignore:missing_required_param
  //       ReasonTableData(name: 'Stock Received', action: 'Received'));
  //   await store.state.database.reasonDao
  //       //ignore:missing_required_param
  //       .insert(ReasonTableData(name: 'Lost', action: 'Lost'));
  //   await store.state.database.reasonDao
  //       //ignore:missing_required_param
  //       .insert(ReasonTableData(name: 'Thief', action: 'Thief'));
  //   await store.state.database.reasonDao
  //       //ignore:missing_required_param
  //       .insert(ReasonTableData(name: 'Damaged', action: 'Damaged'));
  //   await store.state.database.reasonDao.insert(
  //       //ignore:missing_required_param
  //       ReasonTableData(name: 'Inventory Re-counted', action: 'Re-counted'));
  //   await store.state.database.reasonDao.insert(
  //       //ignore:missing_required_param
  //       ReasonTableData(name: 'Restocked Return', action: 'Restocked Return'));
  //   await store.state.database.reasonDao
  //       //ignore:missing_required_param
  //       .insert(ReasonTableData(name: 'Sold', action: 'Sold'));
  //   await store.state.database.reasonDao.insert(
  //       //ignore:missing_required_param
  //       ReasonTableData(name: 'Transferred', action: 'Transferred'));

  //   await store.state.database.reasonDao
  //       //ignore:missing_required_param
  //       .insert(ReasonTableData(name: 'Canceled', action: 'Canceled'));
  // }
}

Future<void> createTemporalOrder(Store<AppState> store) async {
  if (store.state.branch == null) {
    return;
  }
  if (store.state.user.id == null) {
    return;
  }
  DataManager.createTemporalOrder(store);
}

void Function(
  Store<AppState> store,
  dynamic action,
  NextDispatcher next,
) _authLogout(
  GlobalKey<NavigatorState> navigatorKey,
) {
  // ignore: always_specify_types
  return (store, action, next) async {
    next(action);
    try {
      // await userRepository.logOut(store);
      store.dispatch(OnLogoutSuccess());
    } catch (e) {
      // Logger.w('Failed logout', e: e);
      // store.dispatch(OnLogoutFail(e));
    }
  };
}
