import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import '../order/service_order_controller.dart';
import '../order/service_order_repository.dart';

GetIt getIt = GetIt.instance;

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

void setupGetIt() {
  getIt.registerLazySingleton<ServiceOrderRepository>(
    () => ServiceOrderRepository(
      firestore: _firestore,
      logger: Logger('ServiceOrderRepository'),
    ),
  );
  getIt.registerLazySingleton<ServiceOrderController>(
    () => ServiceOrderController(
      orderRepository: getIt<ServiceOrderRepository>(),
    ),
  );
}
