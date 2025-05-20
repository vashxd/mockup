class Notification {
  final String title;
  final String message;
  final String date;
  final String type;
  final bool isRead;

  Notification({
    required this.title,
    required this.message,
    required this.date,
    required this.type,
    this.isRead = false,
  });
}