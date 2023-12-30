import 'package:event_ticket_app/models/event.dart';
import 'package:event_ticket_app/widgets/seat_selection_widget.dart';
import 'package:flutter/material.dart';

class SeatSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Retrieve the 'event' argument
    final Map<String, dynamic> args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final Event event = args['event'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Seat Selection Page',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SeatSelectionScreenWidget(
        numberOfSeats: 20,
        reservedSeats: [3, 10, 11, 14, 15],
        event: event,
      ),
    );
  }
}
