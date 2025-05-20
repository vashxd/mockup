import 'package:flutter/material.dart';

class CalendarEvent {
  final String id;
  final String title;
  final String description;
  final DateTime date;
  final TimeOfDay? startTime;
  final TimeOfDay? endTime;
  final String type; // 'class', 'exam', 'holiday', 'event', 'reminder'
  final String? location;
  final Color color;

  CalendarEvent({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    this.startTime,
    this.endTime,
    required this.type,
    this.location,
    Color? color,
  }) : color = color ?? _getDefaultColorForType(type);

  // Retorna true se o evento acontecer em uma determinada data
  bool isOnDate(DateTime date) {
    return this.date.year == date.year &&
           this.date.month == date.month &&
           this.date.day == date.day;
  }

  // Determina a cor padrão do evento com base no tipo
  static Color _getDefaultColorForType(String type) {
    switch (type) {
      case 'class':
        return Colors.blue;
      case 'exam':
        return Colors.red;
      case 'holiday':
        return Colors.green;
      case 'event':
        return Colors.purple;
      case 'reminder':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}