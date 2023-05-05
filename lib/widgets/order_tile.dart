import 'package:flutter/material.dart';

import '../models/order.dart';

class OrderTile extends StatelessWidget {
  final OrderModel order;
  final VoidCallback onTap;

  const OrderTile({super.key, required this.order, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('Table: ${order.tableId}'),
      subtitle: Text('Waiter: ${order.waiter}\nGuests: ${order.numGuests}'),
      trailing: Text(order.elapsedTime),
      isThreeLine: true,
      tileColor: order.status.color,
      onTap: onTap,
    );
  }
}
