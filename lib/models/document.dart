class Document {
  final String title;
  final String type;
  final String date;
  final bool isAvailable;
  final String? description;

  Document({
    required this.title,
    required this.type,
    required this.date,
    required this.isAvailable,
    this.description,
  });
}