import 'event.dart';

class Ticket {
  final Event event;
  final String seat;
  final String qrCode;

  Ticket({
    required this.event,
    required this.seat,
    required this.qrCode,
  });
}
