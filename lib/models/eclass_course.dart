class EClassCourse {
  final String id;
  final String name;
  final String teacher;
  final String imageUrl;
  final double progress;
  final int materialsCount;
  final int activitiesCount;
  final String subject;
  final String title;
  final String description;
  final int totalLessons;
  final int duration;
  final String level;
  final int newMaterials;
  
  EClassCourse({
    required this.id,
    required this.name,
    required this.teacher,
    required this.imageUrl,
    required this.progress,
    required this.materialsCount,
    required this.activitiesCount,
    required this.subject,
    required this.title,
    required this.description,
    required this.totalLessons,
    required this.duration,
    required this.level,
    this.newMaterials = 0,
  });
}