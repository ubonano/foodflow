import 'package:cloud_firestore/cloud_firestore.dart';

class TableModel {
  final String id;
  final String identifier;

  TableModel({required this.id, required this.identifier});

  factory TableModel.fromDocument(DocumentSnapshot doc) {
    return TableModel(
      id: doc.id,
      identifier: doc['identifier'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'identifier': identifier,
    };
  }
}
