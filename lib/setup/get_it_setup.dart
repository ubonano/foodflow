import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

import '../controllers/order_controller.dart';
import '../controllers/table_controller.dart';
import '../interfaces/order_repository.dart';
import '../repositories/order_firestore_repository.dart';
import '../repositories/table_repository.dart';

GetIt getIt = GetIt.instance;

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

void setupGetIt() {
  getIt.registerLazySingleton<TableRepository>(
    () => TableRepository(),
  );
  getIt.registerLazySingleton<TableController>(
    () => TableController(),
  );
  getIt.registerSingleton<OrderRepository>(OrderFirestoreRepository());
  getIt.registerSingleton<OrderController>(OrderController());
}
