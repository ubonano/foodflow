import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';
import 'order_model.dart';
import 'order_repository.dart';

enum OrderSortingOption { time, tableNumber, waiterName }

class ServiceOrderController {
  final OrderRepository _serviceOrderRepository;
  final BehaviorSubject<OrderSortingOption> _sortingOptionsSubject;
  final Logger _logger = Logger('ServiceOrderController');

  ServiceOrderController({required orderRepository})
      : _serviceOrderRepository = orderRepository,
        _sortingOptionsSubject =
            BehaviorSubject<OrderSortingOption>.seeded(
                OrderSortingOption.time) {
    _logger.info('ServiceOrderController created.');
  }

  void updateSortingOption(OrderSortingOption sortingOption) {
    _logger.info('Updating sorting option to: $sortingOption');
    _sortingOptionsSubject.add(sortingOption);
  }

  Stream<List<ServiceOrder>> getOrdersStream() {
    _logger.info('Fetching orders stream.');
    return Rx.combineLatest2<List<ServiceOrder>, OrderSortingOption,
            List<ServiceOrder>>(_serviceOrderRepository.getOrdersStream(),
        _sortingOptionsSubject.stream, _sortOrders);
  }

  List<ServiceOrder> _sortOrders(
      List<ServiceOrder> orders, OrderSortingOption sortingOption) {
    _logger.info('Sorting orders by: $sortingOption');
    List<ServiceOrder> sortedOrders = List<ServiceOrder>.from(orders);
    switch (sortingOption) {
      case OrderSortingOption.tableNumber:
        sortedOrders.sort((a, b) => a.tableNumber.compareTo(b.tableNumber));
        break;
      case OrderSortingOption.waiterName:
        sortedOrders.sort((a, b) => a.waiterName.compareTo(b.waiterName));
        break;
      case OrderSortingOption.time:
      default:
        sortedOrders.sort((a, b) => b.time.compareTo(a.time));
    }
    return sortedOrders;
  }

  Future<void> createOrder(ServiceOrder order) async {
    _logger.info('Creating new order: ${order.toMap()}');
    await _serviceOrderRepository.createOrder(order);
  }

  void dispose() {
    _logger.info('Closing ServiceOrderController and releasing resources.');
    _sortingOptionsSubject.close();
  }
}