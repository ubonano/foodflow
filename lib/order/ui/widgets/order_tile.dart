import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../order_model.dart';

class OrderTile extends StatelessWidget {
  final ServiceOrder order;

  const OrderTile({required this.order, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final elapsedTime = DateTime.now().difference(order.time);
    final elapsedTimeInMinutes = elapsedTime.inMinutes;
    return AspectRatio(
      aspectRatio: 1.5, // Mantiene la relación de aspecto de las tarjetas
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Mesa: ${order.tableNumber}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              Text('Hora: ${DateFormat('hh:mm a').format(order.time)}'),
              Text('Tiempo transcurrido: $elapsedTimeInMinutes minutos'),
              Text('Mesero: ${order.waiterName}'),
              Text('Comensales: ${order.numberOfGuests}'),
            ],
          ),
        ),
      ),
    );
  }
}
