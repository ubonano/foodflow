import 'package:flutter/material.dart';
import '../../widgets/app_form_fields.dart';
import '../order_model.dart';

class OrderCreationDialog extends StatefulWidget {
  const OrderCreationDialog({Key? key}) : super(key: key);

  @override
  _OrderCreationDialogState createState() => _OrderCreationDialogState();
}

class _OrderCreationDialogState extends State<OrderCreationDialog> {
  final _formKey = GlobalKey<FormState>();

  final _tableNumberController = TextEditingController();
  final _waiterNameController = TextEditingController();
  final _numberOfGuestsController = TextEditingController();

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
          child: const Text('Cancelar'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Crear'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final newOrder = ServiceOrder.createNew(
                tableNumber: int.parse(_tableNumberController.text),
                waiterName: _waiterNameController.text,
                numberOfGuests: int.parse(_numberOfGuestsController.text),
              );
              Navigator.of(context).pop(newOrder);
            }
          },
        ),
      ],
    );
  }
}
