import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const CinemaBookingApp());
}

class CinemaBookingApp extends StatelessWidget {
  const CinemaBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cinema Booking',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple, useMaterial3: true),
      home: const LoginScreen(),
    );
  }
}
