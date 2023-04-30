import 'package:get_it/get_it.dart';
import '../order/service_order_controller.dart';
import '../order/service_order_repository.dart';

GetIt getIt = GetIt.instance;

void setupGetIt() {
  getIt.registerLazySingleton<ServiceOrderRepository>(
      () => ServiceOrderRepository());
  getIt.registerLazySingleton<ServiceOrderController>(
    () => ServiceOrderController(
      orderRepository: getIt<ServiceOrderRepository>(),
    ),
  );
}
