import 'package:cloud_firestore/cloud_firestore.dart';
import '../interfaces/order_repository.dart';
import '../models/order.dart';

class OrderFirestoreRepository implements OrderRepository {
  final _ordersCollection = FirebaseFirestore.instance.collection('orders');

  @override
  Stream<List<OrderModel>> ordersStream() {
    return _ordersCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => OrderModel.fromDocument(doc)).toList();
    });
  }

  @override
  Future<void> addOrder(OrderModel order) {
    return _ordersCollection.add(order.toDocument());
  }

  @override
  Future<void> updateOrder(OrderModel order) {
    return _ordersCollection.doc(order.id).update(order.toDocument());
  }

  @override
  Future<void> deleteOrder(String orderId) {
    return _ordersCollection.doc(orderId).delete();
  }

  @override
  Future<void> setOrderStatus(String orderId, OrderStatus status) {
    return _ordersCollection.doc(orderId).update({'status': status.index});
  }
}
