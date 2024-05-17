// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/foundation.dart' as _i16;
import 'package:flutter/material.dart' as _i15;
import 'package:padron_inventario_app/main.dart' as _i6;
import 'package:padron_inventario_app/pages/home_page.dart' as _i1;
import 'package:padron_inventario_app/pages/Inventory/inventory_detail_page.dart'
    as _i2;
import 'package:padron_inventario_app/pages/Inventory/inventory_page.dart'
    as _i3;
import 'package:padron_inventario_app/pages/login_page.dart' as _i4;
import 'package:padron_inventario_app/pages/Mapping/mapping_keys.dart' as _i5;
import 'package:padron_inventario_app/pages/register_page.dart' as _i7;
import 'package:padron_inventario_app/pages/Supplier/supplier_detail_page.dart'
    as _i8;
import 'package:padron_inventario_app/pages/Supplier/supplier_page.dart' as _i9;
import 'package:padron_inventario_app/pages/Supplier/supplier_products_page.dart'
    as _i10;
import 'package:padron_inventario_app/pages/Supplier/supplier_search_product_page.dart'
    as _i11;
import 'package:padron_inventario_app/pages/User/user_management_details_page.dart'
    as _i12;
import 'package:padron_inventario_app/pages/User/user_management_page.dart'
    as _i13;

abstract class $AppRouter extends _i14.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.HomePage(key: args.key),
      );
    },
    InventoryDetailRoute.name: (routeData) {
      final args = routeData.argsAs<InventoryDetailRouteArgs>(
          orElse: () => const InventoryDetailRouteArgs());
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.InventoryDetailPage(
          key: args.key,
          productData: args.productData,
        ),
      );
    },
    InventoryRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.InventoryPage(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.LoginPage(
          key: args.key,
          onResult: args.onResult,
        ),
      );
    },
    MappingKeys.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.MappingKeys(),
      );
    },
    MyApp.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.MyApp(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.RegisterPage(),
      );
    },
    SupplierDetailRoute.name: (routeData) {
      final args = routeData.argsAs<SupplierDetailRouteArgs>(
          orElse: () => const SupplierDetailRouteArgs());
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.SupplierDetailPage(
          key: args.key,
          productData: args.productData,
        ),
      );
    },
    SupplierRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.SupplierPage(),
      );
    },
    SupplierProductsRoute.name: (routeData) {
      final args = routeData.argsAs<SupplierProductsRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.SupplierProductsPage(
          key: args.key,
          inventory: args.inventory,
        ),
      );
    },
    SupplierSearchProductRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.SupplierSearchProductPage(),
      );
    },
    UserDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<UserDetailsRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.UserDetailsScreen(
          key: args.key,
          user: args.user,
        ),
      );
    },
    UserListRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.UserListScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i14.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i15.Key? key,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i14.PageInfo<HomeRouteArgs> page =
      _i14.PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final _i15.Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.InventoryDetailPage]
class InventoryDetailRoute
    extends _i14.PageRouteInfo<InventoryDetailRouteArgs> {
  InventoryDetailRoute({
    _i16.Key? key,
    Map<String, dynamic>? productData,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          InventoryDetailRoute.name,
          args: InventoryDetailRouteArgs(
            key: key,
            productData: productData,
          ),
          initialChildren: children,
        );

  static const String name = 'InventoryDetailRoute';

  static const _i14.PageInfo<InventoryDetailRouteArgs> page =
      _i14.PageInfo<InventoryDetailRouteArgs>(name);
}

class InventoryDetailRouteArgs {
  const InventoryDetailRouteArgs({
    this.key,
    this.productData,
  });

  final _i16.Key? key;

  final Map<String, dynamic>? productData;

  @override
  String toString() {
    return 'InventoryDetailRouteArgs{key: $key, productData: $productData}';
  }
}

/// generated route for
/// [_i3.InventoryPage]
class InventoryRoute extends _i14.PageRouteInfo<void> {
  const InventoryRoute({List<_i14.PageRouteInfo>? children})
      : super(
          InventoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'InventoryRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i14.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i15.Key? key,
    required dynamic Function(bool?) onResult,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            key: key,
            onResult: onResult,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i14.PageInfo<LoginRouteArgs> page =
      _i14.PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    required this.onResult,
  });

  final _i15.Key? key;

  final dynamic Function(bool?) onResult;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onResult: $onResult}';
  }
}

/// generated route for
/// [_i5.MappingKeys]
class MappingKeys extends _i14.PageRouteInfo<void> {
  const MappingKeys({List<_i14.PageRouteInfo>? children})
      : super(
          MappingKeys.name,
          initialChildren: children,
        );

  static const String name = 'MappingKeys';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i6.MyApp]
class MyApp extends _i14.PageRouteInfo<void> {
  const MyApp({List<_i14.PageRouteInfo>? children})
      : super(
          MyApp.name,
          initialChildren: children,
        );

  static const String name = 'MyApp';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i7.RegisterPage]
class RegisterRoute extends _i14.PageRouteInfo<void> {
  const RegisterRoute({List<_i14.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SupplierDetailPage]
class SupplierDetailRoute extends _i14.PageRouteInfo<SupplierDetailRouteArgs> {
  SupplierDetailRoute({
    _i16.Key? key,
    Map<String, dynamic>? productData,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          SupplierDetailRoute.name,
          args: SupplierDetailRouteArgs(
            key: key,
            productData: productData,
          ),
          initialChildren: children,
        );

  static const String name = 'SupplierDetailRoute';

  static const _i14.PageInfo<SupplierDetailRouteArgs> page =
      _i14.PageInfo<SupplierDetailRouteArgs>(name);
}

class SupplierDetailRouteArgs {
  const SupplierDetailRouteArgs({
    this.key,
    this.productData,
  });

  final _i16.Key? key;

  final Map<String, dynamic>? productData;

  @override
  String toString() {
    return 'SupplierDetailRouteArgs{key: $key, productData: $productData}';
  }
}

/// generated route for
/// [_i9.SupplierPage]
class SupplierRoute extends _i14.PageRouteInfo<void> {
  const SupplierRoute({List<_i14.PageRouteInfo>? children})
      : super(
          SupplierRoute.name,
          initialChildren: children,
        );

  static const String name = 'SupplierRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i10.SupplierProductsPage]
class SupplierProductsRoute
    extends _i14.PageRouteInfo<SupplierProductsRouteArgs> {
  SupplierProductsRoute({
    _i15.Key? key,
    required List<Map<String, dynamic>> inventory,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          SupplierProductsRoute.name,
          args: SupplierProductsRouteArgs(
            key: key,
            inventory: inventory,
          ),
          initialChildren: children,
        );

  static const String name = 'SupplierProductsRoute';

  static const _i14.PageInfo<SupplierProductsRouteArgs> page =
      _i14.PageInfo<SupplierProductsRouteArgs>(name);
}

class SupplierProductsRouteArgs {
  const SupplierProductsRouteArgs({
    this.key,
    required this.inventory,
  });

  final _i15.Key? key;

  final List<Map<String, dynamic>> inventory;

  @override
  String toString() {
    return 'SupplierProductsRouteArgs{key: $key, inventory: $inventory}';
  }
}

/// generated route for
/// [_i11.SupplierSearchProductPage]
class SupplierSearchProductRoute extends _i14.PageRouteInfo<void> {
  const SupplierSearchProductRoute({List<_i14.PageRouteInfo>? children})
      : super(
          SupplierSearchProductRoute.name,
          initialChildren: children,
        );

  static const String name = 'SupplierSearchProductRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i12.UserDetailsScreen]
class UserDetailsRoute extends _i14.PageRouteInfo<UserDetailsRouteArgs> {
  UserDetailsRoute({
    _i15.Key? key,
    required Map<String, dynamic> user,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          UserDetailsRoute.name,
          args: UserDetailsRouteArgs(
            key: key,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'UserDetailsRoute';

  static const _i14.PageInfo<UserDetailsRouteArgs> page =
      _i14.PageInfo<UserDetailsRouteArgs>(name);
}

class UserDetailsRouteArgs {
  const UserDetailsRouteArgs({
    this.key,
    required this.user,
  });

  final _i15.Key? key;

  final Map<String, dynamic> user;

  @override
  String toString() {
    return 'UserDetailsRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i13.UserListScreen]
class UserListRoute extends _i14.PageRouteInfo<void> {
  const UserListRoute({List<_i14.PageRouteInfo>? children})
      : super(
          UserListRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserListRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}
