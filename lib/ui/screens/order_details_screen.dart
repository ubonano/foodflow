import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import '../../controllers/order_controller.dart';
import '../../models/order.dart';
import '../../setup/get_it_setup.dart';
import '../../utils/pdf_generator.dart';
import 'package:path_provider/path_provider.dart';

import '../../widgets/order_item_editor.dart';

@RoutePage()
class OrderDetailsScreen extends StatefulWidget {
  final OrderModel order;

  const OrderDetailsScreen({required this.order});

  @override
  _OrderDetailsScreenState createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final _orderController = getIt<OrderController>();
  final _formKey = GlobalKey<FormState>();
  String _tableId = '';
  String _waiter = '';
  int _numGuests = 1;
  List<OrderItem> _items = [];

  @override
  void initState() {
    super.initState();
    _tableId = widget.order.tableId;
    _waiter = widget.order.waiter;
    _numGuests = widget.order.numGuests;
    _items = widget.order.items;
  }

  @override
  Widget build(BuildContext context) {
    final router = AutoRouter.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed:
                  widget.order.status == OrderStatus.open ? _deleteOrder : null,
            ),
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: widget.order.status == OrderStatus.open
                  ? () => _changeOrderStatus(OrderStatus.checkout)
                  : null,
            ),
            IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: widget.order.status == OrderStatus.checkout
                  ? () => _changeOrderStatus(OrderStatus.open)
                  : null,
            ),
            IconButton(
              icon: const Icon(Icons.file_download),
              onPressed: widget.order.status == OrderStatus.checkout
                  ? _generateAndSavePdf
                  : null,
            ),
            IconButton(
              icon: const Icon(Icons.check_circle),
              onPressed: widget.order.status == OrderStatus.checkout
                  ? () => _changeOrderStatus(OrderStatus.closed)
                  : null,
            ),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Table ID'),
              initialValue: _tableId,
              readOnly: widget.order.status != OrderStatus.open,
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
              initialValue: _waiter,
              readOnly: widget.order.status != OrderStatus.open,
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
              initialValue: '$_numGuests',
              keyboardType: TextInputType.number,
              readOnly: widget.order.status != OrderStatus.open,
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
      floatingActionButton: widget.order.status == OrderStatus.open
          ? FloatingActionButton(
              child: const Icon(Icons.check),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  final updatedOrder = OrderModel(
                    id: widget.order.id,
                    createdAt: widget.order.createdAt,
                    tableId: _tableId,
                    waiter: _waiter,
                    numGuests: _numGuests,
                    items: _items,
                    status: widget.order.status,
                  );
                  _orderController.updateOrder(updatedOrder);
                  router.pop();
                }
              },
            )
          : null,
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

  Future<void> _generateAndSavePdf() async {
    final doc = await generatePdf(widget.order);
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/${widget.order.id}.pdf');
    await file.writeAsBytes(await doc.save());
    // TODO: Share or open the PDF file
  }

  Future<void> _changeOrderStatus(OrderStatus status) async {
    final updatedOrder = widget.order.copyWith(status: status);
    _orderController.updateOrder(updatedOrder);
  }

  Future<void> _deleteOrder() async {
    final router = AutoRouter.of(context);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Order'),
          content: const Text('Are you sure you want to delete this order?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => router.pop(false),
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () => router.pop(true),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      _orderController.deleteOrder(widget.order.id);
      router.pop();
    }
  }
}
