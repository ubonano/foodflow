import 'package:pdf/widgets.dart' as pw;

import '../models/order.dart';

Future<pw.Document> generatePdf(OrderModel order) async {
  final doc = pw.Document();

  doc.addPage(
    pw.MultiPage(
      build: (context) => [
        pw.Header(child: pw.Text('Order Details')),
        pw.Paragraph(text: 'Table ID: ${order.tableId}'),
        pw.Paragraph(text: 'Waiter: ${order.waiter}'),
        pw.Paragraph(text: 'Number of Guests: ${order.numGuests}'),
        pw.Paragraph(text: 'Created At: ${order.createdAt}'),
        pw.Paragraph(text: 'Status: ${order.status}'),
        pw.Header(child: pw.Text('Order Items')),
        pw.Table.fromTextArray(
          context: context,
          data: <List<String>>[
            ['Product', 'Quantity', 'Price'],
            ...order.items.map((item) => [item.productId, '${item.quantity}'])
            // (item) => [item.productId, '${item.quantity}', '${item.price}'])
          ],
        ),
        pw.Paragraph(text: 'Total: **NotImplemented**'),
        // pw.Paragraph(text: 'Total: ${order.total}'),
      ],
    ),
  );

  return doc;
}
