class User {
  final String email;
  final String password;
  final String name;

  User({required this.email, required this.password, required this.name});
}

// class User {
//   final String id;
//   final String fullName;
//   final String email;

//   User({
//     required this.id,
//     required this.fullName,
//     required this.email,
//   });

//   // تحويل للكلاود/JSON
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'fullName': fullName,
//       'email': email,
//     };
//   }

//   // تحويل من الكلاود/JSON
//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//       id: map['id'],
//       fullName: map['fullName'],
//       email: map['email'],
//     );
//   }
// }
