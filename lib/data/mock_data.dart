import '../models/student.dart';
import '../models/subject.dart';

// Dados mockados do aluno
final Student mockStudent = Student(
  name: 'Sâmilly Cavalcante Barbosa Porto',
  grade: '8º Ano',
  period: 'Tarde',
  classId: 'A',
);

// Dados mockados das disciplinas
final List<Subject> mockSubjects = [
  Subject(
    name: 'Arte',
    absences: 0,
    frequency: 100,
    grades: {
      '1º BIMESTRE': 7.7,
      '2º BIMESTRE': 0.0,
      '3º BIMESTRE': 0.0,
      '4º BIMESTRE': 0.0,
    },
  ),
  Subject(
    name: 'Ciências',
    absences: 2,
    frequency: 95,
    grades: {
      '1º BIMESTRE': 8.0,
      '2º BIMESTRE': 0.0,
      '3º BIMESTRE': 0.0,
      '4º BIMESTRE': 0.0,
    },
  ),
  Subject(
    name: 'Cultura Geral',
    absences: 1,
    frequency: 98,
    grades: {
      '1º BIMESTRE': 9.0,
      '2º BIMESTRE': 0.0,
      '3º BIMESTRE': 0.0,
      '4º BIMESTRE': 0.0,
    },
  ),
  Subject(
    name: 'Educação Física',
    absences: 1,
    frequency: 96,
    grades: {
      '1º BIMESTRE': 8.7,
      '2º BIMESTRE': 0.0,
      '3º BIMESTRE': 0.0,
      '4º BIMESTRE': 0.0,
    },
  ),
  Subject(
    name: 'Ensino Religioso',
    absences: 0,
    frequency: 100,
    grades: {
      '1º BIMESTRE': 9.5,
      '2º BIMESTRE': 0.0,
      '3º BIMESTRE': 0.0,
      '4º BIMESTRE': 0.0,
    },
  ),
];

// Cálculo de faltas totais
int getTotalAbsences() {
  int total = 0;
  for (var subject in mockSubjects) {
    total += subject.absences;
  }
  return total;
}

// Cálculo de frequência média
double getAverageFrequency() {
  double total = 0;
  for (var subject in mockSubjects) {
    total += subject.frequency;
  }
  return total / mockSubjects.length;
}