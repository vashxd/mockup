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

  // Getter para calcular a nota final (média das notas)
  double? get finalGrade {
    if (grades.isEmpty) return null;
    final total = grades.values.reduce((a, b) => a + b);
    return total / grades.length;
  }
}