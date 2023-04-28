import './order_model.dart';
import 'order_repository.dart';

class OrderService {
  final OrderRepository _repository;

  OrderService({required OrderRepository repository})
      : _repository = repository;

  Stream<List<OrderModel>> getOpenOrders() => _repository.getOpenOrders();
}
