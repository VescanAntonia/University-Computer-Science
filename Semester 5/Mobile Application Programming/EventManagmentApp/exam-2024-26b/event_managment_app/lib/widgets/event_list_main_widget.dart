import 'package:flutter/material.dart';
import 'package:event_managment_app/data_access/models/event.dart';
import 'package:event_managment_app/widgets/event_info_widget.dart';

import '../business_logic/events_business_logic.dart';
import '../screens/event_details_screen.dart';
import 'event_info_main_widget.dart';

class EventListMainWidget extends StatelessWidget {
  final List<Event> events;
  final EventBusinessLogic eventBusinessLogic;

  const EventListMainWidget({super.key, required this.events,required this.eventBusinessLogic});
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: events.length,
      itemBuilder: (context, index) {
        return EventInfoMainWidget(
          event: events[index],
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventDetailsScreen(
                  selectedEvent: events[index].name,
                  details: events,
                  eventBusinessLogic: eventBusinessLogic,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
