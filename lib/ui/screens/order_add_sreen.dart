import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import '../../controllers/order_controller.dart';
import '../../models/order.dart';
import '../../setup/get_it_setup.dart';
import '../../widgets/order_item_editor.dart';

@RoutePage()
class OrderAddScreen extends StatefulWidget {
  const OrderAddScreen({super.key});

  @override
  _OrderAddScreenState createState() => _OrderAddScreenState();
}

class _OrderAddScreenState extends State<OrderAddScreen> {
  final _orderController = getIt<OrderController>();
  final _formKey = GlobalKey<FormState>();
  String _tableId = '';
  String _waiter = '';
  int _numGuests = 1;
  List<OrderItem> _items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Order'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Table ID'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a table ID';
                }
                return null;
              },
              onSaved: (value) => _tableId = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Waiter'),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter a waiter';
                }
                return null;
              },
              onSaved: (value) => _waiter = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Number of Guests'),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty ||
                    int.tryParse(value) == null ||
                    int.parse(value) < 1) {
                  return 'Please enter a valid number of guests';
                }
                return null;
              },
              onSaved: (value) => _numGuests = int.parse(value!),
            ),
            OrderItemEditor(
              items: _items,
              onAddItem: _addItem,
              onRemoveItem: _removeItem,
              onIncrementItem: _incrementItem,
              onDecrementItem: _decrementItem,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.check),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            final order = OrderModel(
              id: '',
              createdAt: DateTime.now(),
              tableId: _tableId,
              waiter: _waiter,
              numGuests: _numGuests,
              items: _items,
              status: OrderStatus.open,
            );
            _orderController.addOrder(order);
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  void _addItem(OrderItem item) {
    setState(() {
      _items.add(item);
    });
  }

  void _removeItem(OrderItem item) {
    setState(() {
      _items.remove(item);
    });
  }

  void _incrementItem(OrderItem item) {
    final index = _items.indexOf(item);
    if (index != -1) {
      setState(() {
        _items[index] = item.copyWith(quantity: item.quantity + 1);
      });
    }
  }

  void _decrementItem(OrderItem item) {
    final index = _items.indexOf(item);
    if (index != -1) {
      if (item.quantity > 1) {
        setState(() {
          _items[index] = item.copyWith(quantity: item.quantity - 1);
        });
      } else {
        _removeItem(item);
      }
    }
  }
}
