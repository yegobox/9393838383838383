import 'package:flipper_models/variation.dart';

final variationMock = new Variant(
  id: DateTime.now().millisecondsSinceEpoch,
  name: 'Regular',
  sku: 'sku',
  fproductId: 2,
  unit: 'Per Item',
  table: 'variants',
  channels: ['300'],
  productName: 'Custom Amount',
  branchId: 11,
  taxName: 'N/A',
  taxPercentage: 0.0,
);
