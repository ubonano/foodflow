import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';
import 'order_model.dart';

class OrderRepository {
  final FirebaseFirestore _firestore;
  final Logger _logger;
  final String _collectionName = 'orders';

  OrderRepository(
      {required FirebaseFirestore firestore, required Logger logger})
      : _firestore = firestore,
        _logger = logger;

  Stream<List<ServiceOrder>> getOrdersStream() {
    _logger.info('Fetching orders stream from Firestore.');
    return _firestore
        .collection(_collectionName)
        .snapshots()
        .map(_snapshotToOrderList);
  }

  List<ServiceOrder> _snapshotToOrderList(QuerySnapshot snapshot) {
    _logger.info('Converting snapshot to order list.');
    return snapshot.docs
        .map((doc) => ServiceOrder.fromDocumentSnapshot(doc))
        .toList();
  }

  Future<void> createOrder(ServiceOrder order) async {
    _logger.info('Creating new order: ${order.toMap()}');
    try {
      await _firestore.collection(_collectionName).add(order.toMap());
    } catch (e) {
      _logger.severe('Error creating the order: $e');
      throw e;
    }
  }
}
