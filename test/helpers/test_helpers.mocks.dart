// Mocks generated by Mockito 5.0.8 from annotations
// in flipper/test/helpers/test_helpers.dart.
// Do not manually edit this file.

import 'dart:async' as _i11;

import 'package:flipper/stack.dart' as _i9;
import 'package:flipper_models/branch.dart' as _i13;
import 'package:flipper_models/business.dart' as _i12;
import 'package:flipper_models/category.dart' as _i15;
import 'package:flipper_models/color.dart' as _i14;
import 'package:flipper_models/login.dart' as _i2;
import 'package:flipper_models/order.dart' as _i6;
import 'package:flipper_models/product.dart' as _i5;
import 'package:flipper_models/spenn.dart' as _i8;
import 'package:flipper_models/stock.dart' as _i4;
import 'package:flipper_models/sync.dart' as _i3;
import 'package:flipper_models/unit.dart' as _i16;
import 'package:flipper_models/variant_stock.dart' as _i17;
import 'package:flipper_models/variants.dart' as _i7;
import 'package:flipper_services/abstractions/api.dart' as _i10;
import 'package:flipper_services/abstractions/storage.dart' as _i20;
import 'package:flipper_services/app_service.dart' as _i21;
import 'package:flipper_services/keypad_service.dart' as _i19;
import 'package:flipper_services/product_service.dart' as _i18;
import 'package:flutter/src/widgets/framework.dart' as _i23;
import 'package:flutter/src/widgets/navigator.dart' as _i24;
import 'package:mockito/mockito.dart' as _i1;
import 'package:stacked_services/src/navigation_service.dart' as _i22;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeLogin extends _i1.Fake implements _i2.Login {}

class _FakeSyncF extends _i1.Fake implements _i3.SyncF {}

class _FakeStock extends _i1.Fake implements _i4.Stock {}

class _FakeProduct extends _i1.Fake implements _i5.Product {}

class _FakeOrderF extends _i1.Fake implements _i6.OrderF {}

class _FakeVariant extends _i1.Fake implements _i7.Variant {}

class _FakeSpenn extends _i1.Fake implements _i8.Spenn {}

class _FakeStack<T> extends _i1.Fake implements _i9.Stack<T> {}

/// A class which mocks [Api].
///
/// See the documentation for Mockito's code generation for more information.
class MockApi<T> extends _i1.Mock implements _i10.Api<T> {
  @override
  _i11.Future<_i2.Login> login({String? phone}) =>
      (super.noSuchMethod(Invocation.method(#login, [], {#phone: phone}),
              returnValue: Future<_i2.Login>.value(_FakeLogin()))
          as _i11.Future<_i2.Login>);
  @override
  _i11.Future<List<_i5.Product>> products() =>
      (super.noSuchMethod(Invocation.method(#products, []),
              returnValue: Future<List<_i5.Product>>.value(<_i5.Product>[]))
          as _i11.Future<List<_i5.Product>>);
  @override
  _i11.Future<int> signup({Map<dynamic, dynamic>? business}) =>
      (super.noSuchMethod(Invocation.method(#signup, [], {#business: business}),
          returnValue: Future<int>.value(0)) as _i11.Future<int>);
  @override
  _i11.Future<_i3.SyncF> authenticateWithOfflineDb({String? userId}) =>
      (super.noSuchMethod(
          Invocation.method(#authenticateWithOfflineDb, [], {#userId: userId}),
          returnValue:
              Future<_i3.SyncF>.value(_FakeSyncF())) as _i11.Future<_i3.SyncF>);
  @override
  _i11.Future<List<_i12.Business>> businesses() =>
      (super.noSuchMethod(Invocation.method(#businesses, []),
              returnValue: Future<List<_i12.Business>>.value(<_i12.Business>[]))
          as _i11.Future<List<_i12.Business>>);
  @override
  _i11.Future<List<_i13.Branch>> branches({int? businessId}) => (super
      .noSuchMethod(Invocation.method(#branches, [], {#businessId: businessId}),
          returnValue: Future<List<_i13.Branch>>.value(<_i13.Branch>[])) as _i11
      .Future<List<_i13.Branch>>);
  @override
  _i11.Future<List<_i4.Stock>> stocks({int? productId}) => (super.noSuchMethod(
          Invocation.method(#stocks, [], {#productId: productId}),
          returnValue: Future<List<_i4.Stock>>.value(<_i4.Stock>[]))
      as _i11.Future<List<_i4.Stock>>);
  @override
  _i11.Stream<_i4.Stock> stockByVariantIdStream({int? variantId}) =>
      (super.noSuchMethod(
          Invocation.method(
              #stockByVariantIdStream, [], {#variantId: variantId}),
          returnValue: Stream<_i4.Stock>.empty()) as _i11.Stream<_i4.Stock>);
  @override
  _i11.Future<_i4.Stock> stockByVariantId({int? variantId}) =>
      (super.noSuchMethod(
              Invocation.method(#stockByVariantId, [], {#variantId: variantId}),
              returnValue: Future<_i4.Stock>.value(_FakeStock()))
          as _i11.Future<_i4.Stock>);
  @override
  _i11.Future<List<_i14.PColor>> colors({int? branchId}) =>
      (super.noSuchMethod(Invocation.method(#colors, [], {#branchId: branchId}),
              returnValue: Future<List<_i14.PColor>>.value(<_i14.PColor>[]))
          as _i11.Future<List<_i14.PColor>>);
  @override
  _i11.Future<List<_i15.Category>> categories({int? branchId}) =>
      (super.noSuchMethod(
              Invocation.method(#categories, [], {#branchId: branchId}),
              returnValue: Future<List<_i15.Category>>.value(<_i15.Category>[]))
          as _i11.Future<List<_i15.Category>>);
  @override
  _i11.Future<List<_i16.Unit>> units({int? branchId}) =>
      (super.noSuchMethod(Invocation.method(#units, [], {#branchId: branchId}),
              returnValue: Future<List<_i16.Unit>>.value(<_i16.Unit>[]))
          as _i11.Future<List<_i16.Unit>>);
  @override
  _i11.Future<int> create<T>({Map<dynamic, dynamic>? data, String? endPoint}) =>
      (super.noSuchMethod(
          Invocation.method(#create, [], {#data: data, #endPoint: endPoint}),
          returnValue: Future<int>.value(0)) as _i11.Future<int>);
  @override
  _i11.Future<int> update<T>({Map<dynamic, dynamic>? data, String? endPoint}) =>
      (super.noSuchMethod(
          Invocation.method(#update, [], {#data: data, #endPoint: endPoint}),
          returnValue: Future<int>.value(0)) as _i11.Future<int>);
  @override
  _i11.Future<bool> delete({dynamic id, String? endPoint}) =>
      (super.noSuchMethod(
          Invocation.method(#delete, [], {#id: id, #endPoint: endPoint}),
          returnValue: Future<bool>.value(false)) as _i11.Future<bool>);
  @override
  _i11.Future<_i14.PColor?> getColor({int? id, String? endPoint}) =>
      (super.noSuchMethod(
              Invocation.method(#getColor, [], {#id: id, #endPoint: endPoint}),
              returnValue: Future<_i14.PColor?>.value())
          as _i11.Future<_i14.PColor?>);
  @override
  _i11.Future<List<_i17.VariantStock>> variantStock(
          {int? branchId, int? variantId}) =>
      (super.noSuchMethod(
          Invocation.method(
              #variantStock, [], {#branchId: branchId, #variantId: variantId}),
          returnValue: Future<List<_i17.VariantStock>>.value(
              <_i17.VariantStock>[])) as _i11.Future<List<_i17.VariantStock>>);
  @override
  _i11.Future<List<_i7.Variant>> variants({int? branchId, int? productId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #variants, [], {#branchId: branchId, #productId: productId}),
              returnValue: Future<List<_i7.Variant>>.value(<_i7.Variant>[]))
          as _i11.Future<List<_i7.Variant>>);
  @override
  _i11.Future<_i7.Variant?> variant({int? variantId}) => (super.noSuchMethod(
      Invocation.method(#variant, [], {#variantId: variantId}),
      returnValue: Future<_i7.Variant?>.value()) as _i11.Future<_i7.Variant?>);
  @override
  _i11.Future<int> addUnits({Map<dynamic, dynamic>? data}) =>
      (super.noSuchMethod(Invocation.method(#addUnits, [], {#data: data}),
          returnValue: Future<int>.value(0)) as _i11.Future<int>);
  @override
  _i11.Future<int> addVariant(
          {List<_i7.Variant>? data,
          double? retailPrice,
          double? supplyPrice}) =>
      (super.noSuchMethod(
          Invocation.method(#addVariant, [], {
            #data: data,
            #retailPrice: retailPrice,
            #supplyPrice: supplyPrice
          }),
          returnValue: Future<int>.value(0)) as _i11.Future<int>);
  @override
  _i11.Future<_i5.Product?> getProduct({int? id}) => (super.noSuchMethod(
      Invocation.method(#getProduct, [], {#id: id}),
      returnValue: Future<_i5.Product?>.value()) as _i11.Future<_i5.Product?>);
  @override
  _i11.Future<_i5.Product> createProduct({_i5.Product? product}) =>
      (super.noSuchMethod(
              Invocation.method(#createProduct, [], {#product: product}),
              returnValue: Future<_i5.Product>.value(_FakeProduct()))
          as _i11.Future<_i5.Product>);
  @override
  _i11.Future<List<_i5.Product>> isTempProductExist() =>
      (super.noSuchMethod(Invocation.method(#isTempProductExist, []),
              returnValue: Future<List<_i5.Product>>.value(<_i5.Product>[]))
          as _i11.Future<List<_i5.Product>>);
  @override
  _i11.Future<bool> logOut() =>
      (super.noSuchMethod(Invocation.method(#logOut, []),
          returnValue: Future<bool>.value(false)) as _i11.Future<bool>);
  @override
  _i11.Future<_i6.OrderF> createOrder(
          {double? customAmount,
          _i7.Variant? variation,
          double? price,
          bool? useProductName = false,
          String? orderType = r'custom',
          double? quantity = 1.0}) =>
      (super.noSuchMethod(
              Invocation.method(#createOrder, [], {
                #customAmount: customAmount,
                #variation: variation,
                #price: price,
                #useProductName: useProductName,
                #orderType: orderType,
                #quantity: quantity
              }),
              returnValue: Future<_i6.OrderF>.value(_FakeOrderF()))
          as _i11.Future<_i6.OrderF>);
  @override
  _i11.Future<List<_i6.OrderF>> orders() =>
      (super.noSuchMethod(Invocation.method(#orders, []),
              returnValue: Future<List<_i6.OrderF>>.value(<_i6.OrderF>[]))
          as _i11.Future<List<_i6.OrderF>>);
  @override
  _i11.Future<_i7.Variant> getCustomProductVariant() =>
      (super.noSuchMethod(Invocation.method(#getCustomProductVariant, []),
              returnValue: Future<_i7.Variant>.value(_FakeVariant()))
          as _i11.Future<_i7.Variant>);
  @override
  _i11.Future<_i8.Spenn> spennPayment({double? amount, dynamic phoneNumber}) =>
      (super.noSuchMethod(
          Invocation.method(
              #spennPayment, [], {#amount: amount, #phoneNumber: phoneNumber}),
          returnValue:
              Future<_i8.Spenn>.value(_FakeSpenn())) as _i11.Future<_i8.Spenn>);
  @override
  _i11.Future<void> collectCashPayment(
          {double? cashReceived, _i6.OrderF? order}) =>
      (super.noSuchMethod(
          Invocation.method(#collectCashPayment, [],
              {#cashReceived: cashReceived, #order: order}),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i11.Future<void>);
}

/// A class which mocks [ProductService].
///
/// See the documentation for Mockito's code generation for more information.
class MockProductService extends _i1.Mock implements _i18.ProductService {
  @override
  List<_i5.Product> get products =>
      (super.noSuchMethod(Invocation.getter(#products),
          returnValue: <_i5.Product>[]) as List<_i5.Product>);
  @override
  dynamic setProductUnit({String? unit}) =>
      super.noSuchMethod(Invocation.method(#setProductUnit, [], {#unit: unit}));
  @override
  dynamic setCurrentProduct({_i5.Product? product}) => super.noSuchMethod(
      Invocation.method(#setCurrentProduct, [], {#product: product}));
  @override
  _i11.Future<void> variantsProduct({int? productId}) => (super.noSuchMethod(
      Invocation.method(#variantsProduct, [], {#productId: productId}),
      returnValue: Future<void>.value(),
      returnValueForMissingStub: Future.value()) as _i11.Future<void>);
  @override
  _i11.Future<void> loadProducts() =>
      (super.noSuchMethod(Invocation.method(#loadProducts, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i11.Future<void>);
  @override
  void listenToReactiveValues(List<dynamic>? reactiveValues) =>
      super.noSuchMethod(
          Invocation.method(#listenToReactiveValues, [reactiveValues]),
          returnValueForMissingStub: null);
  @override
  void addListener(void Function()? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(void Function()? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}

/// A class which mocks [KeyPadService].
///
/// See the documentation for Mockito's code generation for more information.
class MockKeyPadService extends _i1.Mock implements _i19.KeyPadService {
  @override
  _i9.Stack<dynamic> get stack => (super.noSuchMethod(Invocation.getter(#stack),
      returnValue: _FakeStack<dynamic>()) as _i9.Stack<dynamic>);
  @override
  set stack(_i9.Stack<dynamic>? _stack) =>
      super.noSuchMethod(Invocation.setter(#stack, _stack),
          returnValueForMissingStub: null);
  @override
  String get key =>
      (super.noSuchMethod(Invocation.getter(#key), returnValue: '') as String);
  @override
  List<_i6.OrderF> get orders => (super.noSuchMethod(Invocation.getter(#orders),
      returnValue: <_i6.OrderF>[]) as List<_i6.OrderF>);
  @override
  int get countOrderItems =>
      (super.noSuchMethod(Invocation.getter(#countOrderItems), returnValue: 0)
          as int);
  @override
  double get amountTotal =>
      (super.noSuchMethod(Invocation.getter(#amountTotal), returnValue: 0.0)
          as double);
  @override
  int get check =>
      (super.noSuchMethod(Invocation.getter(#check), returnValue: 0) as int);
  @override
  void addKey(String? key) =>
      super.noSuchMethod(Invocation.method(#addKey, [key]),
          returnValueForMissingStub: null);
  @override
  dynamic setAmount({double? amount}) =>
      super.noSuchMethod(Invocation.method(#setAmount, [], {#amount: amount}));
  @override
  dynamic setCashReceived({double? amount}) => super
      .noSuchMethod(Invocation.method(#setCashReceived, [], {#amount: amount}));
  @override
  void toggleCheckbox({int? variantId}) => super.noSuchMethod(
      Invocation.method(#toggleCheckbox, [], {#variantId: variantId}),
      returnValueForMissingStub: null);
  @override
  dynamic setCount({int? count}) =>
      super.noSuchMethod(Invocation.method(#setCount, [], {#count: count}));
  @override
  _i11.Future<List<_i6.OrderF>> getOrders() =>
      (super.noSuchMethod(Invocation.method(#getOrders, []),
              returnValue: Future<List<_i6.OrderF>>.value(<_i6.OrderF>[]))
          as _i11.Future<List<_i6.OrderF>>);
  @override
  void reset() => super.noSuchMethod(Invocation.method(#reset, []),
      returnValueForMissingStub: null);
  @override
  void increaseQty() => super.noSuchMethod(Invocation.method(#increaseQty, []),
      returnValueForMissingStub: null);
  @override
  void decreaseQty() => super.noSuchMethod(Invocation.method(#decreaseQty, []),
      returnValueForMissingStub: null);
  @override
  void pop() => super.noSuchMethod(Invocation.method(#pop, []),
      returnValueForMissingStub: null);
  @override
  void listenToReactiveValues(List<dynamic>? reactiveValues) =>
      super.noSuchMethod(
          Invocation.method(#listenToReactiveValues, [reactiveValues]),
          returnValueForMissingStub: null);
  @override
  void addListener(void Function()? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(void Function()? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}

/// A class which mocks [LocalStorage].
///
/// See the documentation for Mockito's code generation for more information.
class MockLocalStorage extends _i1.Mock implements _i20.LocalStorage {
  @override
  dynamic read({String? key}) =>
      super.noSuchMethod(Invocation.method(#read, [], {#key: key}));
  @override
  dynamic remove({String? key}) =>
      super.noSuchMethod(Invocation.method(#remove, [], {#key: key}));
  @override
  bool write({String? key, dynamic value}) => (super.noSuchMethod(
      Invocation.method(#write, [], {#key: key, #value: value}),
      returnValue: false) as bool);
}

/// A class which mocks [AppService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAppService extends _i1.Mock implements _i21.AppService {
  @override
  List<_i15.Category> get categories =>
      (super.noSuchMethod(Invocation.getter(#categories),
          returnValue: <_i15.Category>[]) as List<_i15.Category>);
  @override
  List<_i12.Business> get businesses =>
      (super.noSuchMethod(Invocation.getter(#businesses),
          returnValue: <_i12.Business>[]) as List<_i12.Business>);
  @override
  List<_i16.Unit> get units =>
      (super.noSuchMethod(Invocation.getter(#units), returnValue: <_i16.Unit>[])
          as List<_i16.Unit>);
  @override
  List<_i14.PColor> get colors =>
      (super.noSuchMethod(Invocation.getter(#colors),
          returnValue: <_i14.PColor>[]) as List<_i14.PColor>);
  @override
  String get currentColor =>
      (super.noSuchMethod(Invocation.getter(#currentColor), returnValue: '')
          as String);
  @override
  bool get hasLoggedInUser => (super
          .noSuchMethod(Invocation.getter(#hasLoggedInUser), returnValue: false)
      as bool);
  @override
  dynamic setCurrentColor({String? color}) => super
      .noSuchMethod(Invocation.method(#setCurrentColor, [], {#color: color}));
  @override
  dynamic setBusiness({List<_i12.Business>? businesses}) => super.noSuchMethod(
      Invocation.method(#setBusiness, [], {#businesses: businesses}));
  @override
  void loadCategories() =>
      super.noSuchMethod(Invocation.method(#loadCategories, []),
          returnValueForMissingStub: null);
  @override
  _i11.Future<void> loadUnits() =>
      (super.noSuchMethod(Invocation.method(#loadUnits, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i11.Future<void>);
  @override
  _i11.Future<void> loadColors() =>
      (super.noSuchMethod(Invocation.method(#loadColors, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future.value()) as _i11.Future<void>);
  @override
  bool isLoggedIn() => (super.noSuchMethod(Invocation.method(#isLoggedIn, []),
      returnValue: false) as bool);
  @override
  void listenToReactiveValues(List<dynamic>? reactiveValues) =>
      super.noSuchMethod(
          Invocation.method(#listenToReactiveValues, [reactiveValues]),
          returnValueForMissingStub: null);
  @override
  void addListener(void Function()? listener) =>
      super.noSuchMethod(Invocation.method(#addListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void removeListener(void Function()? listener) =>
      super.noSuchMethod(Invocation.method(#removeListener, [listener]),
          returnValueForMissingStub: null);
  @override
  void notifyListeners() =>
      super.noSuchMethod(Invocation.method(#notifyListeners, []),
          returnValueForMissingStub: null);
}

/// A class which mocks [NavigationService].
///
/// See the documentation for Mockito's code generation for more information.
class MockNavigationService extends _i1.Mock implements _i22.NavigationService {
  @override
  String get previousRoute =>
      (super.noSuchMethod(Invocation.getter(#previousRoute), returnValue: '')
          as String);
  @override
  String get currentRoute =>
      (super.noSuchMethod(Invocation.getter(#currentRoute), returnValue: '')
          as String);
  @override
  _i23.GlobalKey<_i24.NavigatorState>? nestedNavigationKey(int? index) =>
      (super.noSuchMethod(Invocation.method(#nestedNavigationKey, [index]))
          as _i23.GlobalKey<_i24.NavigatorState>?);
  @override
  void config(
          {bool? enableLog,
          bool? defaultPopGesture,
          bool? defaultOpaqueRoute,
          Duration? defaultDurationTransition,
          bool? defaultGlobalState,
          String? defaultTransition}) =>
      super.noSuchMethod(
          Invocation.method(#config, [], {
            #enableLog: enableLog,
            #defaultPopGesture: defaultPopGesture,
            #defaultOpaqueRoute: defaultOpaqueRoute,
            #defaultDurationTransition: defaultDurationTransition,
            #defaultGlobalState: defaultGlobalState,
            #defaultTransition: defaultTransition
          }),
          returnValueForMissingStub: null);
  @override
  _i11.Future<dynamic>? navigateWithTransition(_i23.Widget? page,
          {bool? opaque,
          String? transition = r'',
          Duration? duration,
          bool? popGesture,
          int? id}) =>
      (super.noSuchMethod(Invocation.method(#navigateWithTransition, [
        page
      ], {
        #opaque: opaque,
        #transition: transition,
        #duration: duration,
        #popGesture: popGesture,
        #id: id
      })) as _i11.Future<dynamic>?);
  @override
  _i11.Future<dynamic>? replaceWithTransition(_i23.Widget? page,
          {bool? opaque,
          String? transition = r'',
          Duration? duration,
          bool? popGesture,
          int? id}) =>
      (super.noSuchMethod(Invocation.method(#replaceWithTransition, [
        page
      ], {
        #opaque: opaque,
        #transition: transition,
        #duration: duration,
        #popGesture: popGesture,
        #id: id
      })) as _i11.Future<dynamic>?);
  @override
  bool back({dynamic result, int? id}) => (super.noSuchMethod(
      Invocation.method(#back, [], {#result: result, #id: id}),
      returnValue: false) as bool);
  @override
  void popUntil(_i24.RoutePredicate? predicate) =>
      super.noSuchMethod(Invocation.method(#popUntil, [predicate]),
          returnValueForMissingStub: null);
  @override
  void popRepeated(int? popTimes) =>
      super.noSuchMethod(Invocation.method(#popRepeated, [popTimes]),
          returnValueForMissingStub: null);
  @override
  _i11.Future<dynamic>? navigateTo(String? routeName,
          {dynamic arguments,
          int? id,
          bool? preventDuplicates = true,
          Map<String, String>? parameters}) =>
      (super.noSuchMethod(Invocation.method(#navigateTo, [
        routeName
      ], {
        #arguments: arguments,
        #id: id,
        #preventDuplicates: preventDuplicates,
        #parameters: parameters
      })) as _i11.Future<dynamic>?);
  @override
  _i11.Future<dynamic>? navigateToView(_i23.Widget? view,
          {dynamic arguments, int? id, bool? preventDuplicates = true}) =>
      (super.noSuchMethod(Invocation.method(#navigateToView, [
        view
      ], {
        #arguments: arguments,
        #id: id,
        #preventDuplicates: preventDuplicates
      })) as _i11.Future<dynamic>?);
  @override
  _i11.Future<dynamic>? replaceWith(String? routeName,
          {dynamic arguments,
          int? id,
          bool? preventDuplicates = true,
          Map<String, String>? parameters}) =>
      (super.noSuchMethod(Invocation.method(#replaceWith, [
        routeName
      ], {
        #arguments: arguments,
        #id: id,
        #preventDuplicates: preventDuplicates,
        #parameters: parameters
      })) as _i11.Future<dynamic>?);
  @override
  _i11.Future<dynamic>? clearStackAndShow(String? routeName,
          {dynamic arguments, int? id, Map<String, String>? parameters}) =>
      (super.noSuchMethod(Invocation.method(#clearStackAndShow, [
        routeName
      ], {
        #arguments: arguments,
        #id: id,
        #parameters: parameters
      })) as _i11.Future<dynamic>?);
  @override
  _i11.Future<dynamic>? clearTillFirstAndShow(String? routeName,
          {dynamic arguments,
          int? id,
          bool? preventDuplicates = true,
          Map<String, String>? parameters}) =>
      (super.noSuchMethod(Invocation.method(#clearTillFirstAndShow, [
        routeName
      ], {
        #arguments: arguments,
        #id: id,
        #preventDuplicates: preventDuplicates,
        #parameters: parameters
      })) as _i11.Future<dynamic>?);
  @override
  _i11.Future<dynamic>? clearTillFirstAndShowView(_i23.Widget? view,
          {dynamic arguments, int? id}) =>
      (super.noSuchMethod(Invocation.method(#clearTillFirstAndShowView, [view],
          {#arguments: arguments, #id: id})) as _i11.Future<dynamic>?);
  @override
  _i11.Future<dynamic>? pushNamedAndRemoveUntil(String? routeName,
          {_i24.RoutePredicate? predicate, dynamic arguments, int? id}) =>
      (super.noSuchMethod(Invocation.method(#pushNamedAndRemoveUntil, [
        routeName
      ], {
        #predicate: predicate,
        #arguments: arguments,
        #id: id
      })) as _i11.Future<dynamic>?);
}
