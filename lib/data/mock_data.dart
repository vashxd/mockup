import '../models/student.dart';
import '../models/subject.dart';
import '../models/document.dart';
import '../models/notification.dart' as app_notification;
import '../models/eclass_course.dart';
import '../models/eclass_material.dart';
import '../models/activity.dart';
import '../models/calendar_event.dart';
import '../models/chat_conversation.dart';
import 'package:flutter/material.dart';

class MockData {
  // Dados mockados do aluno
  Student getMockStudent() {
    return Student(
      name: 'Sâmilly Cavalcante Barbosa Porto',
      grade: '8º Ano',
      period: 'Tarde',
      classId: 'A',
      profileImagePath: 'assets/images/profile_image.jfif',
    );
  }
  
  // Lista de estudantes mockados
  List<Student> getStudents() {
    return [
      Student(
        name: 'Sâmilly Cavalcante Barbosa Porto',
        grade: '8º Ano',
        period: 'Tarde',
        classId: 'A',
        profileImagePath: 'assets/images/profile_image.jfif',
      ),
      Student(
        name: 'Lucas Mendes',
        grade: '8º Ano',
        period: 'Tarde',
        classId: 'A',
        profileImagePath: null,
      ),
      Student(
        name: 'Juliana Almeida',
        grade: '8º Ano',
        period: 'Tarde',
        classId: 'A',
        profileImagePath: null,
      ),
    ];
  }

  // Dados mockados das disciplinas
  List<Subject> getSubjects() {
    return [
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
  }

  // Dados mockados dos documentos
  List<Document> getDocuments() {
    return [
      Document(
        title: 'Declaração de Matrícula',
        type: 'Declaração',
        date: '20/05/2025',
        isAvailable: true,
        description: 'Declaração de matrícula para o ano letivo 2025',
      ),
      Document(
        title: 'Histórico Escolar',
        type: 'Histórico',
        date: '20/05/2025',
        isAvailable: true,
        description: 'Histórico escolar completo até o momento',
      ),
      Document(
        title: 'Certificado de Conclusão',
        type: 'Certificado',
        date: '20/05/2025',
        isAvailable: false,
        description: 'Certificado de conclusão do ensino fundamental',
      ),
      Document(
        title: 'Comprovante de Pagamento',
        type: 'Financeiro',
        date: '15/05/2025',
        isAvailable: true,
        description: 'Comprovante de pagamento da mensalidade de Maio',
      ),
      Document(
        title: 'Contrato Educacional',
        type: 'Contrato',
        date: '15/01/2025',
        isAvailable: true,
        description: 'Contrato educacional para o ano letivo de 2025',
      ),
    ];
  }

  // Dados mockados das notificações
  List<app_notification.Notification> getNotifications() {
    return [
      app_notification.Notification(
        title: 'Atividade Avaliativa',
        message: 'Nova atividade avaliativa de Matemática disponível para 20/05/2025.',
        date: '19/05/2025 - 14:30',
        type: 'Acadêmico',
        isRead: false,
      ),
      app_notification.Notification(
        title: 'Reunião de Pais',
        message: 'Lembramos que a reunião de pais acontecerá dia 25/05/2025 às 19:00.',
        date: '18/05/2025 - 10:15',
        type: 'Evento',
        isRead: true,
      ),
      app_notification.Notification(
        title: 'Boleto Disponível',
        message: 'O boleto referente à mensalidade de Junho já está disponível na área financeira.',
        date: '17/05/2025 - 08:00',
        type: 'Financeiro',
        isRead: true,
      ),
      app_notification.Notification(
        title: 'Alteração no Calendário',
        message: 'Avisamos que haverá recesso escolar nos dias 30 e 31 de maio devido a manutenção no sistema elétrico da escola.',
        date: '16/05/2025 - 16:45',
        type: 'Institucional',
        isRead: false,
      ),
      app_notification.Notification(
        title: 'Resultado de Prova',
        message: 'As notas da avaliação de Ciências foram lançadas. Confira no boletim.',
        date: '15/05/2025 - 11:20',
        type: 'Acadêmico',
        isRead: true,
      ),
    ];
  }
  // Dados mockados do e-Class
  List<EClassCourse> getEClassCourses() {
    return [
      EClassCourse(
        id: '1',
        name: 'Matemática',
        teacher: 'Prof. Ricardo Silva',
        imageUrl: 'https://placehold.co/200x120/2196F3/FFFFFF?text=Matemática',
        progress: 0.75,
        materialsCount: 12,
        activitiesCount: 8,
        subject: 'Matemática',
        title: 'Matemática - 8º Ano',
        description: 'Curso completo de matemática para o 8º ano do ensino fundamental',
        totalLessons: 24,
        duration: 48,
        level: 'Intermediário',
        newMaterials: 2,
      ),
      EClassCourse(
        id: '2',
        name: 'Português',
        teacher: 'Profa. Ana Beatriz Costa',
        imageUrl: 'https://placehold.co/200x120/4CAF50/FFFFFF?text=Português',
        progress: 0.60,
        materialsCount: 15,
        activitiesCount: 7,
        subject: 'Português',
        title: 'Português - 8º Ano',
        description: 'Curso de língua portuguesa com foco em gramática e literatura',
        totalLessons: 30,
        duration: 60,
        level: 'Intermediário',
        newMaterials: 1,
      ),
      EClassCourse(
        id: '3',
        name: 'História',
        teacher: 'Prof. Carlos Eduardo',
        imageUrl: 'https://placehold.co/200x120/FF9800/FFFFFF?text=História',
        progress: 0.40,
        materialsCount: 10,
        activitiesCount: 5,
        subject: 'História',
        title: 'História - 8º Ano',
        description: 'História do Brasil e História Geral',
        totalLessons: 20,
        duration: 40,
        level: 'Básico',
        newMaterials: 0,
      ),
      EClassCourse(
        id: '4',
        name: 'Geografia',
        teacher: 'Profa. Mariana Lima',
        imageUrl: 'https://placehold.co/200x120/9C27B0/FFFFFF?text=Geografia',
        progress: 0.85,
        materialsCount: 8,
        activitiesCount: 6,
        subject: 'Geografia',
        title: 'Geografia - 8º Ano',
        description: 'Geografia física e humana do Brasil e do mundo',
        totalLessons: 18,
        duration: 36,
        level: 'Intermediário',
        newMaterials: 3,
      ),
      EClassCourse(
        id: '5',
        name: 'Ciências',
        teacher: 'Prof. Roberto Santos',
        imageUrl: 'https://placehold.co/200x120/795548/FFFFFF?text=Ciências',
        progress: 0.65,
        materialsCount: 14,
        activitiesCount: 9,
        subject: 'Ciências',
        title: 'Ciências - 8º Ano',
        description: 'Física, Química e Biologia aplicadas ao ensino fundamental',
        totalLessons: 26,
        duration: 52,
        level: 'Intermediário',
        newMaterials: 1,
      ),
    ];
  }

  // Materiais mockados para o curso de Matemática
  List<EClassMaterial> getMathMaterials() {
    return [
      EClassMaterial(
        id: 'm1',
        title: 'Introdução à Álgebra',
        description: 'Material introdutório sobre conceitos básicos de álgebra',
        type: 'pdf',
        date: '10/05/2025',
        isCompleted: true,
        isNew: false,
      ),
      EClassMaterial(
        id: 'm2',
        title: 'Vídeo: Equações de Primeiro Grau',
        description: 'Aula gravada sobre resolução de equações',
        type: 'video',
        date: '12/05/2025',
        isCompleted: true,
        isNew: false,
      ),
      EClassMaterial(
        id: 'm3',
        title: 'Exercícios Complementares',
        description: 'Lista de exercícios para praticar o conteúdo aprendido',
        type: 'pdf',
        date: '15/05/2025',
        isCompleted: false,
        isNew: true,
      ),
      EClassMaterial(
        id: 'm4',
        title: 'Vídeo: Geometria Plana',
        description: 'Aula sobre cálculo de área e perímetro de figuras planas',
        type: 'video',
        date: '18/05/2025',
        isCompleted: false,
        isNew: true,
      ),
    ];
  }

  // Atividades mockadas para o curso de Matemática
  List<EClassActivity> getMathActivities() {
    return [
      EClassActivity(
        id: 'a1',
        title: 'Quiz: Operações Básicas',
        description: 'Teste seus conhecimentos em operações matemáticas básicas',
        dueDate: '12/05/2025',
        submitDate: '11/05/2025',
        isCompleted: true,
        grade: 8.5,
        maxGrade: 10,
        isLate: false,
      ),
      EClassActivity(
        id: 'a2',
        title: 'Trabalho: Funções Quadráticas',
        description: 'Desenvolva um trabalho sobre funções do segundo grau',
        dueDate: '18/05/2025',
        submitDate: '19/05/2025',
        isCompleted: true,
        grade: 7.0,
        maxGrade: 10,
        isLate: true,
      ),
      EClassActivity(
        id: 'a3',
        title: 'Prova Bimestral',
        description: 'Avaliação cobrindo todo o conteúdo do bimestre',
        dueDate: '25/05/2025',
        isCompleted: false,
        maxGrade: 10,
        isLate: false,
      ),
    ];
  }

  // Atividades mockadas para o módulo de atividades
  List<Activity> getActivities() {
    return [
      Activity(
        id: 'atv1',
        title: 'Lista de Exercícios de Álgebra',
        description: 'Resolver os exercícios 1 a 15 da página 45 do livro de matemática',
        subject: 'Matemática',
        dueDate: '21/05/2025',
        teacher: 'Prof. Ricardo Silva',
        type: 'homework',
        isCompleted: false,
        isLate: false,
        priority: 3, // alta
      ),
      Activity(
        id: 'atv2',
        title: 'Redação: Meio Ambiente',
        description: 'Escrever uma redação de 20 a 30 linhas sobre questões ambientais contemporâneas',
        subject: 'Português',
        dueDate: '23/05/2025',
        teacher: 'Profa. Ana Beatriz Costa',
        type: 'project',
        isCompleted: false,
        isLate: false,
        priority: 2, // média
      ),
      Activity(
        id: 'atv3',
        title: 'Prova Bimestral de História',
        description: 'Revisão completa do conteúdo do bimestre para a prova de História',
        subject: 'História',
        dueDate: '25/05/2025',
        teacher: 'Prof. Carlos Eduardo',
        type: 'exam',
        isCompleted: false,
        isLate: false,
        priority: 3, // alta
      ),
      Activity(
        id: 'atv4',
        title: 'Leitura do Livro "Dom Casmurro"',
        description: 'Ler os capítulos 1 a 15 do livro Dom Casmurro, de Machado de Assis',
        subject: 'Português',
        dueDate: '28/05/2025',
        teacher: 'Profa. Ana Beatriz Costa',
        type: 'reading',
        isCompleted: false,
        isLate: false,
        priority: 1, // baixa
      ),
      Activity(
        id: 'atv5',
        title: 'Projeto de Ciências: Ecossistemas',
        description: 'Elaborar uma maquete de um ecossistema à sua escolha, aplicando os conceitos estudados',
        subject: 'Ciências',
        dueDate: '30/05/2025',
        teacher: 'Prof. Roberto Santos',
        type: 'project',
        isCompleted: false,
        isLate: false,
        priority: 2, // média
        attachmentUrl: 'https://example.com/instrucoes_projeto_ciencias.pdf',
      ),
      Activity(
        id: 'atv6',
        title: 'Exercícios de Interpretação de Texto',
        description: 'Responder às questões 1 a 10 do texto "A importância da leitura"',
        subject: 'Português',
        dueDate: '19/05/2025',
        teacher: 'Profa. Ana Beatriz Costa',
        type: 'homework',
        isCompleted: true,
        isLate: false,
        priority: 2, // média
      ),
      Activity(
        id: 'atv7',
        title: 'Trabalho sobre Capitais Europeias',
        description: 'Elaborar uma apresentação sobre as principais capitais europeias e suas características',
        subject: 'Geografia',
        dueDate: '15/05/2025',
        teacher: 'Profa. Mariana Lima',
        type: 'project',
        isCompleted: true,
        isLate: true,
        priority: 2, // média
      ),
    ];
  }

  // Eventos mockados para o calendário
  List<CalendarEvent> getCalendarEvents() {
    // Usando a data atual para criar eventos recentes (20/05/2025)
    final DateTime currentDate = DateTime(2025, 5, 20);
    
    return [
      // Eventos hoje
      CalendarEvent(
        id: 'evt1',
        title: 'Prova de Matemática',
        description: 'Avaliação bimestral de Álgebra e Geometria',
        date: currentDate,
        startTime: const TimeOfDay(hour: 10, minute: 0),
        endTime: const TimeOfDay(hour: 11, minute: 30),
        type: 'exam',
        location: 'Sala 8A',
      ),
      
      // Eventos próximos
      CalendarEvent(
        id: 'evt2',
        title: 'Entrega de Trabalho',
        description: 'Prazo final para entrega do trabalho de Geografia sobre capitais europeias',
        date: DateTime(2025, 5, 22),
        type: 'reminder',
      ),
      CalendarEvent(
        id: 'evt3',
        title: 'Feira de Ciências',
        description: 'Apresentação dos trabalhos de ciências no auditório',
        date: DateTime(2025, 5, 24),
        startTime: const TimeOfDay(hour: 8, minute: 0),
        endTime: const TimeOfDay(hour: 16, minute: 0),
        type: 'event',
        location: 'Auditório Principal',
      ),
      CalendarEvent(
        id: 'evt4',
        title: 'Reunião de Pais',
        description: 'Reunião bimestral de pais e mestres',
        date: DateTime(2025, 5, 25),
        startTime: const TimeOfDay(hour: 19, minute: 0),
        endTime: const TimeOfDay(hour: 21, minute: 0),
        type: 'event',
        location: 'Sala de Reuniões',
      ),
      
      // Eventos recorrentes (aulas)
      CalendarEvent(
        id: 'evt5',
        title: 'Aula de Matemática',
        description: 'Aula regular de Matemática',
        date: DateTime(2025, 5, 21),
        startTime: const TimeOfDay(hour: 7, minute: 30),
        endTime: const TimeOfDay(hour: 9, minute: 10),
        type: 'class',
        location: 'Sala 8A',
      ),
      CalendarEvent(
        id: 'evt6',
        title: 'Aula de Português',
        description: 'Aula regular de Português',
        date: DateTime(2025, 5, 21),
        startTime: const TimeOfDay(hour: 9, minute: 30),
        endTime: const TimeOfDay(hour: 11, minute: 10),
        type: 'class',
        location: 'Sala 8A',
      ),
      
      // Feriado
      CalendarEvent(
        id: 'evt7',
        title: 'Recesso Escolar',
        description: 'Recesso devido à manutenção do sistema elétrico da escola',
        date: DateTime(2025, 5, 30),
        type: 'holiday',
      ),
      CalendarEvent(
        id: 'evt8',
        title: 'Recesso Escolar',
        description: 'Recesso devido à manutenção do sistema elétrico da escola',
        date: DateTime(2025, 5, 31),
        type: 'holiday',
      ),
      
      // Eventos do mês anterior
      CalendarEvent(
        id: 'evt9',
        title: 'Prova de Português',
        description: 'Avaliação bimestral de Literatura e Gramática',
        date: DateTime(2025, 4, 25),
        startTime: const TimeOfDay(hour: 10, minute: 0),
        endTime: const TimeOfDay(hour: 11, minute: 30),
        type: 'exam',
        location: 'Sala 8A',
      ),
      
      // Eventos do próximo mês
      CalendarEvent(
        id: 'evt10',
        title: 'Início das Férias',
        description: 'Início das férias escolares',
        date: DateTime(2025, 6, 30),
        type: 'holiday',
      ),
    ];
  }

  // ID do aluno para simulação do chat
  final String currentUserId = 'student1';

  // For mockup purposes, simplified chat functionality
  List<ChatConversation> getMockConversations() {
    // Simplified for mockup
    return [];
  }

  // Cálculo de faltas totais
  int getTotalAbsences() {
    int total = 0;
    for (var subject in getSubjects()) {
      total += subject.absences;
    }
    return total;
  }

  // Cálculo de frequência média
  double getAverageFrequency() {
    double total = 0;
    for (var subject in getSubjects()) {
      total += subject.frequency;
    }
    return total / getSubjects().length;
  }

  // Método para obter lições de um curso específico
  List<EClassMaterial> getLessonsForCourse(String courseId) {
    // Para simplicidade, retornamos os materiais de matemática para todos os cursos
    return getMathMaterials();
  }
  
  // Método para obter materiais de um curso específico
  List<EClassMaterial> getMaterialsForCourse(String courseId) {
    // Para simplicidade, retornamos os materiais de matemática para todos os cursos
    return getMathMaterials();
  }

  // Dados mockados para o módulo de comunicação
  Map<String, dynamic> getCommunicationData() {
    final Student student = getMockStudent();
    final List<ChatConversation> conversations = getMockConversations();
    
    return {
      'student': student,
      'conversations': conversations,
    };
  }
}