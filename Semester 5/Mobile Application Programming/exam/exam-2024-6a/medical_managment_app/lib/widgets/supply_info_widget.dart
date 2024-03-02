import 'package:flutter/material.dart';
import 'package:medical_managment_app/data_access/models/supply.dart';

class SupplyInfoWidget extends StatelessWidget {
  //final VoidCallback? onDelete;
  final VoidCallback? onSupplySelected; // New callback for date selection
  final Supply supply;
  //final bool isDeleteEnabled;

  const SupplyInfoWidget({
    Key? key,
    required this.supply,
    //this.onDelete,
    this.onSupplySelected,
    //this.isDeleteEnabled = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              onTap: onSupplySelected, // Trigger date selection callback
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID: ${supply.id}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Name: ${supply.name}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Supplier: ${supply.supplier}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Details: ${supply.details}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Status: ${supply.status}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Quantity: ${supply.quantity}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Type: ${supply.type}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 8.0),

                    ],
                  ),
                  // if (isDeleteEnabled)
                  //   IconButton(
                  //     icon: const Icon(Icons.delete),
                  //     onPressed: () async {
                  //       onDelete!();
                  //     },
                  //   ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
