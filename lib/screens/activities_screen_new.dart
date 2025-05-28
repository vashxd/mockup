import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/activity.dart';

class ActivitiesScreen extends StatefulWidget {
  final Student student;
  final List<Activity> activities;

  const ActivitiesScreen({
    super.key,
    required this.student,
    required this.activities,
  });

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _filterSubject = 'Todas';
  List<String> _subjects = ['Todas'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    
    // Extrair lista única de disciplinas das atividades
    final subjectSet = <String>{};
    for (var activity in widget.activities) {
      subjectSet.add(activity.subject);
    }
    _subjects = ['Todas', ...subjectSet.toList()..sort()];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filtrar atividades por status (pendentes/concluídas) e disciplina
    final pendingActivities = widget.activities
        .where((activity) => !activity.isCompleted)
        .where((activity) => _filterSubject == 'Todas' || activity.subject == _filterSubject)
        .toList()
        ..sort((a, b) {
          // Ordenar por prioridade (decrescente) e depois por data
          if (a.priority != b.priority) {
            return b.priority.compareTo(a.priority);
          }
          final aDate = _parseDate(a.dueDate);
          final bDate = _parseDate(b.dueDate);
          return aDate.compareTo(bDate);
        });

    final completedActivities = widget.activities
        .where((activity) => activity.isCompleted)
        .where((activity) => _filterSubject == 'Todas' || activity.subject == _filterSubject)
        .toList()
        ..sort((a, b) {
          final aDate = _parseDate(a.dueDate);
          final bDate = _parseDate(b.dueDate);
          return bDate.compareTo(aDate);
        });

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Column(
        children: [
          // Header com gradiente
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF6366F1),
                  Color(0xFF8B5CF6),
                ],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 24),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const SizedBox(width: 12),
                        Image.asset(
                          'assets/logo/ChatGPT Image 16 de mai. de 2025, 12_10_18.png',
                          width: 32,
                          height: 32,
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'Atividades',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 2),
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: widget.student.profileImagePath != null
                              ? AssetImage(widget.student.profileImagePath!)
                              : NetworkImage(
                                  'https://placehold.co/100x100?text=${widget.student.name[0]}',
                                ) as ImageProvider,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  // Tabs e filtro
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        // Filtro por disciplina
                        Container(
                          height: 40,
                          margin: const EdgeInsets.only(bottom: 16),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _subjects.length,
                            itemBuilder: (context, index) {
                              final subject = _subjects[index];
                              final isSelected = _filterSubject == subject;
                              return Container(
                                margin: const EdgeInsets.only(right: 8),
                                child: FilterChip(
                                  label: Text(
                                    subject,
                                    style: TextStyle(
                                      color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.8),
                                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                  ),
                                  selected: isSelected,
                                  onSelected: (selected) {
                                    setState(() {
                                      _filterSubject = subject;
                                    });
                                  },
                                  backgroundColor: Colors.white.withValues(alpha: 0.1),
                                  selectedColor: Colors.white.withValues(alpha: 0.2),
                                  side: BorderSide(
                                    color: isSelected ? Colors.white : Colors.white.withValues(alpha: 0.3),
                                  ),
                                  showCheckmark: false,
                                ),
                              );
                            },
                          ),
                        ),
                        
                        // Tab bar
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: TabBar(
                            controller: _tabController,
                            indicator: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: const Color(0xFF6366F1),
                            unselectedLabelColor: Colors.white,
                            labelStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                            unselectedLabelStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            tabs: [
                              Tab(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.pending_actions_rounded, size: 18),
                                    const SizedBox(width: 8),
                                    Text('Pendentes (${pendingActivities.length})'),
                                  ],
                                ),
                              ),
                              Tab(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.check_circle_rounded, size: 18),
                                    const SizedBox(width: 8),
                                    Text('Concluídas (${completedActivities.length})'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          
          // Conteúdo principal com TabBarView
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildActivitiesList(pendingActivities, false),
                _buildActivitiesList(completedActivities, true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivitiesList(List<Activity> activities, bool isCompleted) {
    if (activities.isEmpty) {
      return Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE5E7EB)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF6B7280).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  isCompleted ? Icons.check_circle_outline_rounded : Icons.assignment_outlined,
                  size: 48,
                  color: const Color(0xFF6B7280),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                isCompleted ? 'Nenhuma atividade concluída' : 'Nenhuma atividade pendente',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                isCompleted 
                  ? 'Suas atividades concluídas aparecerão aqui.'
                  : 'Quando você tiver atividades para fazer, elas aparecerão aqui.',
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Container(
            margin: const EdgeInsets.all(20),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final activity = activities[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header com prioridade e status
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: _getPriorityColor(activity.priority).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _getPriorityColor(activity.priority).withValues(alpha: 0.3),
                                ),
                              ),
                              child: Text(
                                _getPriorityText(activity.priority),
                                style: TextStyle(
                                  color: _getPriorityColor(activity.priority),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const Spacer(),
                            if (isCompleted)
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF10B981).withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.check_circle_rounded,
                                  color: Color(0xFF10B981),
                                  size: 20,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        // Título e disciplina
                        Text(
                          activity.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1F2937),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            activity.subject,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        
                        if (activity.description.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Text(
                            activity.description,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF6B7280),
                              height: 1.5,
                            ),
                          ),
                        ],
                        
                        const SizedBox(height: 16),
                        
                        // Data de entrega e ações
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF3B82F6).withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.calendar_today_rounded,
                                color: Color(0xFF3B82F6),
                                size: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Entrega: ${activity.dueDate}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xFF374151),
                              ),
                            ),
                            const Spacer(),
                            if (!isCompleted)
                              ElevatedButton.icon(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Atividade marcada como concluída!'),
                                      backgroundColor: const Color(0xFF10B981),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.check_rounded, size: 16),
                                label: const Text('Concluir'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF10B981),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Color _getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return const Color(0xFFEF4444);
      case 2:
        return const Color(0xFFF59E0B);
      case 3:
        return const Color(0xFF10B981);
      default:
        return const Color(0xFF6B7280);
    }
  }

  String _getPriorityText(int priority) {
    switch (priority) {
      case 1:
        return 'ALTA PRIORIDADE';
      case 2:
        return 'MÉDIA PRIORIDADE';
      case 3:
        return 'BAIXA PRIORIDADE';
      default:
        return 'SEM PRIORIDADE';
    }
  }

  DateTime _parseDate(String dateString) {
    try {
      final parts = dateString.split('/');
      if (parts.length == 3) {
        return DateTime(
          int.parse(parts[2]),
          int.parse(parts[1]),
          int.parse(parts[0]),
        );
      }
    } catch (e) {
      // Em caso de erro, retorna a data atual
    }
    return DateTime.now();
  }
}
