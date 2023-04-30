import 'package:cloud_firestore/cloud_firestore.dart';
import 'service_order_model.dart';

class ServiceOrderRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<ServiceOrder>> getOrdersStream() {
    return _firestore.collection('serviceOrders').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ServiceOrder.fromDocumentSnapshot(doc);
      }).toList();
    });
  }

  Future<void> createOrder(ServiceOrder order) async {
    try {
      await _firestore.collection('serviceOrders').add(order.toMap());
    } catch (e) {
      print('Error al crear la orden: $e');
      throw e;
    }
  }
}
