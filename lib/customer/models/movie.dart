class Movie {
  final int id;
  final String title;
  final String description;
  final String emoji;
  final List<String> timeSlots;
  final int totalSeats;

  Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.emoji,
    required this.timeSlots,
    this.totalSeats = 47,
  });
}
