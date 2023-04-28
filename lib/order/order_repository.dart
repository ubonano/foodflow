import 'package:cloud_firestore/cloud_firestore.dart';
import 'order_model.dart';

class OrderRepository {
  final CollectionReference _ordersCollection =
      FirebaseFirestore.instance.collection('orders');

  Stream<List<OrderModel>> getOpenOrders() {
    return _ordersCollection.where('isOpen', isEqualTo: true).snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
  }
}
