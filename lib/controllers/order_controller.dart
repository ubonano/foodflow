import 'package:rxdart/rxdart.dart';
import '../interfaces/order_repository.dart';
import '../models/order.dart';
import '../setup/get_it_setup.dart';

class OrderController {
  final _repository = getIt<OrderRepository>();
  late final BehaviorSubject<List<OrderModel>> _ordersSubject;

  OrderController() {
    _ordersSubject = BehaviorSubject<List<OrderModel>>.seeded([]);
    _repository.ordersStream().listen((orders) {
      _ordersSubject.add(orders);
    });
  }

  Stream<List<OrderModel>> get ordersStream => _ordersSubject.stream;

  Future<void> addOrder(OrderModel order) async {
    try {
      await _repository.addOrder(order);
    } catch (e) {
      print('Error adding order: $e');
    }
  }

  Future<void> updateOrder(OrderModel order) async {
    try {
      await _repository.updateOrder(order);
    } catch (e) {
      print('Error updating order: $e');
    }
  }

  Future<void> deleteOrder(String orderId) async {
    try {
      await _repository.deleteOrder(orderId);
    } catch (e) {
      print('Error deleting order: $e');
    }
  }

  Future<void> setOrderStatus(String orderId, OrderStatus status) async {
    try {
      await _repository.setOrderStatus(orderId, status);
    } catch (e) {
      print('Error setting order status: $e');
    }
  }

  void dispose() {
    _ordersSubject.close();
  }
}
