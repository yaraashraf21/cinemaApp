import '../models/user.dart';
import '../models/movie.dart';
import '../models/booking.dart';

class AppState {
  static final List<User> users = [
    User(email: 'user1@example.com', password: 'password123', name: 'User 1'),
    User(email: 'user2@example.com', password: 'password123', name: 'User 2'),
  ];

  static final List<Movie> movies = [
    Movie(
      id: 1,
      title: 'The Dark Knight',
      description:
          'Batman must accept one of the greatest tests to fight injustice',
      emoji: '🦇',
      timeSlots: ['10:00 AM', '2:00 PM', '6:00 PM', '9:00 PM'],
    ),
    Movie(
      id: 2,
      title: 'Inception',
      description:
          'A thief who steals corporate secrets through dream-sharing technology',
      emoji: '🌀',
      timeSlots: ['11:00 AM', '3:00 PM', '7:00 PM'],
    ),
    Movie(
      id: 3,
      title: 'Interstellar',
      description: 'A team of explorers travel through a wormhole in space',
      emoji: '🚀',
      timeSlots: ['12:00 PM', '4:00 PM', '8:00 PM'],
    ),
  ];

  static Map<String, List<Booking>> bookings = {};
}
