import 'package:flutter/material.dart';
import '../models/student.dart';
import '../models/calendar_event.dart';

class CalendarScreen extends StatefulWidget {
  final Student student;
  final List<CalendarEvent> events;

  const CalendarScreen({
    Key? key,
    required this.student,
    required this.events,
  }) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  int _expandedEventIndex = -1;
  
  // Formatar datas manualmente já que estamos mockando
  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }
  
  String _formatMonthYear(DateTime date) {
    List<String> months = [
      '', 'JANEIRO', 'FEVEREIRO', 'MARÇO', 'ABRIL', 'MAIO', 'JUNHO',
      'JULHO', 'AGOSTO', 'SETEMBRO', 'OUTUBRO', 'NOVEMBRO', 'DEZEMBRO'
    ];
    return "${months[date.month]} ${date.year}";
  }
  
  String _formatWeekDay(DateTime date) {
    List<String> days = ['DOM', 'SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SAB'];
    return days[date.weekday % 7];
  }
  
  String _formatDay(DateTime date) {
    return date.day.toString();
  }
  
  @override
  Widget build(BuildContext context) {
    // Filtrar eventos para o dia selecionado
    final selectedDayEvents = widget.events
        .where((event) => isSameDay(event.date, _selectedDay))
        .toList();
    
    // Calcular o primeiro dia do mês exibido
    final firstDayOfMonth = DateTime(_focusedDay.year, _focusedDay.month, 1);
    
    // Calcular o último dia do mês exibido
    final lastDayOfMonth = DateTime(_focusedDay.year, _focusedDay.month + 1, 0);
    
    // Calcular o número de dias no mês atual
    final daysInMonth = lastDayOfMonth.day;
    
    // Determinar em qual dia da semana (0-6) começa o mês
    final firstWeekday = firstDayOfMonth.weekday % 7; // 0 = domingo, 6 = sábado
    
    // Número de semanas para exibir no calendário
    final numWeeks = ((daysInMonth + firstWeekday) / 7).ceil();
    
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
              'Calendário',
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
              'Calendário Escolar',
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
          
          // Controle do mês
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.chevron_left),
                  onPressed: () {
                    setState(() {
                      _focusedDay = DateTime(
                        _focusedDay.year,
                        _focusedDay.month - 1,
                        1,
                      );
                    });
                  },
                ),
                Text(
                  _formatMonthYear(_focusedDay),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.chevron_right),
                  onPressed: () {
                    setState(() {
                      _focusedDay = DateTime(
                        _focusedDay.year,
                        _focusedDay.month + 1,
                        1,
                      );
                    });
                  },
                ),
              ],
            ),
          ),
          
          // Dias da semana
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                for (int i = 0; i < 7; i++)
                  Expanded(
                    child: Center(
                      child: Text(
                        _formatWeekDay(
                          DateTime(2022, 1, i + 2) // 2 de janeiro de 2022 foi domingo
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: i == 0 || i == 6 ? Colors.red[300] : Colors.grey[700],
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          
          // Calendário
          Container(
            margin: const EdgeInsets.all(8.0),
            height: 300,
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                childAspectRatio: 1,
              ),
              itemCount: numWeeks * 7,
              itemBuilder: (context, index) {
                // Calcular data para esta célula
                final dayNumber = index - firstWeekday + 1;
                
                // Verificar se o dia está no mês atual
                final isInCurrentMonth = dayNumber >= 1 && dayNumber <= daysInMonth;
                
                // Data deste dia
                final cellDate = isInCurrentMonth
                    ? DateTime(_focusedDay.year, _focusedDay.month, dayNumber)
                    : DateTime(_focusedDay.year, _focusedDay.month + (dayNumber > 0 ? 0 : -1), dayNumber > 0 ? dayNumber : DateTime(_focusedDay.year, _focusedDay.month, 0).day + dayNumber);
                
                // Verificar se o dia é hoje
                final isToday = isSameDay(cellDate, DateTime.now());
                
                // Verificar se o dia está selecionado
                final isSelected = isSameDay(cellDate, _selectedDay);
                
                // Verificar se há eventos neste dia
                final hasEvents = widget.events.any((event) => isSameDay(event.date, cellDate));
                
                // Cor de fundo da célula
                Color? backgroundColor;
                if (isSelected) {
                  backgroundColor = const Color(0xFF003366);
                } else if (isToday) {
                  backgroundColor = Colors.blue[100];
                }
                
                return GestureDetector(
                  onTap: isInCurrentMonth ? () {
                    setState(() {
                      _selectedDay = cellDate;
                      _expandedEventIndex = -1;
                    });
                  } : null,
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isInCurrentMonth 
                            ? (isSelected 
                                ? const Color(0xFF003366) 
                                : (isToday ? Colors.blue : Colors.transparent))
                            : Colors.transparent,
                        width: 1,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Número do dia
                        Center(
                          child: Text(
                            dayNumber.toString(),
                            style: TextStyle(
                              color: !isInCurrentMonth 
                                  ? Colors.grey[400] 
                                  : (isSelected 
                                      ? Colors.white 
                                      : (isToday ? Colors.blue[800] : null)),
                              fontWeight: isToday || isSelected ? FontWeight.bold : null,
                            ),
                          ),
                        ),
                        
                        // Indicador de evento
                        if (hasEvents && isInCurrentMonth)
                          Positioned(
                            bottom: 4,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    color: isSelected ? Colors.white : Colors.blue[700],
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Eventos do dia selecionado - Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF003366),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    _formatDate(_selectedDay),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'Eventos: ${selectedDayEvents.length}',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Lista de eventos do dia selecionado
          Expanded(
            child: selectedDayEvents.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_busy,
                          size: 64,
                          color: Colors.grey[400],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nenhum evento para este dia',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: selectedDayEvents.length,
                    itemBuilder: (context, index) {
                      final event = selectedDayEvents[index];
                      final isExpanded = _expandedEventIndex == index;
                      
                      // Formatação do horário
                      String timeText = '';
                      if (event.startTime != null) {
                        timeText = '${event.startTime!.format(context)}';
                        if (event.endTime != null) {
                          timeText += ' - ${event.endTime!.format(context)}';
                        }
                      }
                      
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _expandedEventIndex = isExpanded ? -1 : index;
                            });
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: _getEventColor(event.type).withOpacity(0.2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    _getEventTypeIcon(event.type),
                                    color: _getEventColor(event.type),
                                  ),
                                ),
                                title: Text(
                                  event.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  timeText.isNotEmpty ? timeText : 'Dia todo',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                trailing: Icon(
                                  isExpanded ? Icons.expand_less : Icons.expand_more,
                                ),
                              ),
                              if (isExpanded)
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Divider(),
                                      Text(
                                        event.description,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      if (event.location != null) ...[
                                        const SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              size: 16,
                                              color: Colors.grey[700],
                                            ),
                                            const SizedBox(width: 4),
                                            Text(
                                              event.location!,
                                              style: TextStyle(
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                      const SizedBox(height: 16),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: _getEventColor(event.type).withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: Text(
                                          _getEventTypeText(event.type),
                                          style: TextStyle(
                                            color: _getEventColor(event.type),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
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
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Adicionar novo evento ao calendário'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        backgroundColor: const Color(0xFF003366),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
  
  // Verifica se duas datas são o mesmo dia
  bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }
  
  // Retorna o ícone para o tipo de evento
  IconData _getEventTypeIcon(String type) {
    switch (type) {
      case 'class':
        return Icons.school;
      case 'exam':
        return Icons.assignment;
      case 'holiday':
        return Icons.beach_access;
      case 'event':
        return Icons.event;
      case 'reminder':
        return Icons.alarm;
      default:
        return Icons.calendar_today;
    }
  }
  
  // Retorna o texto para o tipo de evento
  String _getEventTypeText(String type) {
    switch (type) {
      case 'class':
        return 'AULA';
      case 'exam':
        return 'PROVA';
      case 'holiday':
        return 'FERIADO/RECESSO';
      case 'event':
        return 'EVENTO';
      case 'reminder':
        return 'LEMBRETE';
      default:
        return 'OUTRO';
    }
  }
  
  // Retorna a cor para o tipo de evento
  Color _getEventColor(String type) {
    switch (type) {
      case 'class':
        return Colors.blue;
      case 'exam':
        return Colors.red;
      case 'holiday':
        return Colors.purple;
      case 'event':
        return Colors.green;
      case 'reminder':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}