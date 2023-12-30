import 'package:flutter/material.dart';
import 'package:event_ticket_app/models/ticket.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketConfirmationScreen extends StatelessWidget {
  final Ticket ticket;
  final List<int> selectedSeatNumbers;
  final String eventName;

  TicketConfirmationScreen({
    required this.ticket,
    required this.selectedSeatNumbers,
    required this.eventName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Ticket Confirmation'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Selected Seats: ${selectedSeatNumbers.join(' , ')}',
                    style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16.0),
                  Text(
                    'Event: $eventName',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  SizedBox(height: 16.0),
                  // Display QR code
                  QrImageView(
                    data: ticket.qrCode,
                    version: QrVersions.auto,
                    size: 300.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
