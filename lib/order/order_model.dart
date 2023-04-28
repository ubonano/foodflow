import 'package:cloud_firestore/cloud_firestore.dart';

class OrderModel {
  final String id;
  final int tableNumber;
  final DateTime startTime;
  final String waiterName;
  final int numberOfGuests;
  final bool isOpen;

  OrderModel({
    required this.id,
    required this.tableNumber,
    required this.startTime,
    required this.waiterName,
    required this.numberOfGuests,
    required this.isOpen,
  });

  // Método fromSnapshot
  factory OrderModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return OrderModel(
      id: snapshot.id,
      tableNumber: data['tableNumber'] ?? 0,
      startTime: (data['startTime'] as Timestamp).toDate(),
      waiterName: data['waiterName'] ?? '',
      numberOfGuests: data['numberOfGuests'] ?? 0,
      isOpen: data['isOpen'] ?? true,
    );
  }
}
