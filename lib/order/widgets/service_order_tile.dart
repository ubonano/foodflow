import 'package:flutter/material.dart';
import '../serrvice_order_model.dart';

class ServiceOrderTile extends StatelessWidget {
  final ServiceOrder order;

  const ServiceOrderTile({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Mesa: ${order.tableNumber}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('Mesero: ${order.waiterName}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            Text('Hora: ${order.time.hour}:${order.time.minute}',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            Text(
                'Tiempo transcurrido: ${DateTime.now().difference(order.time).inMinutes} minutos',
                style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 4),
            Text('Comensales: ${order.numberOfGuests}',
                style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
