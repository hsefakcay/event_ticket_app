import 'package:event_ticket_app/models/event.dart';
import 'package:event_ticket_app/screens/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SeatSelectionScreenWidget extends StatefulWidget {
  final List<int> reservedSeats;
  final int numberOfSeats;
  final Event event; // Add this line

  SeatSelectionScreenWidget({
    required this.numberOfSeats,
    required this.reservedSeats,
    required this.event,
  });

  @override
  _SeatSelectionScreenState createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreenWidget> {
  late List<bool> selectedSeats;

  Color selectColor = Colors.yellow;

  @override
  void initState() {
    super.initState();
    // Koltuk sayısına göre boş bir liste oluştur
    selectedSeats = List.generate(widget.numberOfSeats, (index) => false);
    // Dolu koltukları işaretle
    for (int seatNumber in widget.reservedSeats) {
      if (seatNumber >= 1 && seatNumber <= widget.numberOfSeats) {
        selectedSeats[seatNumber - 1] = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 19, 1, 43),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 30, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.event.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Icon(Icons.date_range, color: Colors.white),
                        ),
                        Text(
                          '${DateFormat('dd.MM.yyyy-HH.mm').format(widget.event.date)}',
                          style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Image.asset(
              'assets/seatVector.jpg',
              fit: BoxFit.cover, // Adjust the fit to your needs (cover, contain, fill, etc.)
            ),
            const SizedBox(height: 20),
            const Text(
              'Screen',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent),
            ),
            const SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: List.generate(widget.numberOfSeats, (index) {
                return GestureDetector(
                  onTap: () {
                    // Koltuk seçildiğinde işlemleri burada yapabilirsiniz
                    setState(() {
                      selectedSeats[index] = !selectedSeats[index];
                    });
                  },
                  child: Column(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: widget.reservedSeats.contains(index + 1)
                              ? Colors.red
                              : selectedSeats[index]
                                  ? Colors.yellow
                                  : Colors.white,
                          border: Border.all(color: Colors.black),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.event_seat_rounded, // İstediğiniz bir iconu seçebilirsiniz
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            SizedBox(height: 20),
            const Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Row(children: [
                Icon(Icons.circle, color: Colors.white),
                Text("Available", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white))
              ]),
              Row(children: [
                Icon(Icons.circle, color: Colors.red),
                Text("Reserved", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red))
              ]),
              Row(children: [
                Icon(Icons.circle, color: Colors.yellow),
                Text("Selected", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.yellow))
              ])
            ]),
            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: ElevatedButton(
                onPressed: () {
                  // Seçilen koltukları işle
                  List<int> selectedSeatNumbers = [];
                  for (int i = 0; i < selectedSeats.length; i++) {
                    if (selectedSeats[i] && !widget.reservedSeats.contains(i + 1)) {
                      // Only add selected seats that are not reserved
                      selectedSeatNumbers.add(i + 1);
                    }
                  }
                  // Navigate to PaymentScreen and pass the necessary data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PaymentScreen(
                        selectedSeatNumbers: selectedSeatNumbers,
                        event: widget.event,
                        ticketPrice: widget.event.ticketPrice,
                      ),
                    ),
                  );
                },
                child: Text('Select Seat'),
                style: ElevatedButton.styleFrom(
                    minimumSize: Size(200, 50),
                    backgroundColor: Colors.amber[700], // Arka plan rengi
                    foregroundColor: Colors.white, // Yazı rengi
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
