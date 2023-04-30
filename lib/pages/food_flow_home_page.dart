import 'package:flutter/material.dart';
import 'package:foodflow/setup/get_it_setup.dart';
import 'package:intl/intl.dart';
import '../order/service_order_controller.dart';
import '../order/service_order_model.dart';
import '../widgets/app_stream_builder.dart';

class FoodFlowHomePage extends StatefulWidget {
  const FoodFlowHomePage({super.key});

  @override
  _FoodFlowHomePageState createState() => _FoodFlowHomePageState();
}

class _FoodFlowHomePageState extends State<FoodFlowHomePage> {
  final _orderController = getIt<ServiceOrderController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ServiceFlow - Órdenes abiertas'),
        actions: [
          PopupMenuButton<ServiceOrderSortingOption>(
            onSelected: (value) => _orderController.updateSortingOption(value),
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<ServiceOrderSortingOption>(
                  value: ServiceOrderSortingOption.time,
                  child: Text('Ordenar por hora de llegada'),
                ),
                const PopupMenuItem<ServiceOrderSortingOption>(
                  value: ServiceOrderSortingOption.tableNumber,
                  child: Text('Ordenar por número de mesa'),
                ),
                const PopupMenuItem<ServiceOrderSortingOption>(
                  value: ServiceOrderSortingOption.waiterName,
                  child: Text('Ordenar por mesero'),
                ),
              ];
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateOrderDialog,
        tooltip: 'Crear nueva orden',
        child: const Icon(Icons.add),
      ),
      body: AppStreamBuilder<List<ServiceOrder>>(
        stream: _orderController.getOrdersStream(),
        onData: (orders) {
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
              return _buildOrderTile(order);
            },
          );
        },
      ),
    );
  }

  Widget _buildOrderTile(ServiceOrder order) {
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

  Future<void> _showCreateOrderDialog() async {
    int? tableNumber;
    String? waiterName;
    int? numberOfGuests;

    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
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
              onPressed: () async {
                if (tableNumber != null &&
                    waiterName != null &&
                    numberOfGuests != null) {
                  final newOrder = ServiceOrder.createNew(
                    tableNumber: tableNumber!,
                    waiterName: waiterName!,
                    numberOfGuests: numberOfGuests!,
                  );
                  await _orderController.createOrder(newOrder);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}
