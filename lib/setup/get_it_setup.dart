import 'package:get_it/get_it.dart';
import '../order/order_repository.dart';
import '../order/order_service.dart';

GetIt getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton<OrderRepository>(() => OrderRepository());
  getIt.registerLazySingleton<OrderService>(
    () => OrderService(
      repository: getIt<OrderRepository>(),
    ),
  );
}
