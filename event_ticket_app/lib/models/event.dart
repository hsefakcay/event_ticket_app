class Event {
  final String name;
  final DateTime date;
  final String venue;
  final String imageUrl;
  final double ticketPrice;

  Event({
    required this.name,
    required this.date,
    required this.venue,
    required this.imageUrl,
    required this.ticketPrice,
  });
}
