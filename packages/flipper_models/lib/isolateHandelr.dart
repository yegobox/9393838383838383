import 'dart:convert';
import 'dart:isolate';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flipper_models/firebase_options.dart';
import 'package:flipper_models/helperModels/ICustomer.dart';
import 'package:flipper_models/helperModels/IStock.dart';
import 'package:flipper_models/helperModels/IVariant.dart';
import 'package:flipper_models/helperModels/UniversalProduct.dart';
import 'package:flipper_models/helperModels/random.dart';
import 'package:flipper_models/helperModels/talker.dart';
import 'package:flipper_models/realmModels.dart';
import 'package:flipper_models/realm_model_export.dart';
import 'package:flipper_models/rw_tax.dart';
import 'package:flipper_services/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:collection';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:supabase_models/brick/repository.dart' as brick;
import 'package:supabase_models/brick/repository.dart';

final repository = Repository();
mixin VariantPatch {
  static Future<void> patchVariant(
      {required String URI, required Function(String) sendPort}) async {
    // List<Variant> variants =
    //     localRealm!.query<Variant>(r'ebmSynced == $0', [false]).toList();
    final variants = await repository.get<Variant>(
        query: brick.Query(where: [Where('ebmSynced').isExactly(false)]));
    // delete all variants

    for (Variant variant in variants) {
      try {
        IVariant iVariant = IVariant.fromJson(variant.toJson());

        final response = await RWTax().saveItem(variation: iVariant, URI: URI);

        if (response.resultCd == "000") {
          sendPort('${response.resultMsg}:variant:${variant.id.toString()}');

          variant.ebmSynced = true;
          repository.upsert(variant);
        }
      } catch (e, s) {
        talker.error(e, s);
        rethrow;
      }
    }
  }
}
mixin StockPatch {
  static Future<void> patchStock(
      {required String URI, required Function(String) sendPort}) async {
    // List<Stock> stocks =
    //     localRealm!.query<Stock>(r'ebmSynced ==$0', [false]).toList();
    final stocks = await repository.get<Stock>(
        query: brick.Query(where: [Where('ebmSynced').isExactly(false)]));

    // List<int?> variantIds = stocks.map((stock) => stock.variantId).toList();
    Map<int, Variant?> variantMap = {};
    // localRealm.query<Variant>(r'id IN $0', [variantIds]).forEach((variant) {
    //   variantMap[variant.id!] = variant;
    // });
    for (Stock stock in stocks) {
      if (!stock.ebmSynced!) {
        Variant? variant = variantMap[stock.variantId];
        if (variant == null) {
          continue;
        }

        try {
          IStock iStock = IStock(
            id: stock.id,
            currentStock: stock.currentStock!,
          );
          IVariant iVariant = IVariant.fromJson(variant.toJson());

          final response = await RWTax()
              .saveStockMaster(stock: iStock, variant: iVariant, URI: URI);
          if (response.resultCd == "000") {
            sendPort('${response.resultMsg}');
            // localRealm.write(() {
            //   stock.ebmSynced = true;
            // });
          } else {
            sendPort('${response.resultMsg}}');
          }
        } catch (e) {
          rethrow;
        }
      }
    }
  }
}
mixin PatchTransactionItem {
  static Future<void> patchTransactionItem(
      {required String URI,
      required Function(String) sendPort,
      required int tinNumber,
      required String bhfId}) async {
    // List<ITransaction> transactions = localRealm!.query<ITransaction>(
    //     r'ebmSynced == $0 && status == $1 && customerName != null && customerTin != null',
    //     [false, COMPLETE]).toList();
    final transactions = await repository.get<ITransaction>(
        query: brick.Query(where: [
      Where('ebmSynced').isExactly(false),
      Where('status').isExactly(COMPLETE),
      Where('customerName').isNot(null),
      Where('customerTin').isNot(null)
    ]));

    print("transactions count ${transactions.length}");
    for (ITransaction transaction in transactions) {
      double taxB = 0;

      double totalvat = 0;

      // Configurations taxConfigTaxB =
      //     localRealm.query<Configurations>(r'taxType == $0', ["B"]).first;
      Configurations taxConfigTaxB = (await repository.get<Configurations>(
              query: brick.Query(where: [Where('taxType').isExactly("B")])))
          .first;

      // List<TransactionItem> items = localRealm.query<TransactionItem>(
      //     r'transactionId == $0', [transaction.id]).toList();
      List<TransactionItem> items = await repository.get<TransactionItem>(
          query: brick.Query(
              where: [Where('transactionId').isExactly(transaction.id)]));

      for (var item in items) {
        if (item.taxTyCd == "B") {
          taxB += (item.price * item.qty);
        }
      }

      final totalTaxB = calculateTotalTax(taxB, taxConfigTaxB);

      totalvat = totalTaxB;

      if (transaction.customerName == null || transaction.customerTin == null) {
        continue;
      }
      try {
        final response = await RWTax().saveStockItems(
            transaction: transaction,
            tinNumber: tinNumber.toString(),
            bhFId: bhfId,
            customerName: transaction.customerName ?? "N/A",
            custTin: transaction.customerTin ?? "999909695",
            regTyCd: "A",
            sarTyCd: transaction.sarTyCd ?? "11",
            custBhfId: transaction.customerBhfId ?? "",
            totalSupplyPrice: transaction.subTotal!,
            totalvat: totalvat,
            totalAmount: transaction.subTotal!,
            remark: transaction.remark ?? "",
            ocrnDt: DateTime.parse(
                transaction.updatedAt ?? DateTime.now().toString()),
            URI: URI);

        if (response.resultCd == "000") {
          sendPort(
              'notification:${response.resultMsg}:transaction:${transaction.id.toString()}');
          // localRealm.write(() {
          transaction.ebmSynced = true;
          // });
          repository.upsert(transaction);
        } else {
          sendPort('notification:${response.resultMsg}}');
        }
        print(response);
      } catch (e) {}
    }
  }

  static double calculateTotalTax(double tax, Configurations config) {
    final percentage = config.taxPercentage ?? 0;
    return (tax * percentage) / 100 + percentage;
  }
}
mixin CustomerPatch {
  static void patchCustomer(
      {required String URI,
      required Function(String) sendPort,
      required int tinNumber,
      required String bhfId,
      required int branchId}) async {
    // List<Customer> customers =
    //     localRealm!.query<Customer>(r'branchId ==$0', [branchId]).toList();
    final customers = await repository.get<Customer>(
        query: brick.Query(where: [Where('branchId').isExactly(branchId)]));

    for (Customer customer in customers) {
      if (!customer.ebmSynced!) {
        try {
          // localRealm.write(() {
          customer.tin = tinNumber;
          customer.bhfId = bhfId;
          // });
          repository.upsert(customer);

          if ((customer.custTin?.length ?? 0) < 9) return;
          ICustomer iCustomer = ICustomer.fromJson(customer.toJson());

          final response =
              await RWTax().saveCustomer(customer: iCustomer, URI: URI);
          if (response.resultCd == "000") {
            sendPort(
                'notification:${response.resultMsg.substring(0, 10)}:customer:${customer.id.toString()}');
          } else {
            sendPort('notification:${response.resultMsg}}');
          }
        } catch (e) {}
      }
    }
  }
}

class IsolateHandler with StockPatch {
  static Future<void> clearFirestoreCache() async {
    try {
      await FirebaseFirestore.instance.clearPersistence();
    } catch (e) {}
  }

  static Future<void> handler(List<dynamic> args) async {
    final SendPort sendPort = args[0];
    final RootIsolateToken rootIsolateToken = args[1];
    DartPluginRegistrant.ensureInitialized();
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

    ReceivePort port = ReceivePort();

    sendPort.send(port.sendPort);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    port.listen((message) async {
      if (message is Map<String, dynamic>) {
        print("Message received");
        String local = message['dbPath'];
        String encryptionKey = message['encryptionKey'];

        if (message['task'] == 'sync') {}
        if (message['task'] == 'taxService') {
          int branchId = message['branchId'];
          int tinNumber = message['tinNumber'];

          String URI = message['URI'];
          String bhfId = message['bhfId'];
          String encryptionKey = message['encryptionKey'];
          String local = message['dbPath'];

          PatchTransactionItem.patchTransactionItem(
            URI: URI,
            sendPort: (message) {
              sendPort.send("notification:" + message);
            },
            tinNumber: tinNumber,
            bhfId: bhfId,
          );
          StockPatch.patchStock(
            URI: URI,
            sendPort: (message) {
              sendPort.send("notification:" + message);
            },
          );

          VariantPatch.patchVariant(
            URI: URI,
            sendPort: (message) {
              sendPort.send("notification:" + message);
            },
          );

          CustomerPatch.patchCustomer(
            URI: URI,
            tinNumber: tinNumber,
            bhfId: bhfId,
            branchId: branchId,
            sendPort: (message) {
              sendPort.send("notification:" + message);
            },
          );
        }
      }
    });
  }

  static Future<void> localData(List<dynamic> args) async {
    final rootIsolateToken = args[0] as RootIsolateToken;

    String? key = args[4] as String?;

    int? branchId = args[2] as int?;
    int? businessId = args[7] as int?;
    String? bhfid = args[6] as String?;
    String? URI = args[8] as String?;
    if (key == null ||
        branchId == null ||
        businessId == null ||
        bhfid == null ||
        URI == null) return;

    List<UnversalProduct> codes = await repository.get<UnversalProduct>(
        query: brick.Query(where: [
      Where('branchId').isExactly(branchId),
    ]));

    if (codes.isEmpty) {
      final Completer<void> completer = Completer<void>();
      await fetchDataAndSaveUniversalProducts(businessId, branchId, URI, bhfid);

      completer.complete();
    }
    BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
    DartPluginRegistrant.ensureInitialized();
  }

  static Future<void> fetchDataAndSaveUniversalProducts(
      int businessId, int branchId, String URI, String bhfid) async {
    try {
      Business business = (await repository.get<Business>(
              query: brick.Query(
                  where: [Where('serverId').isExactly(businessId)])))
          .first;

      final url = URI + "/itemClass/selectItemsClass";
      final headers = {"Content-Type": "application/json"};
      final body = jsonEncode({
        "tin": business.tinNumber,
        "bhfId": bhfid,
        "lastReqDt": "20190523000000",
      });
      print("Loading item codes");
      final response =
          await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        if (jsonResponse['data'] != null &&
            jsonResponse['data']['itemClsList'] != null) {
          final List<dynamic> itemClsList = jsonResponse['data']['itemClsList'];

          for (var item in itemClsList) {
            final UniversalProduct product = UniversalProduct.fromJson(item);

            UnversalProduct? uni = (await repository.get<UnversalProduct>(
                    query: brick.Query(where: [
              Where('itemClsCd').isExactly(product.itemClsCd)
            ])))
                .firstOrNull;
            if (uni == null) {
              final unii = UnversalProduct(
                id: randomNumber(),
                itemClsCd: product.itemClsCd,
                itemClsLvl: product.itemClsLvl,
                itemClsNm: product.itemClsNm,
                branchId: branchId,
                businessId: businessId,
                useYn: product.useYn,
                mjrTgYn: product.mjrTgYn,
                taxTyCd: product.taxTyCd,
              );
              repository.upsert(unii);
            }
          }
        } else {
          print('No data found in the response.');
        }
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {}
  }
}
