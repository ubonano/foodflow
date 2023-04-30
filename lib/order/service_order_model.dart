import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceOrder {
  final String id;
  final int tableNumber;
  final DateTime time;
  final String waiterName;
  final int numberOfGuests;

  ServiceOrder({
    required this.id,
    required this.tableNumber,
    required this.time,
    required this.waiterName,
    required this.numberOfGuests,
  });

  static ServiceOrder createNew({
    required int tableNumber,
    required String waiterName,
    required int numberOfGuests,
  }) {
    return ServiceOrder(
      id: '', // El ID se asignará al guardar en la base de datos
      tableNumber: tableNumber,
      time: DateTime.now(),
      waiterName: waiterName,
      numberOfGuests: numberOfGuests,
    );
  }

  factory ServiceOrder.fromDocumentSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ServiceOrder(
      id: doc.id,
      tableNumber: data['tableNumber'] ?? 0,
      time: (data['time'] as Timestamp).toDate(),
      waiterName: data['waiterName'] ?? '',
      numberOfGuests: data['numberOfGuests'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tableNumber': tableNumber,
      'time': time,
      'waiterName': waiterName,
      'numberOfGuests': numberOfGuests,
    };
  }
}
