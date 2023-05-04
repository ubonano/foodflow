import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';

import '../controllers/table_controller.dart';
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
}
