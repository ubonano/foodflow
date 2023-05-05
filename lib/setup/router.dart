import 'package:auto_route/auto_route.dart';
import 'package:foodflow/setup/router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: TableListRoute.page),
        // AutoRoute(page: TableListRoute.page, initial: true),
        AutoRoute(page: TableEditRoute.page),
        AutoRoute(page: OrderListRoute.page, initial: true),
        AutoRoute(page: OrderAddRoute.page),
        AutoRoute(page: OrderDetailsRoute.page),
      ];
}
