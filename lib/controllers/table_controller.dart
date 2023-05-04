import 'package:foodflow/setup/get_it_setup.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';

import '../models/table.dart';
import '../repositories/table_repository.dart';

class TableController {
  final _logger = Logger('TableController');
  final _tableRepository = getIt<TableRepository>();

  TableController() {
    _logger.info('TableController created');
    _loadTables();
  }

  final _tablesSubject = BehaviorSubject<List<TableModel>>();
  Stream<List<TableModel>> get tablesStream => _tablesSubject.stream;

  void _loadTables() {
    _logger.info('Loading tables');
    _tableRepository.get().listen((tables) {
      _tablesSubject.add(tables);
    });
  }

  Future<void> addTable(String identifier) async {
    _logger.info('Adding table');
    if (identifier.isEmpty) {
      throw ArgumentError('Table identifier cannot be empty');
    }

    final exists = await _tableRepository.exists(identifier);
    if (exists) {
      throw ArgumentError('Table identifier must be unique');
    }

    try {
      final newTable = TableModel(id: '', identifier: identifier);
      await _tableRepository.add(newTable);
      _logger.info('Table added');
    } catch (e) {
      _logger.severe('Error adding table: $e');
      rethrow;
    }
  }

  Future<void> updateTable(TableModel table) async {
    _logger.info('Updating table');
    try {
      await _tableRepository.update(table);
      _logger.info('Table updated');
    } catch (e) {
      _logger.severe('Error updating table: $e');
      rethrow;
    }
  }

  Future<void> deleteTable(String id) async {
    _logger.info('Deleting table');
    try {
      await _tableRepository.delete(id);
      _logger.info('Table deleted');
    } catch (e) {
      _logger.severe('Error deleting table: $e');
      rethrow;
    }
  }

  void dispose() {
    _tablesSubject.close();
  }
}
