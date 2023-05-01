import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:logging/logging.dart';
import '../order/order_controller.dart';
import '../order/order_repository.dart';

GetIt getIt = GetIt.instance;

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

void setupGetIt() {
  getIt.registerLazySingleton<OrderRepository>(
    () => OrderRepository(
      firestore: _firestore,
      logger: Logger('ServiceOrderRepository'),
    ),
  );
  getIt.registerLazySingleton<OrderController>(
    () => OrderController(
      orderRepository: getIt<OrderRepository>(),
    ),
  );
}
