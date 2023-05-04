import 'package:flutter/material.dart';
import 'package:foodflow/setup/get_it_setup.dart';
import 'package:logging/logging.dart';
import '../../controllers/table_controller.dart';
import '../../models/table.dart';

class TableEditScreen extends StatefulWidget {
  final TableModel? table;

  const TableEditScreen({super.key, this.table});

  @override
  _TableEditScreenState createState() => _TableEditScreenState();
}

class _TableEditScreenState extends State<TableEditScreen> {
  final _formKey = GlobalKey<FormState>();

  final _tableController = getIt<TableController>();
  final _logger = Logger('TableEditScreen');

  late TextEditingController _identifierController;

  @override
  void initState() {
    super.initState();
    _identifierController =
        TextEditingController(text: widget.table?.identifier ?? '');
  }

  @override
  Widget build(BuildContext context) {
    _logger.info('Building TableEditScreen');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.table == null ? 'Create table' : 'Edit table'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _identifierController,
                decoration: const InputDecoration(labelText: 'Identifier'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'The identifier cannot be empty';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Save'),
                onPressed: () async {
                  try {
                    if (_formKey.currentState!.validate()) {
                      if (widget.table == null) {
                        _logger.info('Adding new table');
                        await _tableController
                            .addTable(_identifierController.text);
                      } else {
                        _logger.info('Updating existing table');
                        await _tableController.updateTable(TableModel(
                          id: widget.table!.id,
                          identifier: _identifierController.text,
                        ));
                      }
                      Navigator.of(context).pop();
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          e.toString(),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _identifierController.dispose();
    super.dispose();
  }
}
