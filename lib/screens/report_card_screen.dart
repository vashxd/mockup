import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/subject.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class ReportCardScreen extends StatelessWidget {
  final Student student;
  final List<Subject> subjects;
  final int totalAbsences;
  final double totalFrequency;

  const ReportCardScreen({
    Key? key,
    required this.student,
    required this.subjects,
    required this.totalAbsences,
    required this.totalFrequency,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Detectar se estamos em uma tela grande (web)
    final isLargeScreen = MediaQuery.of(context).size.width > 800;
    final isWebOrTablet = MediaQuery.of(context).size.width > 600;
    
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
              'Boletim',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          CircleAvatar(
            radius: 18,
            backgroundImage: student.profileImagePath != null
              ? AssetImage(student.profileImagePath!)
              : NetworkImage(
                  'https://placehold.co/100x100?text=${student.name[0]}',
                ) as ImageProvider,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth: isLargeScreen ? 1200 : double.infinity,
            ),
            padding: EdgeInsets.all(isWebOrTablet ? 32 : 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Cabeçalho
                if (isLargeScreen)
                  _buildWebHeader()
                else
                  _buildMobileHeader(),
                
                SizedBox(height: isWebOrTablet ? 30 : 20),
                
                // Tabela de notas
                _buildGradesTable(context, isWebOrTablet),

                const SizedBox(height: 20),
                
                // Informações adicionais
                _buildAdditionalInfo(context, isWebOrTablet),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
  Widget _buildWebHeader() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Foto do estudante
            CircleAvatar(
              radius: 50,
              backgroundImage: student.profileImagePath != null
                ? AssetImage(student.profileImagePath!)
                : NetworkImage(
                    'https://placehold.co/200x200?text=${student.name[0]}',
                  ) as ImageProvider,
            ),
            const SizedBox(width: 32),
            
            // Informações do estudante
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ano letivo 2025',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    student.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Ensino Fundamental - ${student.grade} - ${student.period} - ${student.classId}',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16, 
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue[900]!.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'BOLETIM PARCIAL',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[900],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Estatísticas
            Container(
              width: 220,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Frequência Geral',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.check_circle, 
                        color: Colors.green[600],
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${totalFrequency.toStringAsFixed(1)}%',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.green[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Total de Faltas',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[900],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.warning_amber_rounded, 
                        color: totalAbsences > 15 ? Colors.red[600] : Colors.orange[600],
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '$totalAbsences faltas',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: totalAbsences > 15 ? Colors.red[600] : Colors.orange[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Ano letivo 2025',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.blue[900],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            student.name,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Ensino Fundamental - ${student.grade} - ${student.period} - ${student.classId}',
            style: const TextStyle(
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
      ],
    );
  }
  
  Widget _buildGradesTable(BuildContext context, bool isWebOrTablet) {
    return Card(
      elevation: isWebOrTablet ? 2 : 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(isWebOrTablet ? 12 : 0),
      ),
      child: Padding(
        padding: EdgeInsets.all(isWebOrTablet ? 16 : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isWebOrTablet)
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Avaliações e Notas',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
                ),
              ),
              
            // Cabeçalho da tabela
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF003366),
                borderRadius: isWebOrTablet 
                  ? const BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    )
                  : null,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'Disciplina',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: isWebOrTablet ? 16 : 14,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Nota 1',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: isWebOrTablet ? 16 : 14,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Nota 2',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: isWebOrTablet ? 16 : 14,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Média',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: isWebOrTablet ? 16 : 14,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Faltas',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: isWebOrTablet ? 16 : 14,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Linhas da tabela
            ...subjects.map(
              (subject) => InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/subject_detail',
                    arguments: subject,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey[200]!,
                        width: 1,
                      ),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: isWebOrTablet ? 16 : 12, 
                    horizontal: 16,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Row(
                          children: [
                            Icon(
                              _getSubjectIcon(subject.name),
                              color: const Color(0xFF003366),
                              size: isWebOrTablet ? 24 : 20,
                            ),
                            const SizedBox(width: 12),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    subject.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: isWebOrTablet ? 16 : 14,
                                    ),
                                  ),
                                  if (isWebOrTablet)
                                    Text(
                                      subject.teacher,
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                        fontSize: 14,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            subject.grades.length > 0 
                              ? subject.grades[0].toStringAsFixed(1) 
                              : '-',
                            style: TextStyle(
                              fontSize: isWebOrTablet ? 16 : 14,
                              fontWeight: isWebOrTablet ? FontWeight.w500 : FontWeight.normal,
                              color: subject.grades.length > 0 && subject.grades[0] < 6 
                                ? Colors.red 
                                : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            subject.grades.length > 1 
                              ? subject.grades[1].toStringAsFixed(1) 
                              : '-',
                            style: TextStyle(
                              fontSize: isWebOrTablet ? 16 : 14,
                              fontWeight: isWebOrTablet ? FontWeight.w500 : FontWeight.normal,
                              color: subject.grades.length > 1 && subject.grades[1] < 6 
                                ? Colors.red 
                                : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8, 
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: subject.average >= 6 
                                ? Colors.green[50] 
                                : Colors.red[50],
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: subject.average >= 6 
                                  ? Colors.green[300]! 
                                  : Colors.red[300]!,
                                width: 1,
                              ),
                            ),
                            child: Text(
                              subject.average.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: isWebOrTablet ? 16 : 14,
                                fontWeight: FontWeight.bold,
                                color: subject.average >= 6 
                                  ? Colors.green[700] 
                                  : Colors.red[700],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            subject.absences.toString(),
                            style: TextStyle(
                              fontSize: isWebOrTablet ? 16 : 14,
                              fontWeight: isWebOrTablet ? FontWeight.w500 : FontWeight.normal,
                              color: subject.absences > 5 
                                ? Colors.orange 
                                : Colors.black,
                            ),
                          ),
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
    );
  }
  
  Widget _buildAdditionalInfo(BuildContext context, bool isWebOrTablet) {
    if (isWebOrTablet) {
      return Row(
        children: [
          Expanded(
            child: _buildNoteCard(context),
          ),
          const SizedBox(width: 24),
          Expanded(
            child: _buildAttendanceCard(context),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          _buildAttendanceCard(context),
          const SizedBox(height: 20),
          _buildNoteCard(context),
        ],
      );
    }
  }
  
  Widget _buildNoteCard(BuildContext context) {
    final isWebOrTablet = MediaQuery.of(context).size.width > 600;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline, color: Color(0xFF003366)),
              const SizedBox(width: 8),
              Text(
                'Informativo',
                style: TextStyle(
                  fontSize: isWebOrTablet ? 18 : 16,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF003366),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'As notas apresentadas são parciais e podem ser alteradas até o fechamento do bimestre.',
            style: TextStyle(
              fontSize: isWebOrTablet ? 16 : 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Critério de aprovação: média 6.0 e frequência mínima de 75%.',
            style: TextStyle(
              fontSize: isWebOrTablet ? 16 : 14,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildAttendanceCard(BuildContext context) {
    final isWebOrTablet = MediaQuery.of(context).size.width > 600;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                totalFrequency >= 75 ? Icons.check_circle : Icons.warning_amber_rounded,
                color: totalFrequency >= 75 ? Colors.green : Colors.orange,
              ),
              const SizedBox(width: 8),
              Text(
                'Frequência Geral',
                style: TextStyle(
                  fontSize: isWebOrTablet ? 18 : 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Frequência:',
                style: TextStyle(
                  fontSize: isWebOrTablet ? 16 : 14,
                  color: Colors.black87,
                ),
              ),
              Text(
                '${totalFrequency.toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: isWebOrTablet ? 16 : 14,
                  fontWeight: FontWeight.bold,
                  color: totalFrequency >= 75 ? Colors.green : Colors.orange,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total de faltas:',
                style: TextStyle(
                  fontSize: isWebOrTablet ? 16 : 14,
                  color: Colors.black87,
                ),
              ),
              Text(
                '$totalAbsences faltas',
                style: TextStyle(
                  fontSize: isWebOrTablet ? 16 : 14,
                  fontWeight: FontWeight.bold,
                  color: totalAbsences > 15 ? Colors.red : Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getSubjectIcon(String subjectName) {
    switch (subjectName.toLowerCase()) {
      case 'matemática':
        return Icons.calculate;
      case 'português':
      case 'língua portuguesa':
        return Icons.menu_book;
      case 'ciências':
        return Icons.science;
      case 'história':
        return Icons.history_edu;
      case 'geografia':
        return Icons.public;
      case 'inglês':
      case 'língua inglesa':
        return Icons.translate;
      case 'educação física':
        return Icons.sports_basketball;
      case 'artes':
        return Icons.palette;
      default:
        return Icons.school;
    }
  }
}