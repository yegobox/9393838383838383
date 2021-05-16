import 'package:flipper_services/keypad_service.dart';
import 'package:test/test.dart';
import '../helpers/test_helpers.dart';
import 'package:flipper_models/view_models/business_home_viewmodel.dart';
import 'package:flipper_models/models/order_mock.dart';

BusinessHomeViewModel _getModel() => BusinessHomeViewModel();

void main() {
  group('Test When sellign a product', () {
    late KeyPadService keypadService;
    late BusinessHomeViewModel model;
    setUp(() {
      registerServices();
      keypadService = getAndRegisterKeyPadServiceUnmocked();
      model = _getModel();
    });
    tearDown(() => unregisterServices());
    // test('can set amount', () async {
    //   model.setAmount(amount: 300.0);
    //   expect(keypadService.amountTotal, 300.0);
    // });
    test('should increase quantity', () async {
      model.increaseQty();
      expect(keypadService.quantity, 1);
    });
    test('should decrease quantity', () async {
      model.decreaseQty();
      expect(keypadService.quantity, 0);
    });
  });
}
