// save them in realm db
import 'package:flipper_models/realm_model_export.dart';
import 'package:flipper_services/proxy.dart';

class CreateMockdata {
  void mockBusiness() {
    // local.write(() {
    //   local.add<Business>(businessMock);
    // });
  }

  void mockTransactions() {
    for (var i = 0; i < 1000; i++) {
      // realm.write(() {
      //   realm.add<ITransaction>(ITransaction(
      //     lastTouched: DateTime(2023, 10, 28),
      //
      //     supplierId: 1,
      //     reference: "2333",
      //     transactionNumber: "3333",
      //     status: COMPLETE,
      //     transactionType: 'local',
      //     subTotal: 0,
      //     cashReceived: 0,
      //     updatedAt: DateTime(2023, 10, 28).toIso8601String(),
      //     customerChangeDue: 0.0,
      //     paymentType: ProxyService.box.paymentType() ?? "Cash",
      //     branchId: 1,
      //     createdAt: DateTime(2023, 10, 28).toIso8601String(),
      //     receiptType: "Standard",
      //     customerId: 101,
      //     customerType: "Regular",
      //     note: "Initial transaction",
      //     deletedAt: null,
      //     ebmSynced: false,
      //     isIncome: true,
      //     isExpense: false,
      //     isRefunded: false,
      //   ));
      // });
    }
  }

  Future<void> ensureRealmInitialized() async {
    // if (ProxyService.box.encryptionKey().isNotEmpty &&
    //     ProxyService.strategy.realm == null) {
    //   await ProxyService.strategy
    //       .configureLocal(useInMemory: false, box: ProxyService.box);
    // }
  }

  Future<void> createAndSaveMockStockRequests() async {
    // Create a product first
    Product? product = await ProxyService.strategy.createProduct(
        bhFId: "00",
        tinNumber: 111,
        branchId: 1,
        businessId: 1,
        product: Product(
            name: "Test Product",
            color: "#ccc",
            businessId: 1,
            branchId: 1,
            isComposite: true,
            nfcEnabled: false));

    if (product != null) {
      // Query for the variant
      // var variants = realm.query<Variant>(r'productId == $0', [product.id]);
      // var variant = variants.isNotEmpty ? variants.first : null;
      // realm.write(() {
      //   for (var variant in variants) {
      //     // Create Stock for each Variant
      //     Stock stock = Stock(
      //
      //       variantId: variant.id,
      //       currentStock: 100,
      //       branchId: 1,
      //       rsdQty: 100,
      //     );
      //     realm.add(stock);
      //   }
      // });
      // final mockStockRequests = [
      //   StockRequest(
      //
      //     mainBranchId: 1,
      //     subBranchId: 2,
      //     status: 'pending',
      //     items: [
      //       TransactionItem(
      //
      //         itemNm: "itemNm",
      //         price: 100,
      //         discount: 10,
      //         prc: 10,
      //         name: product.name,
      //         quantityRequested: 1,
      //         qty: 5,
      //         variantId: variant?.id ?? 0,
      //       ),
      //     ],
      //   ),
      //   StockRequest(
      //
      //     mainBranchId: 1,
      //     subBranchId: 2,
      //     status: 'pending',
      //     items: [
      //       TransactionItem(
      //
      //         itemNm: "itemNm",
      //         price: 100,
      //         discount: 10,
      //         prc: 10,
      //         quantityRequested: 1,
      //         name: product.name,
      //         qty: 3,
      //         variantId: variant?.id ?? 0,
      //       ),
      //     ],
      //   ),
      // ];

      // realm.write(() {
      //   for (var stockRequest in mockStockRequests) {
      //     realm.add(stockRequest);
      //   }
      // });
    }
  }
}
