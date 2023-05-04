// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;
import 'package:foodflow/models/table.dart' as _i5;
import 'package:foodflow/ui/screens/table_edit_screen.dart' as _i2;
import 'package:foodflow/ui/screens/table_list_screen.dart' as _i1;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    TableListRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.TableListScreen(),
      );
    },
    TableEditRoute.name: (routeData) {
      final args = routeData.argsAs<TableEditRouteArgs>(
          orElse: () => const TableEditRouteArgs());
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.TableEditScreen(
          key: args.key,
          table: args.table,
        ),
      );
    },
  };
}

/// generated route for
/// [_i1.TableListScreen]
class TableListRoute extends _i3.PageRouteInfo<void> {
  const TableListRoute({List<_i3.PageRouteInfo>? children})
      : super(
          TableListRoute.name,
          initialChildren: children,
        );

  static const String name = 'TableListRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.TableEditScreen]
class TableEditRoute extends _i3.PageRouteInfo<TableEditRouteArgs> {
  TableEditRoute({
    _i4.Key? key,
    _i5.TableModel? table,
    List<_i3.PageRouteInfo>? children,
  }) : super(
          TableEditRoute.name,
          args: TableEditRouteArgs(
            key: key,
            table: table,
          ),
          initialChildren: children,
        );

  static const String name = 'TableEditRoute';

  static const _i3.PageInfo<TableEditRouteArgs> page =
      _i3.PageInfo<TableEditRouteArgs>(name);
}

class TableEditRouteArgs {
  const TableEditRouteArgs({
    this.key,
    this.table,
  });

  final _i4.Key? key;

  final _i5.TableModel? table;

  @override
  String toString() {
    return 'TableEditRouteArgs{key: $key, table: $table}';
  }
}
