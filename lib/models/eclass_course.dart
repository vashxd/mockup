class EClassCourse {
  final String id;
  final String name;
  final String teacher;
  final String imageUrl;
  final double progress;
  final int materialsCount;
  final int activitiesCount;
  
  EClassCourse({
    required this.id,
    required this.name,
    required this.teacher,
    required this.imageUrl,
    required this.progress,
    required this.materialsCount,
    required this.activitiesCount,
  });
}