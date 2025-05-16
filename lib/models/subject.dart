class Subject {
  final String name;
  final int absences;
  final double frequency;
  final Map<String, double> grades;

  Subject({
    required this.name,
    required this.absences,
    required this.frequency,
    required this.grades,
  });

  // Método para obter a nota de um bimestre específico
  double getGrade(String term) {
    return grades[term] ?? 0.0;
  }
}