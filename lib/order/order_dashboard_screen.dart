import 'package:flutter/material.dart';
import 'package:foodflow/setup/get_it_setup.dart';
import 'package:logging/logging.dart';
import 'order_controller.dart';
import 'order_model.dart';
import '../widgets/app_stream_builder.dart';
import 'widgets/order_tile.dart';
import 'widgets/order_creation_dialog.dart';

final _logger = Logger('OrderDashboardScreen');

class OrderDashboardScreen extends StatefulWidget {
  const OrderDashboardScreen({Key? key}) : super(key: key);

  @override
  _OrderDashboardScreenState createState() {
    return _OrderDashboardScreenState();
  }
}

class _OrderDashboardScreenState extends State<OrderDashboardScreen> {
  final _orderController = getIt<ServiceOrderController>();

  @override
  Widget build(BuildContext context) {
    _logger.info('Building OrderDashboardScreen');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Órdenes abiertas'),
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
      onSelected: (value) {
        _logger.info('Selected sorting option: $value');
        _orderController.updateSortingOption(value);
      },
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
    _logger.info('Building Order grid');

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
      _logger.info('Creating new order: ${newOrder.toMap()}');
      await _orderController.createOrder(newOrder);
    }
  }
}
