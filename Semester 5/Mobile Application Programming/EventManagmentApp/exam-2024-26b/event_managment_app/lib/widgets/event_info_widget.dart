import 'package:flutter/material.dart';
import 'package:event_managment_app/data_access/models/event.dart';

class EventInfoWidget extends StatelessWidget {
  final VoidCallback? onDelete;
  final VoidCallback? onEventSelected; // New callback for date selection
  final Event event;
  final bool isDeleteEnabled;

  const EventInfoWidget({
    Key? key,
    required this.event,
    this.onDelete,
    this.onEventSelected,
    this.isDeleteEnabled = false,
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
              onTap: onEventSelected, // Trigger date selection callback
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'ID: ${event.id}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Name: ${event.name}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Team: ${event.team}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Participants: ${event.participants}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Type: ${event.type}',
                        style: const TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 8.0),

                    ],
                  ),
                  if (isDeleteEnabled)
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        onDelete!();
                      },
                    ),
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
