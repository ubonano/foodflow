import 'package:cloud_firestore/cloud_firestore.dart';

import '../order/service_order_model.dart';

void createServiceOrders() async {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<ServiceOrder> serviceOrders = [
    ServiceOrder(
      id: '', // Firestore generará un ID automáticamente
      tableNumber: 1,
      time: DateTime.now(),
      waiterName: 'John',
      numberOfGuests: 3,
    ),
    ServiceOrder(
      id: '',
      tableNumber: 2,
      time: DateTime.now(),
      waiterName: 'Alice',
      numberOfGuests: 4,
    ),
    ServiceOrder(
      id: '',
      tableNumber: 3,
      time: DateTime.now(),
      waiterName: 'Tom',
      numberOfGuests: 2,
    ),
    ServiceOrder(
      id: '',
      tableNumber: 4,
      time: DateTime.now(),
      waiterName: 'Emma',
      numberOfGuests: 5,
    ),
    ServiceOrder(
      id: '',
      tableNumber: 5,
      time: DateTime.now(),
      waiterName: 'Mike',
      numberOfGuests: 1,
    ),
  ];

  for (ServiceOrder serviceOrder in serviceOrders) {
    await _firestore.collection('serviceOrders').add({
      'tableNumber': serviceOrder.tableNumber,
      'time': serviceOrder.time,
      'waiterName': serviceOrder.waiterName,
      'numberOfGuests': serviceOrder.numberOfGuests,
    });
  }
}
