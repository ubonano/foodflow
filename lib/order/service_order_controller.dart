import 'service_order_model.dart';
import 'service_order_repository.dart';

enum ServiceOrderSortingOption { time, tableNumber, waiterName }

class ServiceOrderController {
  final ServiceOrderRepository _serviceOrderRepository;

  ServiceOrderController({required orderRepository})
      : _serviceOrderRepository = orderRepository;

  Stream<List<ServiceOrder>> getOrdersStream(
      {required ServiceOrderSortingOption sortingOption}) {
    return _serviceOrderRepository.getOrdersStream().map((orders) {
      switch (sortingOption) {
        case ServiceOrderSortingOption.tableNumber:
          orders.sort((a, b) => a.tableNumber.compareTo(b.tableNumber));
          break;
        case ServiceOrderSortingOption.waiterName:
          orders.sort((a, b) => a.waiterName.compareTo(b.waiterName));
          break;
        default:
          orders.sort((a, b) => a.time.compareTo(b.time));
      }
      return orders;
    });
  }

  Future<void> createOrder(ServiceOrder order) async {
    await _serviceOrderRepository.createOrder(order);
  }
}
