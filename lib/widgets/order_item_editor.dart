import 'package:flutter/material.dart';
import '../models/order.dart';

typedef OnAddItemCallback = void Function(OrderItem item);
typedef OnRemoveItemCallback = void Function(int index);
typedef OnIncrementItemCallback = void Function(int index);
typedef OnDecrementItemCallback = void Function(int index);

class OrderItemEditor extends StatefulWidget {
  final List<OrderItem> items;
  final Function(OrderItem) onAddItem;
  final Function(OrderItem) onRemoveItem;
  final Function(OrderItem) onIncrementItem;
  final Function(OrderItem) onDecrementItem;

  const OrderItemEditor({
    super.key,
    required this.items,
    required this.onAddItem,
    required this.onRemoveItem,
    required this.onIncrementItem,
    required this.onDecrementItem,
  });

  @override
  _OrderItemEditorState createState() => _OrderItemEditorState();
}

class _OrderItemEditorState extends State<OrderItemEditor> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _OrderItemAdder(
          onAddItem: widget.onAddItem,
          onRemoveItem: widget.onRemoveItem,
        ),
        const SizedBox(height: 10),
        _OrderItemList(
          items: widget.items,
          onRemoveItem: widget.onRemoveItem,
          onIncrementItem: widget.onIncrementItem,
          onDecrementItem: widget.onDecrementItem,
        ),
      ],
    );
  }
}

class _OrderItemAdder extends StatefulWidget {
  final Function(OrderItem) onAddItem;
  final Function(OrderItem) onRemoveItem;

  const _OrderItemAdder(
      {required this.onAddItem, required this.onRemoveItem, Key? key})
      : super(key: key);

  @override
  _OrderItemAdderState createState() => _OrderItemAdderState();
}

class _OrderItemAdderState extends State<_OrderItemAdder> {
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: TextField(
                controller: _itemController,
                decoration: const InputDecoration(labelText: 'Product'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _addItem,
            ),
          ],
        ),
      ],
    );
  }

  void _addItem() {
    if (_itemController.text.isNotEmpty &&
        _quantityController.text.isNotEmpty) {
      final item = OrderItem(
        productId: _itemController.text,
        quantity: int.parse(_quantityController.text),
      );
      widget.onAddItem(item);
      _itemController.clear();
      _quantityController.clear();
    }
  }

  void _removeItem(OrderItem item) {
    widget.onRemoveItem(item);
  }
}

class _OrderItemList extends StatefulWidget {
  final List<OrderItem> items;
  final Function(OrderItem) onRemoveItem;
  final Function(OrderItem) onIncrementItem;
  final Function(OrderItem) onDecrementItem;

  const _OrderItemList(
      {required this.items,
      required this.onRemoveItem,
      required this.onIncrementItem,
      required this.onDecrementItem,
      Key? key})
      : super(key: key);

  @override
  _OrderItemListState createState() => _OrderItemListState();
}

class _OrderItemListState extends State<_OrderItemList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        final item = widget.items[index];
        return ListTile(
          title: Text(item.productId),
          subtitle: Text('Quantity: ${item.quantity}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () => widget.onDecrementItem(item),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () => widget.onIncrementItem(item),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => widget.onRemoveItem(item),
              ),
            ],
          ),
        );
      },
    );
  }
}
