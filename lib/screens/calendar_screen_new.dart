import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/calendar_event.dart';

class CalendarScreen extends StatefulWidget {
  final Student student;
  final List<CalendarEvent> events;

  const CalendarScreen({
    super.key,
    required this.student,
    required this.events,
  });

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  int? _expandedEventIndex;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDayEvents = _getEventsForDay(_selectedDay!);
    
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
              child: Padding(
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
                        'Calendário',
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
            ),
          ),
          
          // Calendário
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        // Widget do calendário
                        Container(
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
                            children: [
                              // Header do calendário
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [Color(0xFF6366F1), Color(0xFF8B5CF6)],
                                  ),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      _formatMonthYear(_focusedDay),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      icon: const Icon(Icons.chevron_left, color: Colors.white),
                                      onPressed: () {
                                        setState(() {
                                          _focusedDay = DateTime(
                                            _focusedDay.year,
                                            _focusedDay.month - 1,
                                            _focusedDay.day,
                                          );
                                        });
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.chevron_right, color: Colors.white),
                                      onPressed: () {
                                        setState(() {
                                          _focusedDay = DateTime(
                                            _focusedDay.year,
                                            _focusedDay.month + 1,
                                            _focusedDay.day,
                                          );
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              
                              // Dias da semana
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: _formatWeekDay().map((day) => 
                                    Expanded(
                                      child: Text(
                                        day,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF6B7280),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                  ).toList(),
                                ),
                              ),
                              
                              // Grid do calendário
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: _buildCalendarGrid(),
                              ),
                              
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                        
                        const SizedBox(height: 20),
                        
                        // Eventos do dia selecionado
                        if (selectedDayEvents.isNotEmpty) ...[
                          Container(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text(
                                    'Eventos de ${_formatDate(_selectedDay!)}',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: Color(0xFF1F2937),
                                    ),
                                  ),
                                ),
                                
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: selectedDayEvents.length,
                                  itemBuilder: (context, index) {
                                    final event = selectedDayEvents[index];
                                    final isExpanded = _expandedEventIndex == index;
                                    
                                    return Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: _getEventColor(event.type).withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: _getEventColor(event.type).withValues(alpha: 0.3),
                                        ),
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            _expandedEventIndex = isExpanded ? null : index;
                                          });
                                        },
                                        borderRadius: BorderRadius.circular(12),
                                        child: Padding(
                                          padding: const EdgeInsets.all(16),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    padding: const EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                      color: _getEventColor(event.type),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    child: Icon(
                                                      _getEventTypeIcon(event.type),
                                                      color: Colors.white,
                                                      size: 16,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Expanded(
                                                    child: Text(
                                                      event.title,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        fontWeight: FontWeight.w600,
                                                        color: Color(0xFF1F2937),
                                                      ),
                                                    ),
                                                  ),
                                                  Icon(
                                                    isExpanded ? Icons.expand_less : Icons.expand_more,
                                                    color: const Color(0xFF6B7280),
                                                  ),
                                                ],
                                              ),
                                              
                                              if (isExpanded) ...[
                                                const SizedBox(height: 12),
                                                Container(
                                                  padding: const EdgeInsets.all(12),
                                                  decoration: BoxDecoration(
                                                    color: _getEventColor(event.type).withValues(alpha: 0.1),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        _getEventTypeText(event.type),
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w600,
                                                          color: _getEventColor(event.type),
                                                        ),
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Text(
                                                        event.description,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Color(0xFF6B7280),
                                                          height: 1.5,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Adicionar evento'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
        backgroundColor: const Color(0xFF6366F1),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildCalendarGrid() {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(_focusedDay.year, _focusedDay.month, 1);
    final lastDayOfMonth = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
    final firstWeekday = firstDayOfMonth.weekday;
    final daysInMonth = lastDayOfMonth.day;
    
    // Calcular quantas semanas precisamos mostrar
    final numWeeks = ((daysInMonth + firstWeekday - 1) / 7).ceil();
    
    return Column(
      children: List.generate(numWeeks, (weekIndex) {
        return Row(
          children: List.generate(7, (dayIndex) {
            final dayNumber = (weekIndex * 7 + dayIndex + 1) - firstWeekday + 1;
            
            if (dayNumber < 1 || dayNumber > daysInMonth) {
              return const Expanded(child: SizedBox(height: 48));
            }
            
            final currentDay = DateTime(_focusedDay.year, _focusedDay.month, dayNumber);
            final isSelected = _selectedDay != null &&
                currentDay.year == _selectedDay!.year &&
                currentDay.month == _selectedDay!.month &&
                currentDay.day == _selectedDay!.day;
            final isToday = currentDay.year == now.year &&
                currentDay.month == now.month &&
                currentDay.day == now.day;
            final hasEvents = _getEventsForDay(currentDay).isNotEmpty;
            
            return Expanded(
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedDay = currentDay;
                    _expandedEventIndex = null;
                  });
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 48,
                  margin: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: isSelected 
                        ? const Color(0xFF6366F1) 
                        : isToday 
                            ? const Color(0xFF6366F1).withValues(alpha: 0.1) 
                            : null,
                    borderRadius: BorderRadius.circular(8),
                    border: isToday && !isSelected 
                        ? Border.all(color: const Color(0xFF6366F1), width: 2) 
                        : null,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        dayNumber.toString(),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isSelected 
                              ? Colors.white 
                              : isToday 
                                  ? const Color(0xFF6366F1) 
                                  : const Color(0xFF374151),
                        ),
                      ),
                      if (hasEvents)
                        Container(
                          width: 6,
                          height: 6,
                          margin: const EdgeInsets.only(top: 2),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : const Color(0xFF6366F1),
                            shape: BoxShape.circle,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
  List<CalendarEvent> _getEventsForDay(DateTime day) {
    return widget.events.where((event) {
      return event.date.year == day.year &&
             event.date.month == day.month &&
             event.date.day == day.day;
    }).toList();
  }

  List<String> _formatWeekDay() {
    return ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];
  }

  String _formatMonthYear(DateTime date) {
    final months = [
      'Janeiro', 'Fevereiro', 'Março', 'Abril', 'Maio', 'Junho',
      'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  Color _getEventColor(String type) {
    switch (type.toLowerCase()) {
      case 'prova':
        return const Color(0xFFEF4444);
      case 'trabalho':
        return const Color(0xFFF59E0B);
      case 'aula':
        return const Color(0xFF3B82F6);
      case 'evento':
        return const Color(0xFF8B5CF6);
      default:
        return const Color(0xFF6B7280);
    }
  }

  IconData _getEventTypeIcon(String type) {
    switch (type.toLowerCase()) {
      case 'prova':
        return Icons.quiz;
      case 'trabalho':
        return Icons.assignment;
      case 'aula':
        return Icons.school;
      case 'evento':
        return Icons.event;
      default:
        return Icons.circle;
    }
  }

  String _getEventTypeText(String type) {
    switch (type.toLowerCase()) {
      case 'prova':
        return 'PROVA';
      case 'trabalho':
        return 'TRABALHO';
      case 'aula':
        return 'AULA';
      case 'evento':
        return 'EVENTO';
      default:
        return type.toUpperCase();
    }
  }
}
