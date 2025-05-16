import 'package:flutter/material.dart';
import '../models/subject.dart';

class SubjectDetailScreen extends StatelessWidget {
  final Subject subject;

  const SubjectDetailScreen({Key? key, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF003366),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/logo/ChatGPT Image 16 de mai. de 2025, 12_10_18.png',
              width: 30,
              height: 30,
            ),
            const SizedBox(width: 8),
            const Text(
              'Detalhes do Boletim',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                subject.name,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Sâmilly Cavalcante Barbosa Porto',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Ensino Fundamental - 8º Ano - Tarde - A',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'BOLETIM PARCIAL',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F4F8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              'Faltas ${subject.absences}',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[900],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0F4F8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              'Frequência ${subject.frequency.toInt()} %',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[900],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _buildBimesterGrade(
              context,
              term: '1º BIMESTRE',
              grade: subject.getGrade('1º BIMESTRE'),
            ),
            _buildBimesterGrade(
              context,
              term: '2º BIMESTRE',
              grade: subject.getGrade('2º BIMESTRE'),
            ),
            _buildBimesterGrade(
              context,
              term: '3º BIMESTRE',
              grade: subject.getGrade('3º BIMESTRE'),
            ),
            _buildBimesterGrade(
              context,
              term: '4º BIMESTRE',
              grade: subject.getGrade('4º BIMESTRE'),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBimesterGrade(BuildContext context,
      {required String term, required double grade}) {
    Color gradeColor;
    Color backgroundColor;

    if (grade >= 7.0) {
      gradeColor = Colors.green;
      backgroundColor = Colors.green[50]!;
    } else if (grade > 0) {
      gradeColor = Colors.orange;
      backgroundColor = Colors.orange[50]!;
    } else {
      gradeColor = Colors.orange;
      backgroundColor = Colors.orange[50]!;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                term,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      grade.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: gradeColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF003366),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}