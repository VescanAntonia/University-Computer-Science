import 'package:flutter/material.dart';
import 'package:event_managment_app/data_access/models/event.dart';

class EventTopWidget extends StatelessWidget {
  final VoidCallback? onDelete;
  final Event event;
  final String nrParticipants;
  final bool isDeleteEnabled;

  const EventTopWidget(
      {Key? key,
        required this.event,
        required this.nrParticipants,
        this.onDelete,
        this.isDeleteEnabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Event name: ${event.name}',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Status: ${event.status}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      'Participants: ${event.participants}',
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
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}