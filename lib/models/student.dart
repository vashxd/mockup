class Student {
  final String name;
  final String grade;
  final String period;
  final String classId;
  final String? profileImagePath; // Caminho para a imagem de perfil

  Student({
    required this.name,
    required this.grade,
    required this.period,
    required this.classId,
    this.profileImagePath, // Opcional, pode ser nulo
  });
}