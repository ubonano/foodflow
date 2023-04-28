import 'package:flutter/material.dart';
import '../setup/get_it_setup.dart';
import '../widgets/app_stream_builder.dart';
import '../order/order_model.dart';
import '../order/order_service.dart';
import '../order/widgets/order_tile.dart';

class RestaurantDashboard extends StatelessWidget {
  final OrderService _orderService = getIt<OrderService>();

  RestaurantDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FoodFlow - Órdenes abiertas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppStreamBuilder<List<OrderModel>>(
          stream: _orderService.getOpenOrders(),
          onData: (orders) => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              return OrderTile(order: orders[index]);
            },
            itemCount: orders.length,
          ),
        ),
      ),
    );
  }
}
