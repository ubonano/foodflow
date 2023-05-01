import 'package:flutter/material.dart';
import 'package:foodflow/setup/get_it_setup.dart';
import 'order_controller.dart';
import 'order_model.dart';
import '../widgets/app_stream_builder.dart';
import 'widgets/order_tile.dart';
import 'widgets/order_creation_dialog.dart';

class OrderDashboardScreen extends StatefulWidget {
  const OrderDashboardScreen({super.key});

  @override
  _OrderDashboardScreenState createState() => _OrderDashboardScreenState();
}

class _OrderDashboardScreenState extends State<OrderDashboardScreen> {
  final _orderController = getIt<ServiceOrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ServiceFlow - Órdenes abiertas'),
        actions: [_buildSortingPopup()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateOrderDialog,
        tooltip: 'Crear nueva orden',
        child: const Icon(Icons.add),
      ),
      body: AppStreamBuilder<List<ServiceOrder>>(
        stream: _orderController.getOrdersStream(),
        onData: (orders) => _buildOrderGrid(orders),
      ),
    );
  }

  Widget _buildSortingPopup() {
    return PopupMenuButton<OrderSortingOption>(
      onSelected: (value) => _orderController.updateSortingOption(value),
      itemBuilder: (BuildContext context) {
        return [
          const PopupMenuItem<OrderSortingOption>(
            value: OrderSortingOption.time,
            child: Text('Ordenar por hora de llegada'),
          ),
          const PopupMenuItem<OrderSortingOption>(
            value: OrderSortingOption.tableNumber,
            child: Text('Ordenar por número de mesa'),
          ),
          const PopupMenuItem<OrderSortingOption>(
            value: OrderSortingOption.waiterName,
            child: Text('Ordenar por mesero'),
          ),
        ];
      },
    );
  }

  Widget _buildOrderGrid(List<ServiceOrder> orders) {
    return GridView.builder(
      itemCount: orders.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width ~/
            300, // Ajusta la cantidad de tarjetas por fila según el ancho de la pantalla
        childAspectRatio:
            1.5, // Establece una relación de aspecto fija para las tarjetas
      ),
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderTile(order: order);
      },
    );
  }

  Future<void> _showCreateOrderDialog() async {
    final newOrder = await showDialog<ServiceOrder>(
      context: context,
      builder: (BuildContext context) {
        return const OrderCreationDialog();
      },
    );
    if (newOrder != null) {
      await _orderController.createOrder(newOrder);
    }
  }
}
