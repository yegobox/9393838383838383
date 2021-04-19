import 'package:flipper_services/abstractions/platform.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:universal_platform/universal_platform.dart';
import 'abstractions/api.dart';
import 'abstractions/location.dart';
import 'abstractions/storage.dart';
import 'locator.dart';

final isWindows = UniversalPlatform.isWindows;

final Api _apiService = locator<Api>();
final NavigationService _nav = locator<NavigationService>();
final LoginStandard _auth = locator<LoginStandard>();
final FlipperLocation _location = locator<FlipperLocation>();
// final DB<Business> _db = locator<DB<Business>>();
final LocalStorage _box = locator<LocalStorage>();

abstract class ProxyService {
  static Api get api => _apiService;
  static NavigationService get nav => _nav;
  static FlipperLocation get location => _location;
  static LocalStorage get box => _box;
  static LoginStandard get auth => _auth;
}
