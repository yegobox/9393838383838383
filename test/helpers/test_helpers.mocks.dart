// Mocks generated by Mockito 5.0.6 from annotations
// in flipper/test/helpers/test_helpers.dart.
// Do not manually edit this file.

import 'dart:async' as _i8;

import 'package:flipper_models/models/branch.dart' as _i10;
import 'package:flipper_models/models/business.dart' as _i9;
import 'package:flipper_models/models/category.dart' as _i11;
import 'package:flipper_models/models/color.dart' as _i5;
import 'package:flipper_models/models/login.dart' as _i2;
import 'package:flipper_models/models/product.dart' as _i6;
import 'package:flipper_models/models/stock.dart' as _i4;
import 'package:flipper_models/models/sync.dart' as _i3;
import 'package:flipper_models/models/unit.dart' as _i12;
import 'package:flipper_models/models/variant_stock.dart' as _i13;
import 'package:flipper_models/models/variation.dart' as _i14;
import 'package:flipper_services/abstractions/api.dart' as _i7;
import 'package:flipper_services/abstractions/storage.dart' as _i16;
import 'package:flipper_services/app_service.dart' as _i17;
import 'package:flipper_services/product_service.dart' as _i15;
import 'package:flutter/src/widgets/framework.dart' as _i19;
import 'package:flutter/src/widgets/navigator.dart' as _i20;
import 'package:mockito/mockito.dart' as _i1;
import 'package:stacked_services/src/navigation_service.dart' as _i18;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

// ignore_for_file: prefer_const_constructors

// ignore_for_file: avoid_redundant_argument_values

class _FakeLogin extends _i1.Fake implements _i2.Login {}

class _FakeSync extends _i1.Fake implements _i3.Sync {}

class _FakeStock extends _i1.Fake implements _i4.Stock {}

class _FakePColor extends _i1.Fake implements _i5.PColor {}

class _FakeProduct extends _i1.Fake implements _i6.Product {}

/// A class which mocks [Api].
///
/// See the documentation for Mockito's code generation for more information.
class MockApi<T> extends _i1.Mock implements _i7.Api<T> {
  @override
  _i8.Future<_i2.Login> login({String? phone}) =>
      (super.noSuchMethod(Invocation.method(#login, [], {#phone: phone}),
              returnValue: Future<_i2.Login>.value(_FakeLogin()))
          as _i8.Future<_i2.Login>);
  @override
  _i8.Future<List<_i6.Product>> products() =>
      (super.noSuchMethod(Invocation.method(#products, []),
              returnValue: Future<List<_i6.Product>>.value(<_i6.Product>[]))
          as _i8.Future<List<_i6.Product>>);
  @override
  _i8.Future<int> signup({Map<dynamic, dynamic>? business}) =>
      (super.noSuchMethod(Invocation.method(#signup, [], {#business: business}),
          returnValue: Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<_i3.Sync> authenticateWithOfflineDb({String? userId}) =>
      (super.noSuchMethod(
          Invocation.method(#authenticateWithOfflineDb, [], {#userId: userId}),
          returnValue:
              Future<_i3.Sync>.value(_FakeSync())) as _i8.Future<_i3.Sync>);
  @override
  _i8.Future<List<_i9.Business>?> businesses() =>
      (super.noSuchMethod(Invocation.method(#businesses, []),
              returnValue: Future<List<_i9.Business>?>.value(<_i9.Business>[]))
          as _i8.Future<List<_i9.Business>?>);
  @override
  _i8.Future<List<_i10.Branch>> branches({String? businessId}) =>
      (super.noSuchMethod(
              Invocation.method(#branches, [], {#businessId: businessId}),
              returnValue: Future<List<_i10.Branch>>.value(<_i10.Branch>[]))
          as _i8.Future<List<_i10.Branch>>);
  @override
  _i8.Future<List<_i4.Stock>> stocks({String? productId}) => (super
          .noSuchMethod(Invocation.method(#stocks, [], {#productId: productId}),
              returnValue: Future<List<_i4.Stock>>.value(<_i4.Stock>[]))
      as _i8.Future<List<_i4.Stock>>);
  @override
  _i8.Stream<_i4.Stock> stockByVariantIdStream({String? variantId}) =>
      (super.noSuchMethod(
          Invocation.method(
              #stockByVariantIdStream, [], {#variantId: variantId}),
          returnValue: Stream<_i4.Stock>.empty()) as _i8.Stream<_i4.Stock>);
  @override
  _i8.Future<_i4.Stock> stockByVariantId({String? variantId}) =>
      (super.noSuchMethod(
              Invocation.method(#stockByVariantId, [], {#variantId: variantId}),
              returnValue: Future<_i4.Stock>.value(_FakeStock()))
          as _i8.Future<_i4.Stock>);
  @override
  _i8.Future<List<_i5.PColor>> colors({String? branchId}) =>
      (super.noSuchMethod(Invocation.method(#colors, [], {#branchId: branchId}),
              returnValue: Future<List<_i5.PColor>>.value(<_i5.PColor>[]))
          as _i8.Future<List<_i5.PColor>>);
  @override
  _i8.Future<List<_i11.Category>> categories({String? branchId}) =>
      (super.noSuchMethod(
              Invocation.method(#categories, [], {#branchId: branchId}),
              returnValue: Future<List<_i11.Category>>.value(<_i11.Category>[]))
          as _i8.Future<List<_i11.Category>>);
  @override
  _i8.Future<List<_i12.Unit>> units({String? branchId}) =>
      (super.noSuchMethod(Invocation.method(#units, [], {#branchId: branchId}),
              returnValue: Future<List<_i12.Unit>>.value(<_i12.Unit>[]))
          as _i8.Future<List<_i12.Unit>>);
  @override
  _i8.Future<int> create<T>({Map<dynamic, dynamic>? data, String? endPoint}) =>
      (super.noSuchMethod(
          Invocation.method(#create, [], {#data: data, #endPoint: endPoint}),
          returnValue: Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<int> update<T>({Map<dynamic, dynamic>? data, String? endPoint}) =>
      (super.noSuchMethod(
          Invocation.method(#update, [], {#data: data, #endPoint: endPoint}),
          returnValue: Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<bool> delete({String? id, String? endPoint}) =>
      (super.noSuchMethod(
          Invocation.method(#delete, [], {#id: id, #endPoint: endPoint}),
          returnValue: Future<bool>.value(false)) as _i8.Future<bool>);
  @override
  _i8.Future<_i5.PColor> getColor({String? id, String? endPoint}) =>
      (super.noSuchMethod(
              Invocation.method(#getColor, [], {#id: id, #endPoint: endPoint}),
              returnValue: Future<_i5.PColor>.value(_FakePColor()))
          as _i8.Future<_i5.PColor>);
  @override
  _i8.Future<List<_i13.VariantStock>> variantStock(
          {String? branchId, String? variantId}) =>
      (super.noSuchMethod(
          Invocation.method(
              #variantStock, [], {#branchId: branchId, #variantId: variantId}),
          returnValue: Future<List<_i13.VariantStock>>.value(
              <_i13.VariantStock>[])) as _i8.Future<List<_i13.VariantStock>>);
  @override
  _i8.Future<List<_i14.Variation>> variants(
          {String? branchId, String? productId}) =>
      (super.noSuchMethod(
              Invocation.method(
                  #variants, [], {#branchId: branchId, #productId: productId}),
              returnValue:
                  Future<List<_i14.Variation>>.value(<_i14.Variation>[]))
          as _i8.Future<List<_i14.Variation>>);
  @override
  _i8.Future<int> addUnits({Map<dynamic, dynamic>? data}) =>
      (super.noSuchMethod(Invocation.method(#addUnits, [], {#data: data}),
          returnValue: Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<int> addVariant(
          {List<_i14.Variation>? data,
          double? retailPrice,
          double? supplyPrice}) =>
      (super.noSuchMethod(
          Invocation.method(#addVariant, [], {
            #data: data,
            #retailPrice: retailPrice,
            #supplyPrice: supplyPrice
          }),
          returnValue: Future<int>.value(0)) as _i8.Future<int>);
  @override
  _i8.Future<_i6.Product> getProduct({String? id}) =>
      (super.noSuchMethod(Invocation.method(#getProduct, [], {#id: id}),
              returnValue: Future<_i6.Product>.value(_FakeProduct()))
          as _i8.Future<_i6.Product>);
  @override
  _i8.Future<_i6.Product> createProduct({_i6.Product? product}) =>
      (super.noSuchMethod(
              Invocation.method(#createProduct, [], {#product: product}),
              returnValue: Future<_i6.Product>.value(_FakeProduct()))
          as _i8.Future<_i6.Product>);
  @override
  _i8.Future<List<_i6.Product>> isTempProductExist() =>
      (super.noSuchMethod(Invocation.method(#isTempProductExist, []),
              returnValue: Future<List<_i6.Product>>.value(<_i6.Product>[]))
          as _i8.Future<List<_i6.Product>>);
  @override
  _i8.Future<bool> logOut() =>
      (super.noSuchMethod(Invocation.method(#logOut, []),
          returnValue: Future<bool>.value(false)) as _i8.Future<bool>);
}

/// A class which mocks [ProductService].
///
/// See the documentation for Mockito's code generation for more information.
class MockProductService extends _i1.Mock implements _i15.ProductService {
  @override
  List<_i6.Product> get products =>
      (super.noSuchMethod(Invocation.getter(#products),
          returnValue: <_i6.Product>[]) as List<_i6.Product>);
  @override
  dynamic setProductUnit({String? unit}) =>
      super.noSuchMethod(Invocation.method(#setProductUnit, [], {#unit: unit}));
  @override
  dynamic setCurrentProduct({_i6.Product? product}) => super.noSuchMethod(
      Invocation.method(#setCurrentProduct, [], {#product: product}));
  @override
  _i8.Future<void> variantsProduct({String? productId}) => (super.noSuchMethod(
      Invocation.method(#variantsProduct, [], {#productId: productId}),
      returnValue: Future<void>.value(null),
      returnValueForMissingStub: Future.value()) as _i8.Future<void>);
  @override
  _i8.Future<void> loadProducts() =>
      (super.noSuchMethod(Invocation.method(#loadProducts, []),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i8.Future<void>);
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
class MockLocalStorage extends _i1.Mock implements _i16.LocalStorage {
  @override
  dynamic read({String? key}) =>
      super.noSuchMethod(Invocation.method(#read, [], {#key: key}));
  @override
  dynamic remove({String? key}) =>
      super.noSuchMethod(Invocation.method(#remove, [], {#key: key}));
  @override
  bool write({String? key, String? value}) => (super.noSuchMethod(
      Invocation.method(#write, [], {#key: key, #value: value}),
      returnValue: false) as bool);
}

/// A class which mocks [AppService].
///
/// See the documentation for Mockito's code generation for more information.
class MockAppService extends _i1.Mock implements _i17.AppService {
  @override
  List<_i11.Category> get categories =>
      (super.noSuchMethod(Invocation.getter(#categories),
          returnValue: <_i11.Category>[]) as List<_i11.Category>);
  @override
  List<_i12.Unit> get units =>
      (super.noSuchMethod(Invocation.getter(#units), returnValue: <_i12.Unit>[])
          as List<_i12.Unit>);
  @override
  List<_i5.PColor> get colors => (super.noSuchMethod(Invocation.getter(#colors),
      returnValue: <_i5.PColor>[]) as List<_i5.PColor>);
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
  void loadCategories() =>
      super.noSuchMethod(Invocation.method(#loadCategories, []),
          returnValueForMissingStub: null);
  @override
  _i8.Future<void> loadUnits() =>
      (super.noSuchMethod(Invocation.method(#loadUnits, []),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i8.Future<void>);
  @override
  _i8.Future<void> loadColors() =>
      (super.noSuchMethod(Invocation.method(#loadColors, []),
          returnValue: Future<void>.value(null),
          returnValueForMissingStub: Future.value()) as _i8.Future<void>);
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
class MockNavigationService extends _i1.Mock implements _i18.NavigationService {
  @override
  String get previousRoute =>
      (super.noSuchMethod(Invocation.getter(#previousRoute), returnValue: '')
          as String);
  @override
  String get currentRoute =>
      (super.noSuchMethod(Invocation.getter(#currentRoute), returnValue: '')
          as String);
  @override
  _i19.GlobalKey<_i20.NavigatorState>? nestedNavigationKey(int? index) =>
      (super.noSuchMethod(Invocation.method(#nestedNavigationKey, [index]))
          as _i19.GlobalKey<_i20.NavigatorState>?);
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
  _i8.Future<dynamic>? navigateWithTransition(_i19.Widget? page,
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
      })) as _i8.Future<dynamic>?);
  @override
  _i8.Future<dynamic>? replaceWithTransition(_i19.Widget? page,
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
      })) as _i8.Future<dynamic>?);
  @override
  bool back({dynamic result, int? id}) => (super.noSuchMethod(
      Invocation.method(#back, [], {#result: result, #id: id}),
      returnValue: false) as bool);
  @override
  void popUntil(_i20.RoutePredicate? predicate) =>
      super.noSuchMethod(Invocation.method(#popUntil, [predicate]),
          returnValueForMissingStub: null);
  @override
  void popRepeated(int? popTimes) =>
      super.noSuchMethod(Invocation.method(#popRepeated, [popTimes]),
          returnValueForMissingStub: null);
  @override
  _i8.Future<dynamic>? navigateTo(String? routeName,
          {dynamic arguments, int? id}) =>
      (super.noSuchMethod(Invocation.method(
              #navigateTo, [routeName], {#arguments: arguments, #id: id}))
          as _i8.Future<dynamic>?);
  @override
  _i8.Future<dynamic>? navigateToView(_i19.Widget? view,
          {dynamic arguments, int? id}) =>
      (super.noSuchMethod(Invocation.method(
              #navigateToView, [view], {#arguments: arguments, #id: id}))
          as _i8.Future<dynamic>?);
  @override
  _i8.Future<dynamic>? replaceWith(String? routeName,
          {dynamic arguments, int? id}) =>
      (super.noSuchMethod(Invocation.method(
              #replaceWith, [routeName], {#arguments: arguments, #id: id}))
          as _i8.Future<dynamic>?);
  @override
  _i8.Future<dynamic>? clearStackAndShow(String? routeName,
          {dynamic arguments, int? id}) =>
      (super.noSuchMethod(Invocation.method(#clearStackAndShow, [routeName],
          {#arguments: arguments, #id: id})) as _i8.Future<dynamic>?);
  @override
  _i8.Future<dynamic>? clearTillFirstAndShow(String? routeName,
          {dynamic arguments, int? id}) =>
      (super.noSuchMethod(Invocation.method(#clearTillFirstAndShow, [routeName],
          {#arguments: arguments, #id: id})) as _i8.Future<dynamic>?);
  @override
  _i8.Future<dynamic>? clearTillFirstAndShowView(_i19.Widget? view,
          {dynamic arguments, int? id}) =>
      (super.noSuchMethod(Invocation.method(#clearTillFirstAndShowView, [view],
          {#arguments: arguments, #id: id})) as _i8.Future<dynamic>?);
  @override
  _i8.Future<dynamic>? pushNamedAndRemoveUntil(String? routeName,
          {_i20.RoutePredicate? predicate, dynamic arguments, int? id}) =>
      (super.noSuchMethod(Invocation.method(#pushNamedAndRemoveUntil, [
        routeName
      ], {
        #predicate: predicate,
        #arguments: arguments,
        #id: id
      })) as _i8.Future<dynamic>?);
}
