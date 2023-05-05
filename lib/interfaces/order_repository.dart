import '../models/order.dart';

abstract class OrderRepository {
  Stream<List<OrderModel>> ordersStream();
  Future<void> addOrder(OrderModel order);
  Future<void> updateOrder(OrderModel order);
  Future<void> deleteOrder(String orderId);
  Future<void> setOrderStatus(String orderId, OrderStatus status);
}
