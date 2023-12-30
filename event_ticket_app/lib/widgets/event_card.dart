// event_card.dart
import 'package:flutter/material.dart';
import 'package:event_ticket_app/models/event.dart';
import 'package:intl/intl.dart';

class EventCard extends StatelessWidget {
  final Event event;

  EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            // Navigate to SeatSelectionScreen when an event is tapped
            Navigator.pushNamed(context, '/seat_selection', arguments: {'event': event});
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0), // Sol üst köşe için border radius
                    topRight: Radius.circular(10.0)),
                child: Image.asset(
                  event.imageUrl,
                  width: 200.0, // Set the desired width
                  height: 200.0, // Set the desired height
                  fit: BoxFit.cover, // Adjust the fit to your needs (cover, contain, fill, etc.)
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8),
                child: Text(
                  event.name,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 16, right: 8, top: 8, bottom: 8),
                child: Text(
                  "Date & Time",
                  style: TextStyle(fontSize: 14.0, color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 8, bottom: 8),
                child: Text(
                  '${DateFormat('dd.MM.yyyy - HH.mm').format(event.date)}',
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
