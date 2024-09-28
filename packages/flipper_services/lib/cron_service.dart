import 'dart:async';
import 'dart:io';
import 'dart:isolate';
import 'package:flipper_models/Subcriptions.dart';
import 'package:flipper_models/isolateHandelr.dart';
import 'package:flipper_services/constants.dart';
import 'package:flutter/services.dart';
import 'package:flipper_models/realm_model_export.dart';
import 'package:flipper_services/drive_service.dart';
import 'package:flipper_services/proxy.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:flipper_models/DownloadQueue.dart';
import 'package:realm/realm.dart';

class CronService with Subscriptions {
  final drive = GoogleDrive();

  Future<void> companyWideReport() async {
    // Implement company-wide report logic
  }

  Future<void> customerBasedReport() async {
    // Implement customer-based report logic
  }

  Future<void> connectBlueToothPrinter() async {
    // Implement Bluetooth connection logic
  }

  Future<void> deleteReceivedMessageFromServer() async {
    // Implement delete received message logic
  }
  Isolate? isolate;

  final talker = TalkerFlutter.init();

  void isolateKill() {
    if (isolate != null) {
      isolate?.kill();
    }
  }

  Future<void> _spawnIsolate(String name, dynamic isolateHandler) async {
    if (ProxyService.box.getBusinessId() == null) return;
    try {
      Business business = ProxyService.local.realm!.query<Business>(
          r'serverId == $0', [ProxyService.box.getBusinessId()!]).first;
      // talker.warning("Business ID ${ProxyService.box.getBusinessId()}");
      if (ProxyService.local
          .isTaxEnabled(business: ProxyService.local.getBusiness())) {
        ReceivePort receivePort = ReceivePort();

        /// kill any isolate that might be registered before we register new one!
        if (isolate != null) {
          isolateKill();
        }
        isolate = await Isolate.spawn(
          isolateHandler,
          [
            RootIsolateToken.instance,
            receivePort.sendPort,
            ProxyService.box.getBranchId()!,
            await ProxyService.realm
                .dbPath(path: name, folder: ProxyService.box.getBusinessId()),
            ProxyService.box.encryptionKey(),
            business.tinNumber,
            ProxyService.box.bhfId() ?? "00",
            ProxyService.box.getBusinessId(),
            ProxyService.box.getServerUrl(),
            await ProxyService.local.dbPath(
                path: 'local', folder: ProxyService.box.getBusinessId()),
          ],
        );

        receivePort.listen(
          (message) async {
            /// receive computed value that is considered that we have successfully completed updating EBM server
            /// then it is time to update the database and mark the model as updated this will help us to know
            /// if we are in sync with EBM server for all models we have inside our app
            String identifier = message as String;
            List<String> separator = identifier.split(":");
            // talker.warning(
            //     "About to update model ${separator.first} with ${separator.last}");
            if (separator.first == "variant") {
              // find this variant in db
              Variant variant = ProxyService.local.realm!
                  .query<Variant>(r'id == $0', [separator.last]).first;
              ProxyService.local.markModelForEbmUpdate<Variant>(model: variant);
            }
            if (separator.first == "stock") {
              // find this variant in db
              Stock stock = ProxyService.local.realm!
                  .query<Stock>(r'id == $0', [separator.last]).first;

              ProxyService.local.markModelForEbmUpdate<Stock>(model: stock);
            }
            if (separator.first == "notification") {
              /// in event when we are done with work in isolate
              /// then we kill current isolate, but it is very important to know
              /// that we receive this notification from isolate only when some work was done inside isolate
              /// this means if there is no work done, the isolate will fail to trigger the kill event to use to be able
              /// to kill the current isolate, this is why we have at the bottom of the code to forcefully kill whatever isolate
              /// that is hanging somewhere around
              isolate?.kill();
              ProxyService.notification
                  .sendLocalNotification(body: "System is up to date with EBM");
            }

            await ProxyService.local.realm!.subscriptions
                .waitForSynchronization();
          },
        );
        // Isolate.current.addOnExitListener(await receivePort.last);
        await Future.delayed(const Duration(seconds: 20));
        isolate?.kill();
      }
    } catch (error, s) {
      talker.warning('Error managing isolates: $s');
    }
  }

  /// Schedules various tasks and timers to handle data synchronization, device publishing, and other periodic operations.
  ///
  /// This method sets up the following scheduled tasks:
  /// - Initializes Firebase messaging and subscribes to business notifications.
  /// - Periodically pulls data from Realm.
  /// - Periodically pushes data to the server.
  /// - Periodically synchronizes Firestore data.
  /// - Periodically runs a demo print operation.
  /// - Periodically pulls data from the server.
  /// - Periodically attempts to publish the device to the server.
  ///
  /// The durations of these tasks are determined by the corresponding private methods.
  Future<void> schedule() async {
    /// listen for change and do not
    ProxyService.synchronize.watchTable<Stock>(
      tableName: 'stocks',
      idField: 'stock_id',
      useWatch: true,
      createRealmObject: (data) {
        return Stock(
          ObjectId(),
          currentStock: data['currentStock'],
          sold: data['sold'],
          lowStock: data['lowStock'],
          canTrackingStock: data['canTrackingStock'],
          showLowStockAlert: data['showLowStockAlert'],
          productId: data['product_id'],
          active: data['active'],
          value: data['value'],
          rsdQty: data['rsdQty'],
          supplyPrice: data['supplyPrice'],
          retailPrice: data['retailPrice'],
          lastTouched: DateTime.parse(data['lastTouched']),
          branchId: data['branch_id'],
          variantId: data['variant_id'],
          action: data['action'],
          deletedAt: data['deletedAt'] != null
              ? DateTime.parse(data['deletedAt'])
              : null,
          ebmSynced: data['ebmSynced'] ?? false,
        );
      },
      updateRealmObject: (_stock, data) {
        //find related variant
        Variant? variant = ProxyService.local.realm!
            .query<Variant>(r'id == $0', [data['variant_id']]).firstOrNull;
        final Stock? stock = ProxyService.local.stockByVariantId(
            variantId: data['variant_id'], branchId: data['branch_id']);
        if (variant != null && stock != null) {
          ProxyService.local.realm!.write(() {
            /// keep stock in sync
            stock.currentStock = double.parse(data['current_stock']);
            stock.rsdQty = double.parse(data['current_stock']);
            stock.lastTouched = DateTime.parse(data['last_touched']);

            /// keep variant in sync
            variant.qty = double.parse(data['current_stock']);

            variant.rsdQty = double.parse(data['current_stock']);

            variant.ebmSynced = false;
            talker.warning(
                "done updating variant & stock ${data['current_stock']}");
          });
        }
      },
    );

    Timer.periodic(_keepRealmInSync(), (Timer t) async {
      /// constantly download update from sqlite3
      ProxyService.synchronize.watchTable<Stock>(
        tableName: 'stocks',
        idField: 'stock_id',
        createRealmObject: (data) {
          return Stock(
            ObjectId(),
            currentStock: data['currentStock'],
            sold: data['sold'],
            lowStock: data['lowStock'],
            canTrackingStock: data['canTrackingStock'],
            showLowStockAlert: data['showLowStockAlert'],
            productId: data['product_id'],
            active: data['active'],
            value: data['value'],
            rsdQty: data['rsdQty'],
            supplyPrice: data['supplyPrice'],
            retailPrice: data['retailPrice'],
            lastTouched: DateTime.parse(data['lastTouched']),
            branchId: data['branch_id'],
            variantId: data['variant_id'],
            action: data['action'],
            deletedAt: data['deletedAt'] != null
                ? DateTime.parse(data['deletedAt'])
                : null,
            ebmSynced: data['ebmSynced'] ?? false,
          );
        },
        updateRealmObject: (_stock, data) {
          //find related variant
          Variant? variant = ProxyService.local.realm!
              .query<Variant>(r'id == $0', [data['variant_id']]).firstOrNull;
          final Stock? stock = ProxyService.local.stockByVariantId(
              variantId: data['variant_id'], branchId: data['branch_id']);
          if (variant != null && stock != null) {
            ProxyService.local.realm!.write(() {
              /// keep stock in sync
              stock.currentStock = double.parse(data['current_stock']);
              stock.rsdQty = double.parse(data['current_stock']);
              stock.lastTouched = DateTime.parse(data['last_touched']);

              /// keep variant in sync
              variant.qty = double.parse(data['current_stock']);

              variant.rsdQty = double.parse(data['current_stock']);

              variant.ebmSynced = false;
            });
          }
        },
      );
    });
    // create a compute function to keep track of unsaved data back to EBM do this in background
    /// keep assets downloaded and saved locally as they are added by other users in same business/branch
    Timer.periodic(_downloadFileSchedule(), (Timer t) async {
      try {
        final downloadQueue = DownloadQueue(3);

        int branchId = ProxyService.box.getBranchId()!;
        if (ProxyService.local.realm == null) {
          talker.warning("realm is null");
          return;
        }
        // ProxyService.box.writeBool(key: 'doneDownloadingAsset', value: false);
        if (!ProxyService.box.doneDownloadingAsset()) {
          List<Assets> assets = ProxyService.local.realm!
              .query<Assets>(r'branchId == $0', [branchId]).toList();

          for (Assets asset in assets) {
            if (asset.assetName != null) {
              downloadQueue.addToQueue(
                DownloadParams(
                  branchId: branchId,
                  assetName: asset.assetName!,
                  subPath: "branch",
                ),
              );
            }
          }
        }
      } catch (e, s) {
        talker.warning(e);
        talker.error(s);
      } finally {
        ProxyService.box.writeBool(key: 'doneDownloadingAsset', value: true);
      }
    });

    // Timer.periodic(_getBackUpDuration(), (Timer t) async {
    //   // final firestore = FirebaseFirestore.instance;
    //   await CloudSync().backUp(
    //     branchId: ProxyService.box.getBranchId()!,
    //     encryptionKey: ProxyService.box.encryptionKey(),
    //     dbPath: await ProxyService.realm
    //         .dbPath(path: 'synced', folder: ProxyService.box.getBusinessId()),
    //   );
    // });

    /// heart beat
    Timer.periodic(_getHeartBeatDuration(), (Timer t) async {
      backUpPowerSync();
      if (ProxyService.box.getUserId() == null ||
          ProxyService.box.getBusinessId() == null) return;

      /// bootstrap data for universal Product names;
      await _spawnIsolate("synced", IsolateHandler.flexibleSync);
      await _spawnIsolate("local", IsolateHandler.localData);

      await _spawnIsolate("synced", IsolateHandler.handleEBMTrigger);
    });

    await _setupFirebase();

    Timer.periodic(_getSyncPushDuration(), (Timer t) async {
      await _syncPushData();
    });

    Timer.periodic(_getFirebaseSyncDuration(), (Timer t) async {
      await _syncFirestoreData();
    });

    Timer.periodic(_getDemoPrintDuration(), (Timer t) async {
      await _runDemoPrint();
    });

    Timer.periodic(_getSyncPullDuration(), (Timer t) async {
      _syncPullData();
    });

    Timer.periodic(_getpublushingDeviceDuration(), (Timer t) async {
      // ProxyService.local.sendScheduleMessages();
      // await _keepTryingPublishDevice(); // Add this line
    });

    // Other scheduled tasks...
  }

  static String camelToSnakeCase(String input) {
    return input.replaceAllMapped(
      RegExp(r'([A-Z])'),
      (Match match) => '_${match.group(1)!.toLowerCase()}',
    );
  }

  void backUpPowerSync() async {
    try {
      ProxyService.realm.copyRemoteDataToLocalDb();

      List<Product> products =
          ProxyService.local.realm!.all<Product>().toList();
      List<Variant> variants =
          ProxyService.local.realm!.all<Variant>().toList();

      List<Stock> stocks = ProxyService.local.realm!.all<Stock>().toList();
      List<Counter> counters =
          ProxyService.local.realm!.all<Counter>().toList();

      // final userUuid = getUserId();

      // final databaseQueue = DatabaseQueue(5); // Allow 5 concurrent operations

      // await _insertOrUpdateItems(
      //     products, 'products', userUuid!, databaseQueue);
      // await _insertOrUpdateItems(variants, 'variants', userUuid, databaseQueue);
      // await _insertOrUpdateItems(stocks, 'stocks', userUuid, databaseQueue);
      // await _insertOrUpdateItems(counters, 'counters', userUuid, databaseQueue);
    } catch (e) {
      print(e);
    }
  }

  // Future<void> _insertOrUpdateItems<T>(List<T> items, String tableName,
  //     String userUuid, DatabaseQueue queue) async {
  // String singularTableName = tableName.endsWith('s')
  //     ? tableName.substring(0, tableName.length - 1)
  //     : tableName;

  // for (var item in items) {
  //   final noLose = item;
  //   final itemId = (noLose as dynamic).id;

  //   if (itemId != null) {
  //     final itemExist = await db.getOptional(
  //         'SELECT * FROM $tableName WHERE ${singularTableName}_id = ?',
  //         [itemId]);

  //     Map<String, dynamic>? map;
  //     if (item is Stock) {
  //       map = item.toEJson().toFlipperJson();
  //     } else if (item is Product) {
  //       map = item.toEJson().toFlipperJson();
  //     } else if (item is Variant) {
  //       map = item.toEJson().toFlipperJson();
  //     } else if (item is Counter) {
  //       map = item.toEJson().toFlipperJson();
  //     } else {
  //       throw TypeError();
  //     }

  //     map!['${singularTableName}_id'] = itemId;
  //     map['owner_id'] = userUuid;
  //     map.remove('_id');
  //     if (tableName == 'products') {
  //       map.remove('composites');
  //     } else if (tableName == 'stocks') {
  //       map.remove('variant');
  //     } else if (tableName == 'variants') {
  //       map.remove('branchIds');
  //     }

  //     if (itemExist == null) {
  //       // Item doesn't exist, perform insert
  //       map['id'] = 'uuid()';
  //       await queue.addToQueue(
  //         tableName: tableName,
  //         data: map,
  //         returningClause: '*',
  //       );
  //     }
  //   }
  // }
  // }

  Future<void> upsertObject(String tableName, Map<String, dynamic> map) async {
    // final singularTableName = tableName.substring(0, tableName.length - 1);
    // final single = singularTableName + "_id";

    // try {
    //   // Prepare the column names and values
    //   final columns = map.keys.where((key) => key != single).toList();
    //   final values = columns.map((col) => map[col]).toList();

    //   // Prepare the SQL statement
    //   final placeholders = List.filled(columns.length, '?').join(', ');
    //   final updateSet = columns.map((col) => '$col = ?').join(', ');

    //   // Construct the SQL query
    //   final sql = '''
    //   INSERT OR REPLACE INTO $tableName (${columns.join(', ')}, $single, created_at, updated_at)
    //   VALUES ($placeholders, ?, datetime('now'), datetime('now'))
    //   ON CONFLICT($single) DO UPDATE SET
    //   $updateSet, updated_at = datetime('now')
    //   WHERE $single = ?
    // ''';

    //   // Execute the query
    //   await db.execute(sql, [...values, map[single], ...values, map[single]]);
    // } catch (e) {
    //   rethrow;
    // }
  }

  Future<void> _setupFirebase() async {
    Business? business = await ProxyService.local.getBusiness();
    ProxyService.syncFirestore.configure();
    String? token;

    if (!Platform.isWindows && !isMacOs && !isIos) {
      token = await FirebaseMessaging.instance.getToken();

      Map updatedBusiness = business.toEJson() as Map<String, dynamic>;
      updatedBusiness['deviceToken'] = token.toString();
    }
  }

  Future<void> _syncPullData() async {
    if (ProxyService.remoteConfig.isSyncAvailable() &&
        ProxyService.remoteConfig.isHttpSyncAvailable()) {
      // ProxyService.sync.pull();
    }
  }

  Future<void> _syncPushData() async {
    if (ProxyService.remoteConfig.isSyncAvailable() &&
        ProxyService.remoteConfig.isHttpSyncAvailable()) {
      await _runRemoteHttpsIsolate();
      ProxyService.messaging
          .initializeFirebaseMessagingAndSubscribeToBusinessNotifications();
    }
    // Other sync-related logic...
  }

  Future<void> _syncFirestoreData() async {
    if (ProxyService.remoteConfig.isSyncAvailable()) {
      // Implement Firestore sync logic
      // ProxyService.syncFirestore.pull();
    }
  }

  Future<void> _runDemoPrint() async {
    // Implement demo print logic
  }

  Future<void> _runRemoteHttpsIsolate() async {
    // Implement logic to run _remoteHttps in an isolate
  }

  Duration _getSyncPushDuration() {
    return Duration(minutes: kDebugMode ? 1 : 5);
  }

  Duration _getSyncPullDuration() {
    return Duration(minutes: kDebugMode ? 10 : 20);
  }

  Duration _getpublushingDeviceDuration() {
    return Duration(minutes: kDebugMode ? 10 : 20);
  }

  Duration _getFirebaseSyncDuration() {
    return Duration(minutes: kDebugMode ? 3 : 7);
  }

  Duration _getDemoPrintDuration() {
    return Duration(minutes: kDebugMode ? 10 : 20);
  }

  Duration _downloadFileSchedule() {
    return Duration(minutes: kDebugMode ? 1 : 2);
  }

  Duration _keepRealmInSync() {
    return Duration(minutes: kDebugMode ? 10 : 10);
  }

  Duration _getBackUpDuration() {
    return Duration(hours: kDebugMode ? 4 : 4);
  }

  Duration _getHeartBeatDuration() {
    return Duration(seconds: kDebugMode ? 20 : 60);
  }
}
