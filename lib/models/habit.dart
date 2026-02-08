class Habit {
  final int id;
  final String title;
  final String description;
  bool isCompleted;
  int streak;

  Habit({
    required this.id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
    this.streak = 0,
  });
}
