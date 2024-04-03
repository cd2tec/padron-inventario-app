// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:flutter/material.dart' as _i12;
import 'package:padron_inventario_app/main.dart' as _i5;
import 'package:padron_inventario_app/pages/home_page.dart' as _i1;
import 'package:padron_inventario_app/pages/Inventory/inventory_detail_page.dart'
    as _i2;
import 'package:padron_inventario_app/pages/Inventory/inventory_page.dart'
    as _i3;
import 'package:padron_inventario_app/pages/login_page.dart' as _i4;
import 'package:padron_inventario_app/pages/register_page.dart' as _i6;
import 'package:padron_inventario_app/pages/search_barcode_page.dart' as _i7;
import 'package:padron_inventario_app/pages/stock_page.dart' as _i8;
import 'package:padron_inventario_app/pages/User/user_management_details_page.dart'
    as _i9;
import 'package:padron_inventario_app/pages/User/user_management_page.dart'
    as _i10;

abstract class $AppRouter extends _i11.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i11.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.HomePage(key: args.key),
      );
    },
    InventoryDetailRoute.name: (routeData) {
      final args = routeData.argsAs<InventoryDetailRouteArgs>(
          orElse: () => const InventoryDetailRouteArgs());
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.InventoryDetailPage(
          key: args.key,
          productData: args.productData,
        ),
      );
    },
    InventoryRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.InventoryPage(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.LoginPage(
          key: args.key,
          onResult: args.onResult,
        ),
      );
    },
    MyApp.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.MyApp(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.RegisterPage(),
      );
    },
    SearchBarcodeRoute.name: (routeData) {
      final args = routeData.argsAs<SearchBarcodeRouteArgs>();
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.SearchBarcodePage(productDetails: args.productDetails),
      );
    },
    StockRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.StockPage(),
      );
    },
    UserDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<UserDetailsRouteArgs>();
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.UserDetailsScreen(
          key: args.key,
          user: args.user,
        ),
      );
    },
    UserListRoute.name: (routeData) {
      return _i11.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.UserListScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i11.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i12.Key? key,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i11.PageInfo<HomeRouteArgs> page =
      _i11.PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final _i12.Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.InventoryDetailPage]
class InventoryDetailRoute
    extends _i11.PageRouteInfo<InventoryDetailRouteArgs> {
  InventoryDetailRoute({
    _i12.Key? key,
    Map<String, dynamic>? productData,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          InventoryDetailRoute.name,
          args: InventoryDetailRouteArgs(
            key: key,
            productData: productData,
          ),
          initialChildren: children,
        );

  static const String name = 'InventoryDetailRoute';

  static const _i11.PageInfo<InventoryDetailRouteArgs> page =
      _i11.PageInfo<InventoryDetailRouteArgs>(name);
}

class InventoryDetailRouteArgs {
  const InventoryDetailRouteArgs({
    this.key,
    this.productData,
    this.stockData,
  });

  final _i12.Key? key;

  final Map<String, dynamic>? productData;

  final Map<String, dynamic>? stockData;

  @override
  String toString() {
    return 'InventoryDetailRouteArgs{key: $key, productData: $productData, stockData: $stockData}';
  }
}

/// generated route for
/// [_i3.InventoryPage]
class InventoryRoute extends _i11.PageRouteInfo<void> {
  const InventoryRoute({List<_i11.PageRouteInfo>? children})
      : super(
          InventoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'InventoryRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i11.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i12.Key? key,
    required dynamic Function(bool?) onResult,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            key: key,
            onResult: onResult,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i11.PageInfo<LoginRouteArgs> page =
      _i11.PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    required this.onResult,
  });

  final _i12.Key? key;

  final dynamic Function(bool?) onResult;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onResult: $onResult}';
  }
}

/// generated route for
/// [_i5.MyApp]
class MyApp extends _i11.PageRouteInfo<void> {
  const MyApp({List<_i11.PageRouteInfo>? children})
      : super(
          MyApp.name,
          initialChildren: children,
        );

  static const String name = 'MyApp';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i6.RegisterPage]
class RegisterRoute extends _i11.PageRouteInfo<void> {
  const RegisterRoute({List<_i11.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i7.SearchBarcodePage]
class SearchBarcodeRoute extends _i11.PageRouteInfo<SearchBarcodeRouteArgs> {
  SearchBarcodeRoute({
    required String productDetails,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          SearchBarcodeRoute.name,
          args: SearchBarcodeRouteArgs(productDetails: productDetails),
          initialChildren: children,
        );

  static const String name = 'SearchBarcodeRoute';

  static const _i11.PageInfo<SearchBarcodeRouteArgs> page =
      _i11.PageInfo<SearchBarcodeRouteArgs>(name);
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
class StockRoute extends _i11.PageRouteInfo<void> {
  const StockRoute({List<_i11.PageRouteInfo>? children})
      : super(
          StockRoute.name,
          initialChildren: children,
        );

  static const String name = 'StockRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}

/// generated route for
/// [_i9.UserDetailsScreen]
class UserDetailsRoute extends _i11.PageRouteInfo<UserDetailsRouteArgs> {
  UserDetailsRoute({
    _i12.Key? key,
    required Map<String, dynamic> user,
    List<_i11.PageRouteInfo>? children,
  }) : super(
          UserDetailsRoute.name,
          args: UserDetailsRouteArgs(
            key: key,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'UserDetailsRoute';

  static const _i11.PageInfo<UserDetailsRouteArgs> page =
      _i11.PageInfo<UserDetailsRouteArgs>(name);
}

class UserDetailsRouteArgs {
  const UserDetailsRouteArgs({
    this.key,
    required this.user,
  });

  final _i12.Key? key;

  final Map<String, dynamic> user;

  @override
  String toString() {
    return 'UserDetailsRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i10.UserListScreen]
class UserListRoute extends _i11.PageRouteInfo<void> {
  const UserListRoute({List<_i11.PageRouteInfo>? children})
      : super(
          UserListRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserListRoute';

  static const _i11.PageInfo<void> page = _i11.PageInfo<void>(name);
}
