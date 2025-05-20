class Activity {
  final String id;
  final String title;
  final String description;
  final String subject;
  final String dueDate;
  final String teacher;
  final String type; // 'homework', 'project', 'exam', 'reading'
  final bool isCompleted;
  final bool isLate;
  final int priority; // 1: baixa, 2: média, 3: alta
  final String? attachmentUrl;

  Activity({
    required this.id,
    required this.title,
    required this.description,
    required this.subject,
    required this.dueDate,
    required this.teacher,
    required this.type,
    this.isCompleted = false,
    this.isLate = false,
    this.priority = 2,
    this.attachmentUrl,
  });
}