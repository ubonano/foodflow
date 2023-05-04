import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:foodflow/setup/router.gr.dart';

import '../../controllers/table_controller.dart';
import '../../models/table.dart';
import '../../setup/get_it_setup.dart';
import 'table_edit_screen.dart';

@RoutePage()
class TableListScreen extends StatefulWidget {
  const TableListScreen({super.key});

  @override
  _TableListScreenState createState() => _TableListScreenState();
}

class _TableListScreenState extends State<TableListScreen> {
  final _tableController = getIt<TableController>();
  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tables'),
      ),
      body: StreamBuilder<List<TableModel>>(
        stream: _tableController.tablesStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final tables = snapshot.data!
            ..sort((a, b) => a.identifier.compareTo(b.identifier));
          return ListView.builder(
            itemCount: tables.length,
            itemBuilder: (context, index) {
              final table = tables[index];
              return ListTile(
                title: Text(table.identifier),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => router.push(TableEditRoute())),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        final shouldDelete = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete table'),
                            content: const Text(
                                'Are you sure you want to delete this table?'),
                            actions: [
                              TextButton(
                                child: const Text('Cancel'),
                                onPressed: () => router.pop(),

                                // Navigator.of(context).pop(false),
                              ),
                              TextButton(
                                child: const Text('Delete'),
                                onPressed: () => router.pop(),
                                // Navigator.of(context).pop(true),
                              ),
                            ],
                          ),
                        );

                        if (shouldDelete == true) {
                          await _tableController.deleteTable(table.id);
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TableEditScreen(),
            ),
          );
        },
      ),
    );
  }
}
