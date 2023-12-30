import 'package:flutter/material.dart';
import 'package:event_ticket_app/models/event.dart'; // Import your data model
import 'package:event_ticket_app/widgets/event_card.dart';

class EventListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Example events (you can replace this with your actual data)
    List<Event> events = [
      Event(
        name: 'Tech Conference 2023',
        date: DateTime.now().add(Duration(days: 14)),
        venue: 'Tech Expo Center',
        imageUrl: 'assets/tech_conference_image.jpg',
        ticketPrice: 9.90,
      ),
      Event(
        name: 'Art Exhibition',
        date: DateTime.now().add(Duration(days: 21)),
        venue: 'City Art Gallery',
        imageUrl: 'assets/art_exhibition_image.jpg',
        ticketPrice: 12.90,
      ),
      Event(
        name: 'Food Festival',
        date: DateTime.now().add(Duration(days: 30)),
        venue: 'Downtown Food Plaza',
        imageUrl: 'assets/food_festival_image.jpg',
        ticketPrice: 14.90,
      ),
      Event(
        name: 'Fitness Workshop',
        date: DateTime.now().add(Duration(days: 10)),
        venue: 'Fitness Studio',
        imageUrl: 'assets/fitness_workshop_image.jpg',
        ticketPrice: 9,
      ),
      Event(
        name: 'Science Fair',
        date: DateTime.now().add(Duration(days: 28)),
        venue: 'Science Convention Center',
        imageUrl: 'assets/science_fair_image.jpg',
        ticketPrice: 7.5,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Event List',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          return EventCard(event: events[index]);
        },
      ),
    );
  }
}
