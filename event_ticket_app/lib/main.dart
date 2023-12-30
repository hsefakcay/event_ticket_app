import 'package:event_ticket_app/screens/event_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:event_ticket_app/screens/seat_selection_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 219, 197, 73), primary: Colors.amber[700]),
        useMaterial3: false,
      ),
      title: 'Event Ticket App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/', // Default route
      routes: {
        '/': (context) => EventListScreen(),
        '/seat_selection': (context) => SeatSelectionPage(),
      },
    );
  }
}
