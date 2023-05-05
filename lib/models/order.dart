// lib/models/order_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum OrderStatus { open, checkout, closed, all }

class OrderModel {
  final String id;
  final DateTime createdAt;
  final String tableId;
  final String waiter;
  final int numGuests;
  final List<OrderItem> items;
  final OrderStatus status;

  OrderModel({
    required this.id,
    required this.createdAt,
    required this.tableId,
    required this.waiter,
    required this.numGuests,
    required this.items,
    required this.status,
  });

  String get elapsedTime {
    final duration = DateTime.now().difference(createdAt);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}';
  }

  OrderModel copyWith({
    String? id,
    DateTime? createdAt,
    String? tableId,
    String? waiter,
    int? numGuests,
    List<OrderItem>? items,
    OrderStatus? status,
  }) {
    return OrderModel(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      tableId: tableId ?? this.tableId,
      waiter: waiter ?? this.waiter,
      numGuests: numGuests ?? this.numGuests,
      items: items ?? this.items,
      status: status ?? this.status,
    );
  }

  factory OrderModel.newOrder({required String tableId}) {
    return OrderModel(
      id: '',
      createdAt: DateTime.now(),
      tableId: tableId,
      waiter: '',
      numGuests: 0,
      items: [],
      status: OrderStatus.open,
    );
  }

  factory OrderModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return OrderModel(
      id: doc.id,
      createdAt: data['createdAt'].toDate(),
      tableId: data['tableId'],
      waiter: data['waiter'],
      numGuests: data['numGuests'],
      items: (data['items'] as List)
          .map((item) => OrderItem.fromMap(item))
          .toList(),
      status: OrderStatus.values[data['status']],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'createdAt': createdAt,
      'tableId': tableId,
      'waiter': waiter,
      'numGuests': numGuests,
      'items': items.map((item) => item.toMap()).toList(),
      'status': status.index,
    };
  }
}

class OrderItem {
  final String productId;
  final int quantity;

  OrderItem({
    required this.productId,
    required this.quantity,
  });

  OrderItem copyWith({String? productId, int? quantity}) {
    return OrderItem(
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
    );
  }

  factory OrderItem.fromMap(Map<String, dynamic> data) {
    return OrderItem(
      productId: data['productId'],
      quantity: data['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}

extension OrderStatusColor on OrderStatus {
  Color get color {
    switch (this) {
      case OrderStatus.open:
        return Colors.green;
      case OrderStatus.checkout:
        return Colors.orange;
      case OrderStatus.closed:
        return Colors.grey;
      default:
        return Colors.transparent;
    }
  }
}
