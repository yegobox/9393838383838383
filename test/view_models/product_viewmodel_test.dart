// import 'package:flipper_routing/routes.router.dart';
import 'package:flipper_models/variant_sync.dart';
import 'package:flipper_models/view_models/product_viewmodel.dart';
import 'package:flipper_services/constants.dart';
import 'package:flipper_services/product_service.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

import '../helpers/test_helpers.dart';

ProductViewModel _getModel() => ProductViewModel();
void main() {
  group('Test Add product', () {
    late ProductService productService;
    late Map data;
    setUp(() {
      registerServices();
      productService = getAndRegisterProductService(
        currentUnit: 'kg',
        branchId: 11,
        userId: 'UID',
      );
      data = productService.product!.toJson();
      data['name'] = 'product name';
      getAndRegisterApi(data: data, uri: 'product');
    });
    tearDown(() => unregisterServices());
    test('test adding variant ...', () async {
      final model = _getModel();

      List<VariantSync> ls = [];
      VariantSync v = new VariantSync(
        name: 'name',
        sku: 'N/A',
        fproductId: 2,
        unit: 'kg',
        channels: ['UID'],
        productName: 'temp',
        fbranchId: 11,
        id: 1,
        table: AppTables.variation,
        taxName: 'N/A',
        taxPercentage: 0.0,
        retailPrice: 0.0,
        supplyPrice: 0.0,
      );
      ls.add(v);
      getAndRegisterApi(
        variations: ls,
        data: data,
      );

      model.navigateAddVariation(productId: 2);

      model.setUnit(unit: 'kg');

      final result = await model.addVariant(
          variations: ls, supplyPrice: 0.0, retailPrice: 0.0);

      expect(productService.currentUnit, 'kg');
      expect(result, 200);
    });
    test('When name is empty save should be disabled', () async {
      final model = _getModel();
      model.setName(name: ' '); //test when even empty string is given
      expect(model.lock, true);
    });

    test('When name and price is given lock should be removed to enable save',
        () async {
      final model = _getModel();
      model.setName(name: 'richie');
      model.isPriceSet(true);
      expect(model.lock, false);
    });
  });
}
