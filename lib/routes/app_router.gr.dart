// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/foundation.dart' as _i19;
import 'package:flutter/material.dart' as _i18;
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
import 'package:padron_inventario_app/pages/Supplier/supplier_inventory_details.dart'
    as _i9;
import 'package:padron_inventario_app/pages/Supplier/supplier_page.dart'
    as _i10;
import 'package:padron_inventario_app/pages/Supplier/supplier_product_detail_page.dart'
    as _i11;
import 'package:padron_inventario_app/pages/Supplier/supplier_products_list_page.dart'
    as _i12;
import 'package:padron_inventario_app/pages/Supplier/supplier_products_page.dart'
    as _i13;
import 'package:padron_inventario_app/pages/Supplier/supplier_search_product_page.dart'
    as _i14;
import 'package:padron_inventario_app/pages/User/user_management_details_page.dart'
    as _i15;
import 'package:padron_inventario_app/pages/User/user_management_page.dart'
    as _i16;

abstract class $AppRouter extends _i17.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i17.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      final args =
          routeData.argsAs<HomeRouteArgs>(orElse: () => const HomeRouteArgs());
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.HomePage(key: args.key),
      );
    },
    InventoryDetailRoute.name: (routeData) {
      final args = routeData.argsAs<InventoryDetailRouteArgs>(
          orElse: () => const InventoryDetailRouteArgs());
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.InventoryDetailPage(
          key: args.key,
          productData: args.productData,
        ),
      );
    },
    InventoryRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.InventoryPage(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.LoginPage(
          key: args.key,
          onResult: args.onResult,
        ),
      );
    },
    MappingKeys.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.MappingKeys(),
      );
    },
    MyApp.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.MyApp(),
      );
    },
    RegisterRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.RegisterPage(),
      );
    },
    SupplierDetailRoute.name: (routeData) {
      final args = routeData.argsAs<SupplierDetailRouteArgs>(
          orElse: () => const SupplierDetailRouteArgs());
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.SupplierDetailPage(
          key: args.key,
          productData: args.productData,
        ),
      );
    },
    SupplierInventoryDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<SupplierInventoryDetailsRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.SupplierInventoryDetailsPage(
          key: args.key,
          inventory: args.inventory,
        ),
      );
    },
    SupplierRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.SupplierPage(),
      );
    },
    SupplierProductDetailRoute.name: (routeData) {
      final args = routeData.argsAs<SupplierProductDetailRouteArgs>(
          orElse: () => const SupplierProductDetailRouteArgs());
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i11.SupplierProductDetailPage(
          key: args.key,
          productData: args.productData,
        ),
      );
    },
    SupplierProductsListRoute.name: (routeData) {
      final args = routeData.argsAs<SupplierProductsListRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.SupplierProductsListPage(
          key: args.key,
          inventory: args.inventory,
          products: args.products,
        ),
      );
    },
    SupplierProductsRoute.name: (routeData) {
      final args = routeData.argsAs<SupplierProductsRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i13.SupplierProductsPage(
          key: args.key,
          inventory: args.inventory,
        ),
      );
    },
    SupplierSearchProductRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i14.SupplierSearchProductPage(),
      );
    },
    UserDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<UserDetailsRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i15.UserDetailsScreen(
          key: args.key,
          user: args.user,
        ),
      );
    },
    UserListRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i16.UserListScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i17.PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    _i18.Key? key,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i17.PageInfo<HomeRouteArgs> page =
      _i17.PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i2.InventoryDetailPage]
class InventoryDetailRoute
    extends _i17.PageRouteInfo<InventoryDetailRouteArgs> {
  InventoryDetailRoute({
    _i19.Key? key,
    Map<String, dynamic>? productData,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          InventoryDetailRoute.name,
          args: InventoryDetailRouteArgs(
            key: key,
            productData: productData,
          ),
          initialChildren: children,
        );

  static const String name = 'InventoryDetailRoute';

  static const _i17.PageInfo<InventoryDetailRouteArgs> page =
      _i17.PageInfo<InventoryDetailRouteArgs>(name);
}

class InventoryDetailRouteArgs {
  const InventoryDetailRouteArgs({
    this.key,
    this.productData,
  });

  final _i19.Key? key;

  final Map<String, dynamic>? productData;

  @override
  String toString() {
    return 'InventoryDetailRouteArgs{key: $key, productData: $productData}';
  }
}

/// generated route for
/// [_i3.InventoryPage]
class InventoryRoute extends _i17.PageRouteInfo<void> {
  const InventoryRoute({List<_i17.PageRouteInfo>? children})
      : super(
          InventoryRoute.name,
          initialChildren: children,
        );

  static const String name = 'InventoryRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i4.LoginPage]
class LoginRoute extends _i17.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i18.Key? key,
    required dynamic Function(bool?) onResult,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(
            key: key,
            onResult: onResult,
          ),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i17.PageInfo<LoginRouteArgs> page =
      _i17.PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({
    this.key,
    required this.onResult,
  });

  final _i18.Key? key;

  final dynamic Function(bool?) onResult;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key, onResult: $onResult}';
  }
}

/// generated route for
/// [_i5.MappingKeys]
class MappingKeys extends _i17.PageRouteInfo<void> {
  const MappingKeys({List<_i17.PageRouteInfo>? children})
      : super(
          MappingKeys.name,
          initialChildren: children,
        );

  static const String name = 'MappingKeys';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i6.MyApp]
class MyApp extends _i17.PageRouteInfo<void> {
  const MyApp({List<_i17.PageRouteInfo>? children})
      : super(
          MyApp.name,
          initialChildren: children,
        );

  static const String name = 'MyApp';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i7.RegisterPage]
class RegisterRoute extends _i17.PageRouteInfo<void> {
  const RegisterRoute({List<_i17.PageRouteInfo>? children})
      : super(
          RegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i8.SupplierDetailPage]
class SupplierDetailRoute extends _i17.PageRouteInfo<SupplierDetailRouteArgs> {
  SupplierDetailRoute({
    _i19.Key? key,
    Map<String, dynamic>? productData,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          SupplierDetailRoute.name,
          args: SupplierDetailRouteArgs(
            key: key,
            productData: productData,
          ),
          initialChildren: children,
        );

  static const String name = 'SupplierDetailRoute';

  static const _i17.PageInfo<SupplierDetailRouteArgs> page =
      _i17.PageInfo<SupplierDetailRouteArgs>(name);
}

class SupplierDetailRouteArgs {
  const SupplierDetailRouteArgs({
    this.key,
    this.productData,
  });

  final _i19.Key? key;

  final Map<String, dynamic>? productData;

  @override
  String toString() {
    return 'SupplierDetailRouteArgs{key: $key, productData: $productData}';
  }
}

/// generated route for
/// [_i9.SupplierInventoryDetailsPage]
class SupplierInventoryDetailsRoute
    extends _i17.PageRouteInfo<SupplierInventoryDetailsRouteArgs> {
  SupplierInventoryDetailsRoute({
    _i18.Key? key,
    required Map<String, dynamic> inventory,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          SupplierInventoryDetailsRoute.name,
          args: SupplierInventoryDetailsRouteArgs(
            key: key,
            inventory: inventory,
          ),
          initialChildren: children,
        );

  static const String name = 'SupplierInventoryDetailsRoute';

  static const _i17.PageInfo<SupplierInventoryDetailsRouteArgs> page =
      _i17.PageInfo<SupplierInventoryDetailsRouteArgs>(name);
}

class SupplierInventoryDetailsRouteArgs {
  const SupplierInventoryDetailsRouteArgs({
    this.key,
    required this.inventory,
  });

  final _i18.Key? key;

  final Map<String, dynamic> inventory;

  @override
  String toString() {
    return 'SupplierInventoryDetailsRouteArgs{key: $key, inventory: $inventory}';
  }
}

/// generated route for
/// [_i10.SupplierPage]
class SupplierRoute extends _i17.PageRouteInfo<void> {
  const SupplierRoute({List<_i17.PageRouteInfo>? children})
      : super(
          SupplierRoute.name,
          initialChildren: children,
        );

  static const String name = 'SupplierRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i11.SupplierProductDetailPage]
class SupplierProductDetailRoute
    extends _i17.PageRouteInfo<SupplierProductDetailRouteArgs> {
  SupplierProductDetailRoute({
    _i18.Key? key,
    Map<String, dynamic>? productData,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          SupplierProductDetailRoute.name,
          args: SupplierProductDetailRouteArgs(
            key: key,
            productData: productData,
          ),
          initialChildren: children,
        );

  static const String name = 'SupplierProductDetailRoute';

  static const _i17.PageInfo<SupplierProductDetailRouteArgs> page =
      _i17.PageInfo<SupplierProductDetailRouteArgs>(name);
}

class SupplierProductDetailRouteArgs {
  const SupplierProductDetailRouteArgs({
    this.key,
    this.productData,
  });

  final _i18.Key? key;

  final Map<String, dynamic>? productData;

  @override
  String toString() {
    return 'SupplierProductDetailRouteArgs{key: $key, productData: $productData}';
  }
}

/// generated route for
/// [_i12.SupplierProductsListPage]
class SupplierProductsListRoute
    extends _i17.PageRouteInfo<SupplierProductsListRouteArgs> {
  SupplierProductsListRoute({
    _i18.Key? key,
    required Map<String, dynamic> inventory,
    required List<Map<String, dynamic>> products,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          SupplierProductsListRoute.name,
          args: SupplierProductsListRouteArgs(
            key: key,
            inventory: inventory,
            products: products,
          ),
          initialChildren: children,
        );

  static const String name = 'SupplierProductsListRoute';

  static const _i17.PageInfo<SupplierProductsListRouteArgs> page =
      _i17.PageInfo<SupplierProductsListRouteArgs>(name);
}

class SupplierProductsListRouteArgs {
  const SupplierProductsListRouteArgs({
    this.key,
    required this.inventory,
    required this.products,
  });

  final _i18.Key? key;

  final Map<String, dynamic> inventory;

  final List<Map<String, dynamic>> products;

  @override
  String toString() {
    return 'SupplierProductsListRouteArgs{key: $key, inventory: $inventory, products: $products}';
  }
}

/// generated route for
/// [_i13.SupplierProductsPage]
class SupplierProductsRoute
    extends _i17.PageRouteInfo<SupplierProductsRouteArgs> {
  SupplierProductsRoute({
    _i18.Key? key,
    required List<Map<String, dynamic>> inventory,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          SupplierProductsRoute.name,
          args: SupplierProductsRouteArgs(
            key: key,
            inventory: inventory,
          ),
          initialChildren: children,
        );

  static const String name = 'SupplierProductsRoute';

  static const _i17.PageInfo<SupplierProductsRouteArgs> page =
      _i17.PageInfo<SupplierProductsRouteArgs>(name);
}

class SupplierProductsRouteArgs {
  const SupplierProductsRouteArgs({
    this.key,
    required this.inventory,
  });

  final _i18.Key? key;

  final List<Map<String, dynamic>> inventory;

  @override
  String toString() {
    return 'SupplierProductsRouteArgs{key: $key, inventory: $inventory}';
  }
}

/// generated route for
/// [_i14.SupplierSearchProductPage]
class SupplierSearchProductRoute extends _i17.PageRouteInfo<void> {
  const SupplierSearchProductRoute({List<_i17.PageRouteInfo>? children})
      : super(
          SupplierSearchProductRoute.name,
          initialChildren: children,
        );

  static const String name = 'SupplierSearchProductRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i15.UserDetailsScreen]
class UserDetailsRoute extends _i17.PageRouteInfo<UserDetailsRouteArgs> {
  UserDetailsRoute({
    _i18.Key? key,
    required Map<String, dynamic> user,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          UserDetailsRoute.name,
          args: UserDetailsRouteArgs(
            key: key,
            user: user,
          ),
          initialChildren: children,
        );

  static const String name = 'UserDetailsRoute';

  static const _i17.PageInfo<UserDetailsRouteArgs> page =
      _i17.PageInfo<UserDetailsRouteArgs>(name);
}

class UserDetailsRouteArgs {
  const UserDetailsRouteArgs({
    this.key,
    required this.user,
  });

  final _i18.Key? key;

  final Map<String, dynamic> user;

  @override
  String toString() {
    return 'UserDetailsRouteArgs{key: $key, user: $user}';
  }
}

/// generated route for
/// [_i16.UserListScreen]
class UserListRoute extends _i17.PageRouteInfo<void> {
  const UserListRoute({List<_i17.PageRouteInfo>? children})
      : super(
          UserListRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserListRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}
