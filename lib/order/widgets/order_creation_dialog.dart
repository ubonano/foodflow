import 'package:flutter/material.dart';
import '../order_model.dart';

class OrderCreationDialog extends StatefulWidget {
  const OrderCreationDialog({Key? key}) : super(key: key);

  @override
  _OrderCreationDialogState createState() => _OrderCreationDialogState();
}

class _OrderCreationDialogState extends State<OrderCreationDialog> {
  int? tableNumber;
  String? waiterName;
  int? numberOfGuests;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nueva orden'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                labelText: 'Número de mesa',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                tableNumber = int.tryParse(value);
              },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Nombre del mesero',
              ),
              onChanged: (value) {
                waiterName = value;
              },
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Cantidad de comensales',
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                numberOfGuests = int.tryParse(value);
              },
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Crear'),
          onPressed: () {
            if (tableNumber != null &&
                waiterName != null &&
                numberOfGuests != null) {
              final newOrder = ServiceOrder.createNew(
                tableNumber: tableNumber!,
                waiterName: waiterName!,
                numberOfGuests: numberOfGuests!,
              );
              Navigator.of(context).pop(newOrder);
            }
          },
        ),
      ],
    );
  }
}
