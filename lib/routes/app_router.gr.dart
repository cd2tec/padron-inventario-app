// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/foundation.dart' as _i15;
import 'package:flutter/material.dart' as _i14;
import 'package:padron_inventario_app/main.dart' as _i5;
import 'package:padron_inventario_app/models/Supplier.dart' as _i16;
import 'package:padron_inventario_app/pages/home_page.dart' as _i1;
import 'package:padron_inventario_app/pages/Inventory/inventory_detail_page.dart'
    as _i2;
import 'package:padron_inventario_app/pages/Inventory/inventory_page.dart'
    as _i3;
import 'package:padron_inventario_app/pages/login_page.dart' as _i4;
import 'package:padron_inventario_app/pages/register_page.dart' as _i6;
import 'package:padron_inventario_app/pages/search_barcode_page.dart' as _i7;
import 'package:padron_inventario_app/pages/stock_page.dart' as _i8;
import 'package:padron_inventario_app/pages/Supplier/supplier_detail_page.dart'
    as _i9;
import 'package:padron_inventario_app/pages/Supplier/supplier_page.dart'
    as _i10;
import 'package:padron_inventario_app/pages/User/user_management_details_page.dart'
    as _i11;
import 'package:padron_inventario_app/pages/User/user_management_page.dart'
    as _i12;

abstract class $AppRouter extends _i13.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.HomePage(key: args.key),
      );
    },
    InventoryDetailRoute.name: (routeData) {
      final args = routeData.argsAs<InventoryDetailRouteArgs>(
          orElse: () => const InventoryDetailRouteArgs());
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.InventoryDetailPage(
          key: args.key,
          productData: args.productData,
          stockData: args.stockData,
        ),
      );
    },
    InventoryRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.InventoryPage(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.LoginPage(
          key: args.key,
          onResult: args.onResult,
        ),
      );
    },
    MyApp.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.MyApp(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.RegisterPage(),
      );
    },
    SearchBarcodeRoute.name: (routeData) {
      final args = routeData.argsAs<SearchBarcodeRouteArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.SearchBarcodePage(productDetails: args.productDetails),
      );
    },
    StockRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.StockPage(),
      );
    },
    SupplierDetailRoute.name: (routeData) {
      final args = routeData.argsAs<SupplierDetailRouteArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.SupplierDetailPage(
          key: args.key,
          supplier: args.supplier,
        ),
      );
    },
    SupplierRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.SupplierPage(),
      );
    },
    UserDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<UserDetailsRouteArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.UserDetailsScreen(
          key: args.key,
          user: args.user,
        ),
      );
    },
    UserListRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.UserListScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i13.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i14.Key? key,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i13.PageInfo<HomeRouteArgs> page =
      _i13.PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final _i14.Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.InventoryDetailPage]
class InventoryDetailRoute
    extends _i13.PageRouteInfo<InventoryDetailRouteArgs> {
  InventoryDetailRoute({
    _i15.Key? key,
    Map<String, dynamic>? productData,
    Map<String, dynamic>? stockData,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          InventoryDetailRoute.name,
          args: InventoryDetailRouteArgs(
            key: key,
            productData: productData,
            stockData: stockData,
          ),
          initialChildren: children,
        );

  static const String name = 'InventoryDetailRoute';

  static const _i13.PageInfo<InventoryDetailRouteArgs> page =
      _i13.PageInfo<InventoryDetailRouteArgs>(name);
}

class InventoryDetailRouteArgs {
  const InventoryDetailRouteArgs({
    this.key,
    this.productData,
    this.stockData,
  });

  final _i15.Key? key;

  final Map<String, dynamic>? productData;

  final Map<String, dynamic>? stockData;

  @override
  String toString() {
    return 'InventoryDetailRouteArgs{key: $key, productData: $productData, stockData: $stockData}';
  }
}

/// generated route for
/// [_i3.InventoryPage]
class InventoryRoute extends _i13.PageRouteInfo<void> {
  const InventoryRoute({List<_i13.PageRouteInfo>? children})
      : super(
          InventoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'InventoryRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i13.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i14.Key? key,
    required dynamic Function(bool?) onResult,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            key: key,
            onResult: onResult,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i13.PageInfo<LoginRouteArgs> page =
      _i13.PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    required this.onResult,
  });

  final _i14.Key? key;

  final dynamic Function(bool?) onResult;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onResult: $onResult}';
  }
}

/// generated route for
/// [_i5.MyApp]
class MyApp extends _i13.PageRouteInfo<void> {
  const MyApp({List<_i13.PageRouteInfo>? children})
      : super(
          MyApp.name,
          initialChildren: children,
        );

  static const String name = 'MyApp';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i6.RegisterPage]
class RegisterRoute extends _i13.PageRouteInfo<void> {
  const RegisterRoute({List<_i13.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SearchBarcodePage]
class SearchBarcodeRoute extends _i13.PageRouteInfo<SearchBarcodeRouteArgs> {
  SearchBarcodeRoute({
    required String productDetails,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          SearchBarcodeRoute.name,
          args: SearchBarcodeRouteArgs(productDetails: productDetails),
          initialChildren: children,
        );

  static const String name = 'SearchBarcodeRoute';

  static const _i13.PageInfo<SearchBarcodeRouteArgs> page =
      _i13.PageInfo<SearchBarcodeRouteArgs>(name);
}

class SearchBarcodeRouteArgs {
  const SearchBarcodeRouteArgs({required this.productDetails});

  final String productDetails;

  @override
  String toString() {
    return 'SearchBarcodeRouteArgs{productDetails: $productDetails}';
  }
}

/// generated route for
/// [_i8.StockPage]
class StockRoute extends _i13.PageRouteInfo<void> {
  const StockRoute({List<_i13.PageRouteInfo>? children})
      : super(
          StockRoute.name,
          initialChildren: children,
        );

  static const String name = 'StockRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i9.SupplierDetailPage]
class SupplierDetailRoute extends _i13.PageRouteInfo<SupplierDetailRouteArgs> {
  SupplierDetailRoute({
    _i14.Key? key,
    required _i16.Supplier supplier,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          SupplierDetailRoute.name,
          args: SupplierDetailRouteArgs(
            key: key,
            supplier: supplier,
          ),
          initialChildren: children,
        );

  static const String name = 'SupplierDetailRoute';

  static const _i13.PageInfo<SupplierDetailRouteArgs> page =
      _i13.PageInfo<SupplierDetailRouteArgs>(name);
}

class SupplierDetailRouteArgs {
  const SupplierDetailRouteArgs({
    this.key,
    required this.supplier,
  });

  final _i14.Key? key;

  final _i16.Supplier supplier;

  @override
  String toString() {
    return 'SupplierDetailRouteArgs{key: $key, supplier: $supplier}';
  }
}

/// generated route for
/// [_i10.SupplierPage]
class SupplierRoute extends _i13.PageRouteInfo<void> {
  const SupplierRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SupplierRoute.name,
          initialChildren: children,
        );

  static const String name = 'SupplierRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i11.UserDetailsScreen]
class UserDetailsRoute extends _i13.PageRouteInfo<UserDetailsRouteArgs> {
  UserDetailsRoute({
    _i14.Key? key,
    required Map<String, dynamic> user,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          UserDetailsRoute.name,
          args: UserDetailsRouteArgs(
            key: key,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'UserDetailsRoute';

  static const _i13.PageInfo<UserDetailsRouteArgs> page =
      _i13.PageInfo<UserDetailsRouteArgs>(name);
}

class UserDetailsRouteArgs {
  const UserDetailsRouteArgs({
    this.key,
    required this.user,
  });

  final _i14.Key? key;

  final Map<String, dynamic> user;

  @override
  String toString() {
    return 'UserDetailsRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i12.UserListScreen]
class UserListRoute extends _i13.PageRouteInfo<void> {
  const UserListRoute({List<_i13.PageRouteInfo>? children})
      : super(
          UserListRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserListRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}
