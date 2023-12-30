import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'ticket_confirmation_screen.dart';
import 'package:event_ticket_app/models/event.dart';
import 'package:event_ticket_app/models/ticket.dart';

class PaymentScreen extends StatefulWidget {
  final List<int> selectedSeatNumbers;
  final Event event;
  final double ticketPrice;

  PaymentScreen({
    required this.selectedSeatNumbers,
    required this.event,
    required this.ticketPrice,
  });

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //koltuk ücreti hesabı
    double totalPrice = widget.ticketPrice * widget.selectedSeatNumbers.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        widget.event.imageUrl,
                        width: 150.0, // Set the desired width
                        height: 200.0, // Set the desired height
                        fit: BoxFit.cover, // Adjust the fit to your needs (cover, contain, fill, etc.)
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 200,
                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              widget.event.name,
                              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '${DateFormat('dd.MM.yyyy - HH.mm').format(widget.event.date)}',
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
                  )
                ]),
                TextFormField(
                  controller: _cardNumberController,
                  inputFormatters: [LengthLimitingTextInputFormatter(16)],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                    hintText: 'Enter your card number',
                  ),
                  validator: (value) {
                    return _validateCardNumber(value ?? '');
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _expiryDateController,
                        inputFormatters: [LengthLimitingTextInputFormatter(5)],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Expiration Date',
                          hintText: 'MM/YY',
                        ),
                        validator: (value) {
                          return _validateExpiryDate(value ?? '');
                        },
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        controller: _cvvController,
                        inputFormatters: [LengthLimitingTextInputFormatter(3)],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'CVV',
                          hintText: 'Enter CVV',
                        ),
                        validator: (value) {
                          return _validateCVV(value ?? '');
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32.0),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Total Price: \$${totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Form is valid, proceed with payment processing logic
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TicketConfirmationScreen(
                            ticket: Ticket(
                              event: Event(
                                name: widget.event.name,
                                date: DateTime.now(),
                                venue: 'Example Venue',
                                imageUrl: 'assets/concert_image.jpg',
                                ticketPrice: widget.ticketPrice,
                              ),
                              seat: 'Seat Placeholder',
                              qrCode: 'QR Code Placeholder',
                            ),
                            selectedSeatNumbers: widget.selectedSeatNumbers,
                            eventName: widget.event.name,
                          ),
                        ),
                      );
                    } else {
                      // Form is not valid, display errors
                    }
                  },
                  child: Text('Pay'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50),
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validateCardNumber(String value) {
    if (value.isEmpty || value.length < 16) {
      return 'Please enter a valid card number';
    }
    return null;
  }

  String? _validateExpiryDate(String value) {
    if (value.isEmpty || value.length < 5) {
      return 'Please enter a valid expiration date';
    }

    final dateParts = value.split('/');
    if (dateParts.length != 2) {
      return 'Invalid date format';
    }

    final month = int.tryParse(dateParts[0]);
    final year = int.tryParse(dateParts[1]);

    if (month == null || year == null || month < 1 || month > 12) {
      return 'Invalid month';
    }

    final currentYear = DateTime.now().year % 100; // Assuming YY format for the year
    if (year < currentYear || year > currentYear + 20) {
      return 'Invalid year';
    }

    final currentDate = DateTime.now();
    if (year == currentYear && month < currentDate.month) {
      return 'Card has expired';
    }

    return null;
  }

  String? _validateCVV(String value) {
    if (value.isEmpty || value.length < 3) {
      return 'Please enter a valid CVV';
    }
    return null;
  }
}
