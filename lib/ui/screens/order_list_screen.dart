import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../controllers/order_controller.dart';
import '../../models/order.dart';
import '../../setup/get_it_setup.dart';
import '../../setup/router.gr.dart';
import '../../widgets/order_tile.dart';

@RoutePage()
class OrderListScreen extends StatefulWidget {
  @override
  _OrderListScreenState createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final _orderController = getIt<OrderController>();
  OrderStatus _filterStatus = OrderStatus.all;
  String _sortField = 'createdAt';

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
          ),
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: _showSortDialog,
          ),
        ],
      ),
      body: StreamBuilder<List<OrderModel>>(
        stream: _orderController.ordersStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final orders = _filteredOrders(_sortedOrders(snapshot.data!));
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return OrderTile(
                  order: order,
                  onTap: () => router.push(OrderDetailsRoute(order: order)),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => router.push(const OrderAddRoute()),
        child: const Icon(Icons.add),
      ),
    );
  }

  List<OrderModel> _filteredOrders(List<OrderModel> orders) {
    if (_filterStatus == OrderStatus.all) {
      return orders;
    } else {
      return orders.where((order) => order.status == _filterStatus).toList();
    }
  }

  List<OrderModel> _sortedOrders(List<OrderModel> orders) {
    return orders
      ..sort((a, b) {
        if (_sortField == 'createdAt') {
          return a.createdAt.compareTo(b.createdAt);
        } else if (_sortField == 'tableId') {
          return a.tableId.compareTo(b.tableId);
        } else {
          return a.waiter.compareTo(b.waiter);
        }
      });
  }

  Future<void> _showFilterDialog() async {
    final selectedStatus = await showDialog<OrderStatus>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Filter by status'),
          children: OrderStatus.values.map((status) {
            return SimpleDialogOption(
              child: Text(status.toString().split('.').last),
              onPressed: () {
                Navigator.pop(context, status);
              },
            );
          }).toList(),
        );
      },
    );

    if (selectedStatus != null) {
      setState(() {
        _filterStatus = selectedStatus;
      });
    }
  }

  Future<void> _showSortDialog() async {
    final selectedField = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Sort by'),
          children: [
            SimpleDialogOption(
              child: const Text('Date and Time'),
              onPressed: () {
                Navigator.pop(context, 'createdAt');
              },
            ),
            SimpleDialogOption(
              child: const Text('Table ID'),
              onPressed: () {
                Navigator.pop(context, 'tableId');
              },
            ),
            SimpleDialogOption(
              child: const Text('Waiter'),
              onPressed: () {
                Navigator.pop(context, 'waiter');
              },
            ),
          ],
        );
      },
    );

    if (selectedField != null) {
      setState(() {
        _sortField = selectedField;
      });
    }
  }
}
