import 'package:flutter/material.dart';
import '../models/user.dart';
import '../models/movie.dart';
import '../models/booking.dart';
import '../services/app_state.dart';

// Seat Selection Screen
class SeatSelectionScreen extends StatefulWidget {
  final User user;
  final Movie movie;
  final String timeSlot;

  const SeatSelectionScreen({
    Key? key,
    required this.user,
    required this.movie,
    required this.timeSlot,
  }) : super(key: key);

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  Set<String> _selectedSeats = {};

  String get _bookingKey => '${widget.movie.id}-${widget.timeSlot}';

  List<Booking> get _currentBookings {
    return AppState.bookings[_bookingKey] ?? [];
  }

  String _getSeatStatus(String seatId) {
    for (var booking in _currentBookings) {
      if (booking.seats.contains(seatId)) {
        return booking.userEmail == widget.user.email ? 'mine' : 'booked';
      }
    }
    return 'available';
  }

  void _toggleSeat(String seatId) {
    final status = _getSeatStatus(seatId);
    if (status == 'booked') return;

    setState(() {
      if (_selectedSeats.contains(seatId)) {
        _selectedSeats.remove(seatId);
      } else {
        _selectedSeats.add(seatId);
      }
    });
  }

  void _bookSeats() {
    if (_selectedSeats.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select at least one seat')),
      );
      return;
    }

    final bookings = List<Booking>.from(_currentBookings);
    final existingBooking = bookings.firstWhere(
      (b) => b.userEmail == widget.user.email,
      orElse: () => Booking(userEmail: '', seats: []),
    );

    if (existingBooking.userEmail.isNotEmpty) {
      bookings.remove(existingBooking);
      bookings.add(
        Booking(
          userEmail: widget.user.email,
          seats: [...existingBooking.seats, ..._selectedSeats],
        ),
      );
    } else {
      bookings.add(
        Booking(userEmail: widget.user.email, seats: _selectedSeats.toList()),
      );
    }

    AppState.bookings[_bookingKey] = bookings;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Booking Confirmed'),
        content: Text(
          'Successfully booked ${_selectedSeats.length} seat(s) for ${widget.movie.title} at ${widget.timeSlot}!',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildSeat(String seatId) {
    final status = _getSeatStatus(seatId);
    final isSelected = _selectedSeats.contains(seatId);

    Color seatColor;
    if (status == 'mine' || isSelected) {
      seatColor = Colors.green;
    } else if (status == 'booked') {
      seatColor = Colors.grey;
    } else {
      seatColor = Colors.white;
    }

    return GestureDetector(
      onTap: () => _toggleSeat(seatId),
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: seatColor,
          border: Border.all(
            color: status == 'booked'
                ? Colors.grey.shade600
                : Colors.grey.shade400,
            width: 2,
          ),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
        ),
      ),
    );
  }

  Widget _buildLegend(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.grey),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(6),
              topRight: Radius.circular(6),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 12)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Seats'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Center(
                      child: Text(
                        'SCREEN',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Left section
                      Column(
                        children: List.generate(5, (row) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: List.generate(4, (col) {
                                final seatId = '$row-$col-L';
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: _buildSeat(seatId),
                                );
                              }),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(width: 32),
                      // Right section
                      Column(
                        children: List.generate(5, (row) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              children: List.generate(6, (col) {
                                final seatId = '$row-$col-R';
                                return Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: _buildSeat(seatId),
                                );
                              }),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildLegend('Available', Colors.white),
                      _buildLegend('Your Selection', Colors.green),
                      _buildLegend('Booked', Colors.grey),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Selected Seats',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '${_selectedSeats.length}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.purple,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: _bookSeats,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Book Now',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
