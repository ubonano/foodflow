import 'package:flutter/material.dart';
import 'package:foodflow/setup/get_it_setup.dart';
import '../../../widgets/app_form_fields.dart';
import '../../order_controller.dart';
import '../../order_model.dart';

class OrderCreationDialog extends StatefulWidget {
  const OrderCreationDialog({Key? key}) : super(key: key);

  @override
  _OrderCreationDialogState createState() => _OrderCreationDialogState();
}

class _OrderCreationDialogState extends State<OrderCreationDialog> {
  final _formKey = GlobalKey<FormState>();
  final _orderController = getIt<OrderController>();
  bool _isCreatingOrder = false;

  final _tableNumberController = TextEditingController();
  final _waiterNameController = TextEditingController();
  final _numberOfGuestsController = TextEditingController();

  Future<ServiceOrder?>? _createOrderFuture;

  @override
  void dispose() {
    _tableNumberController.dispose();
    _waiterNameController.dispose();
    _numberOfGuestsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Nueva orden'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Form(
              key: _formKey,
              child: Column(
                children: [
                  AppFormFields.tableNumber(_tableNumberController),
                  AppFormFields.waiterName(_waiterNameController),
                  AppFormFields.numberOfGuests(_numberOfGuestsController),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: _createOrderFuture == null
              ? () {
                  Navigator.of(context).pop();
                }
              : null,
          child: const Text('Cancelar'),
        ),
        FutureBuilder<ServiceOrder?>(
          future: _createOrderFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else {
              return ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _createOrderFuture = _createOrder();
                    });
                  }
                },
                child: const Text('Crear'),
              );
            }
          },
        ),
      ],
    );
  }

  Future<ServiceOrder?> _createOrder() async {
    int tableNumber = int.parse(_tableNumberController.text);
    bool isTableTaken = await _orderController.isTableNumberTaken(tableNumber);
    if (isTableTaken) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('La mesa número $tableNumber ya tiene una orden.'),
        ),
      );
      return null;
    } else {
      final newOrder = ServiceOrder.createNew(
        tableNumber: tableNumber,
        waiterName: _waiterNameController.text,
        numberOfGuests: int.parse(_numberOfGuestsController.text),
      );
      await _orderController.createOrder(newOrder);
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Se ha creado una nueva orden para la mesa número $tableNumber.'),
        ),
      );
      return newOrder;
    }
  }
}
