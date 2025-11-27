class Booking {
  final String userEmail;
  final List<String> seats;

  Booking({required this.userEmail, required this.seats});
}

// class Booking {
//   final String id;
//   final String userEmail;
//   final String movieId;
//   final List<String> seats;
//   final DateTime dateTime;

//   Booking({
//     required this.id,
//     required this.userEmail,
//     required this.movieId,
//     required this.seats,
//     required this.dateTime,
//   });

//   // تحويل للكلاود/JSON
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'userEmail': userEmail,
//       'movieId': movieId,
//       'seats': seats,
//       'dateTime': dateTime.toIso8601String(),
//     };
//   }

//   // تحويل من الكلاود/JSON
//   factory Booking.fromMap(Map<String, dynamic> map) {
//     return Booking(
//       id: map['id'],
//       userEmail: map['userEmail'],
//       movieId: map['movieId'],
//       seats: List<String>.from(map['seats']),
//       dateTime: DateTime.parse(map['dateTime']),
//     );
//   }
// }
