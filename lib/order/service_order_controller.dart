import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'service_order_model.dart';
import 'service_order_repository.dart';

enum ServiceOrderSortingOption { time, tableNumber, waiterName }

class ServiceOrderController {
  final ServiceOrderRepository _serviceOrderRepository;
  final BehaviorSubject<ServiceOrderSortingOption> _sortingOptionsSubject;

  ServiceOrderController({required orderRepository})
      : _serviceOrderRepository = orderRepository,
        _sortingOptionsSubject =
            BehaviorSubject<ServiceOrderSortingOption>.seeded(
                ServiceOrderSortingOption.time);

  void updateSortingOption(ServiceOrderSortingOption sortingOption) {
    _sortingOptionsSubject.add(sortingOption);
  }

  Stream<List<ServiceOrder>> getOrdersStream() {
    return Rx.combineLatest2<List<ServiceOrder>, ServiceOrderSortingOption,
            List<ServiceOrder>>(_serviceOrderRepository.getOrdersStream(),
        _sortingOptionsSubject.stream, (orders, sortingOption) {
      switch (sortingOption) {
        case ServiceOrderSortingOption.tableNumber:
          orders.sort((a, b) => a.tableNumber.compareTo(b.tableNumber));
          break;
        case ServiceOrderSortingOption.waiterName:
          orders.sort((a, b) => a.waiterName.compareTo(b.waiterName));
          break;
        default:
          orders.sort((a, b) => b.time.compareTo(a.time)); // Orden descendente
      }
      return orders;
    });
  }

  ServiceOrderSortingOption get currentSortingOption =>
      _sortingOptionsSubject.value;

  set currentSortingOption(ServiceOrderSortingOption value) {
    _sortingOptionsSubject.add(value);
  }

  Future<void> createOrder(ServiceOrder order) async {
    await _serviceOrderRepository.createOrder(order);
  }

  List<ServiceOrder> _sortOrders(
      List<ServiceOrder> orders, ServiceOrderSortingOption sortingOption) {
    List<ServiceOrder> sortedOrders = List<ServiceOrder>.from(orders);
    switch (sortingOption) {
      case ServiceOrderSortingOption.tableNumber:
        sortedOrders.sort((a, b) => a.tableNumber.compareTo(b.tableNumber));
        break;
      case ServiceOrderSortingOption.waiterName:
        sortedOrders.sort((a, b) => a.waiterName.compareTo(b.waiterName));
        break;
      case ServiceOrderSortingOption.time:
      default:
        sortedOrders.sort((a, b) => b.time.compareTo(a.time));
    }
    return sortedOrders;
  }

  void dispose() {
    _sortingOptionsSubject.close();
  }
}
