import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logging/logging.dart';
import '../models/table.dart';

class TableRepository {
  final _logger = Logger('TableRepository');
  final _tablesCollection = FirebaseFirestore.instance.collection('tables');

  Stream<List<TableModel>> get() {
    _logger.info('Fetching tables from Firestore');
    return _tablesCollection.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => TableModel.fromDocument(doc)).toList());
  }

  Future<bool> exists(String identifier) async {
    final querySnapshot = await _tablesCollection
        .where('identifier', isEqualTo: identifier)
        .get();

    if (querySnapshot.docs.isEmpty) {
      return false;
    }

    return true;
  }

  Future<void> add(TableModel table) async {
    _logger.info('Adding table to Firestore');
    await _tablesCollection.add(table.toDocument());
    _logger.info('Table added to Firestore');
  }

  Future<void> update(TableModel table) async {
    _logger.info('Updating table in Firestore');
    await _tablesCollection.doc(table.id).update(table.toDocument());
    _logger.info('Table updated in Firestore');
  }

  Future<void> delete(String id) async {
    _logger.info('Deleting table from Firestore');
    await _tablesCollection.doc(id).delete();
    _logger.info('Table deleted from Firestore');
  }
}
