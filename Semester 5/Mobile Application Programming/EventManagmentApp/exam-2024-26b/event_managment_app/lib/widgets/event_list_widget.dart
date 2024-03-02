import 'package:flutter/material.dart';
import 'package:event_managment_app/data_access/models/event.dart';
import 'package:event_managment_app/widgets/event_info_widget.dart';

class EventListWidget extends StatelessWidget {
  final List<Event> events;
  final Function(Event) onEventSelected; // New callback for date selection

  const EventListWidget({super.key, required this.events,required this.onEventSelected});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return EventInfoWidget(
          event: events[index],
          onEventSelected: () => onEventSelected(events[index]), // Pass the selected date to the callback
        );
      },
    );
  }
}
