import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/activity.dart';

class ActivitiesScreen extends StatefulWidget {
  final Student student;
  final List<Activity> activities;

  const ActivitiesScreen({
    Key? key,
    required this.student,
    required this.activities,
  }) : super(key: key);

  @override
  _ActivitiesScreenState createState() => _ActivitiesScreenState();
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
          // Convertendo string de data para comparação (assumindo formato dd/mm/yyyy)
          final aDate = _parseDate(a.dueDate);
          final bDate = _parseDate(b.dueDate);
          return aDate.compareTo(bDate);
        });

    final completedActivities = widget.activities
        .where((activity) => activity.isCompleted)
        .where((activity) => _filterSubject == 'Todas' || activity.subject == _filterSubject)
        .toList()
        ..sort((a, b) {
          // Ordenar por data para as concluídas
          final aDate = _parseDate(a.dueDate);
          final bDate = _parseDate(b.dueDate);
          return bDate.compareTo(aDate); // Mais recentes primeiro
        });
    
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
              'Atividades',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          CircleAvatar(
            radius: 18,
            backgroundImage: widget.student.profileImagePath != null
              ? AssetImage(widget.student.profileImagePath!)
              : NetworkImage(
                  'https://placehold.co/100x100?text=${widget.student.name[0]}',
                ) as ImageProvider,
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Minhas Atividades',
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
              widget.student.name,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Ensino Fundamental - ${widget.student.grade} - ${widget.student.period} - ${widget.student.classId}',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          // Filtro por disciplina
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                const Text(
                  'Disciplina:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _filterSubject,
                      icon: const Icon(Icons.arrow_drop_down),
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _filterSubject = newValue;
                          });
                        }
                      },
                      items: _subjects.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // TabBar
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: TabBar(
              controller: _tabController,
              indicatorColor: const Color(0xFF003366),
              labelColor: const Color(0xFF003366),
              unselectedLabelColor: Colors.grey[600],
              tabs: [
                Tab(text: 'PENDENTES (${pendingActivities.length})'),
                Tab(text: 'CONCLUÍDAS (${completedActivities.length})'),
              ],
            ),
          ),
          
          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Pendentes Tab
                _buildActivitiesList(pendingActivities, isPending: true),
                
                // Concluídas Tab
                _buildActivitiesList(completedActivities, isPending: false),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Adicionar nova atividade'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        backgroundColor: const Color(0xFF003366),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
  
  Widget _buildActivitiesList(List<Activity> activities, {required bool isPending}) {
    if (activities.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPending ? Icons.assignment_outlined : Icons.assignment_turned_in_outlined,
              size: 64,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 16),
            Text(
              isPending 
                ? 'Não há atividades pendentes${_filterSubject != 'Todas' ? ' para $_filterSubject' : ''}' 
                : 'Não há atividades concluídas${_filterSubject != 'Todas' ? ' para $_filterSubject' : ''}',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }
    
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: activities.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final activity = activities[index];
        return _buildActivityCard(activity, isPending);
      },
    );
  }
  
  Widget _buildActivityCard(Activity activity, bool isPending) {
    final bool isToday = _isToday(activity.dueDate);
    final bool isClose = _isClose(activity.dueDate);
    
    Color priorityColor;
    switch (activity.priority) {
      case 3:
        priorityColor = Colors.red;
        break;
      case 2:
        priorityColor = Colors.orange;
        break;
      default:
        priorityColor = Colors.green;
    }
    
    Color statusColor;
    String statusText;
    
    if (activity.isCompleted) {
      statusColor = activity.isLate ? Colors.orange : Colors.green;
      statusText = activity.isLate ? 'Entregue com atraso' : 'Concluída';
    } else {
      if (isToday) {
        statusColor = Colors.red;
        statusText = 'Hoje!';
      } else if (isClose) {
        statusColor = Colors.orange;
        statusText = 'Em breve';
      } else {
        statusColor = Colors.blue;
        statusText = 'Pendente';
      }
    }
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isPending && isToday ? Colors.red.withOpacity(0.5) : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: InkWell(
        onTap: () {
          // Navegar para a tela de detalhes da atividade
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Detalhes da atividade: ${activity.title}'),
              duration: const Duration(seconds: 2),
            ),
          );
        },
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: activity.isCompleted 
                  ? Colors.grey[100] 
                  : (isToday ? Colors.red[50] : (isClose ? Colors.orange[50] : Colors.blue[50])),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _getActivityTypeIcon(activity.type),
                    color: activity.isCompleted ? Colors.grey[700] : Colors.blue[800],
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    activity.subject,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: activity.isCompleted ? Colors.grey[700] : Colors.blue[800],
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      statusText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          activity.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: priorityColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    activity.description,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        size: 16,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        activity.teacher,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.calendar_today,
                        size: 16,
                        color: isPending && (isToday || isClose) ? statusColor : Colors.grey[600],
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Entrega: ${activity.dueDate}',
                        style: TextStyle(
                          color: isPending && (isToday || isClose) ? statusColor : Colors.grey[600],
                          fontSize: 12,
                          fontWeight: isPending && (isToday || isClose) ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            if (!activity.isCompleted)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Visualizando detalhes: ${activity.title}'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: const Icon(Icons.visibility, size: 16),
                        label: const Text('Ver detalhes'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF003366),
                          side: const BorderSide(color: Color(0xFF003366)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Marcando como concluída: ${activity.title}'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: const Icon(Icons.check, size: 16),
                        label: const Text('Concluir'),
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF003366),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
  
  IconData _getActivityTypeIcon(String type) {
    switch (type) {
      case 'homework':
        return Icons.assignment;
      case 'project':
        return Icons.build;
      case 'exam':
        return Icons.school;
      case 'reading':
        return Icons.book;
      default:
        return Icons.description;
    }
  }
  
  DateTime _parseDate(String date) {
    // Formato esperado: dd/mm/yyyy
    final parts = date.split('/');
    if (parts.length == 3) {
      return DateTime(
        int.parse(parts[2]), 
        int.parse(parts[1]), 
        int.parse(parts[0])
      );
    }
    return DateTime.now();
  }
  
  bool _isToday(String date) {
    final dueDate = _parseDate(date);
    final today = DateTime.now();
    return dueDate.year == today.year &&
           dueDate.month == today.month &&
           dueDate.day == today.day;
  }
  
  bool _isClose(String date) {
    final dueDate = _parseDate(date);
    final today = DateTime.now();
    final difference = dueDate.difference(today).inDays;
    return difference > 0 && difference <= 3; // Próximos 3 dias
  }
}