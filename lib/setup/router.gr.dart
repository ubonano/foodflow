// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:flutter/material.dart' as _i8;
import 'package:foodflow/models/order.dart' as _i7;
import 'package:foodflow/models/table.dart' as _i9;
import 'package:foodflow/ui/screens/order_add_sreen.dart' as _i5;
import 'package:foodflow/ui/screens/order_details_screen.dart' as _i1;
import 'package:foodflow/ui/screens/order_list_screen.dart' as _i3;
import 'package:foodflow/ui/screens/table_edit_screen.dart' as _i4;
import 'package:foodflow/ui/screens/table_list_screen.dart' as _i2;

abstract class $AppRouter extends _i6.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i6.PageFactory> pagesMap = {
    OrderDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<OrderDetailsRouteArgs>();
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i1.OrderDetailsScreen(order: args.order),
      );
    },
    TableListRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.TableListScreen(),
      );
    },
    OrderListRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i3.OrderListScreen(),
      );
    },
    TableEditRoute.name: (routeData) {
      final args = routeData.argsAs<TableEditRouteArgs>(
          orElse: () => const TableEditRouteArgs());
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.TableEditScreen(
          key: args.key,
          table: args.table,
        ),
      );
    },
    OrderAddRoute.name: (routeData) {
      return _i6.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.OrderAddScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.OrderDetailsScreen]
class OrderDetailsRoute extends _i6.PageRouteInfo<OrderDetailsRouteArgs> {
  OrderDetailsRoute({
    required _i7.OrderModel order,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          OrderDetailsRoute.name,
          args: OrderDetailsRouteArgs(order: order),
          initialChildren: children,
        );

  static const String name = 'OrderDetailsRoute';

  static const _i6.PageInfo<OrderDetailsRouteArgs> page =
      _i6.PageInfo<OrderDetailsRouteArgs>(name);
}

class OrderDetailsRouteArgs {
  const OrderDetailsRouteArgs({required this.order});

  final _i7.OrderModel order;

  @override
  String toString() {
    return 'OrderDetailsRouteArgs{order: $order}';
  }
}

/// generated route for
/// [_i2.TableListScreen]
class TableListRoute extends _i6.PageRouteInfo<void> {
  const TableListRoute({List<_i6.PageRouteInfo>? children})
      : super(
          TableListRoute.name,
          initialChildren: children,
        );

  static const String name = 'TableListRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i3.OrderListScreen]
class OrderListRoute extends _i6.PageRouteInfo<void> {
  const OrderListRoute({List<_i6.PageRouteInfo>? children})
      : super(
          OrderListRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderListRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}

/// generated route for
/// [_i4.TableEditScreen]
class TableEditRoute extends _i6.PageRouteInfo<TableEditRouteArgs> {
  TableEditRoute({
    _i8.Key? key,
    _i9.TableModel? table,
    List<_i6.PageRouteInfo>? children,
  }) : super(
          TableEditRoute.name,
          args: TableEditRouteArgs(
            key: key,
            table: table,
          ),
          initialChildren: children,
        );

  static const String name = 'TableEditRoute';

  static const _i6.PageInfo<TableEditRouteArgs> page =
      _i6.PageInfo<TableEditRouteArgs>(name);
}

class TableEditRouteArgs {
  const TableEditRouteArgs({
    this.key,
    this.table,
  });

  final _i8.Key? key;

  final _i9.TableModel? table;

  @override
  String toString() {
    return 'TableEditRouteArgs{key: $key, table: $table}';
  }
}

/// generated route for
/// [_i5.OrderAddScreen]
class OrderAddRoute extends _i6.PageRouteInfo<void> {
  const OrderAddRoute({List<_i6.PageRouteInfo>? children})
      : super(
          OrderAddRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderAddRoute';

  static const _i6.PageInfo<void> page = _i6.PageInfo<void>(name);
}
