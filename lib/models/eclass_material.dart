class EClassMaterial {
  final String id;
  final String title;
  final String description;
  final String type; // 'pdf', 'video', 'link', 'text'
  final String date;
  final bool isCompleted;
  final bool isNew;
  
  EClassMaterial({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.date,
    this.isCompleted = false,
    this.isNew = false,
  });
}

class EClassActivity {
  final String id;
  final String title;
  final String description;
  final String dueDate;
  final String submitDate;
  final bool isCompleted;
  final double? grade;
  final int maxGrade;
  final bool isLate;
  
  EClassActivity({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.submitDate = '',
    this.isCompleted = false,
    this.grade,
    this.maxGrade = 10,
    this.isLate = false,
  });
}