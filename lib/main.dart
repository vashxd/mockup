import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/report_card_screen.dart';
import 'screens/subject_detail_screen.dart';
import 'screens/documents_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/eclass_screen.dart';
import 'screens/eclass_course_detail_screen.dart';
import 'screens/activities_screen_new.dart';
import 'screens/calendar_screen_new.dart';
import 'screens/profile_screen.dart';
import 'data/mock_data.dart';
import 'models/student.dart';
import 'models/subject.dart';
import 'models/eclass_course.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Definir a orientação do aplicativo para retrato apenas (apenas em dispositivos móveis)
  // No ambiente web, não limitamos a orientação
  if (!kIsWeb) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
  
  // Definir a cor da barra de status
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFF003366),
    statusBarIconBrightness: Brightness.light,
  ));
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final mockData = MockData();
    final mockSubjects = mockData.getSubjects();
    final mockDocuments = mockData.getDocuments();
    final mockNotifications = mockData.getNotifications();
    final mockEClassCourses = mockData.getEClassCourses();
    final mockActivities = mockData.getActivities();
    final mockCalendarEvents = mockData.getCalendarEvents();
      return MaterialApp(
            title: 'Escola App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF6366F1), // Indigo moderno
                brightness: Brightness.light,
                primary: const Color(0xFF6366F1),
                secondary: const Color(0xFF8B5CF6),                surface: const Color(0xFFFAFAFA),
                error: const Color(0xFFEF4444),
              ),
              scaffoldBackgroundColor: const Color(0xFFF8FAFC),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF6366F1),
                foregroundColor: Colors.white,
                elevation: 0,
                centerTitle: true,
                titleTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),              cardTheme: CardTheme(
                elevation: 2,
                shadowColor: Colors.black.withValues(alpha: 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.white,
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shadowColor: Colors.black.withValues(alpha: 0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  textStyle: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFF6366F1), width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
              textTheme: const TextTheme(
                headlineLarge: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1F2937),
                ),
                headlineMedium: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
                titleLarge: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2937),
                ),
                titleMedium: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF374151),
                ),
                bodyLarge: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF374151),
                ),
                bodyMedium: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6B7280),
                ),
              ),
            ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) {
          final student = ModalRoute.of(context)!.settings.arguments as Student? ?? 
              MockData().getStudents().first;
          return HomeScreen(student: student);
        },
        '/profile': (context) {
          final student = ModalRoute.of(context)!.settings.arguments as Student? ?? 
              MockData().getStudents().first;
          return ProfileScreen(student: student);
        },
        '/report_card': (context) {
          final student = ModalRoute.of(context)!.settings.arguments as Student? ?? 
              MockData().getStudents().first;
          return ReportCardScreen(
            student: student,
            subjects: mockSubjects,
            totalAbsences: mockData.getTotalAbsences(),
            totalFrequency: mockData.getAverageFrequency(),
          );
        },
        '/documents': (context) {
          final student = ModalRoute.of(context)!.settings.arguments as Student? ?? 
              MockData().getStudents().first;
          return DocumentsScreen(
            student: student,
            documents: mockDocuments,
          );
        },
        '/notifications': (context) {
          final student = ModalRoute.of(context)!.settings.arguments as Student? ?? 
              MockData().getStudents().first;
          return NotificationsScreen(
            student: student,
            notifications: mockNotifications,
          );
        },
        '/eclass': (context) {
          final student = ModalRoute.of(context)!.settings.arguments as Student? ?? 
              MockData().getStudents().first;
          return EClassScreen(
            student: student,
            courses: mockEClassCourses,
          );
        },        '/activities': (context) {
          final student = ModalRoute.of(context)!.settings.arguments as Student? ?? 
              MockData().getStudents().first;
          return ActivitiesScreen(
            student: student,
            activities: mockActivities,
          );
        },
        '/calendar': (context) {
          final student = ModalRoute.of(context)!.settings.arguments as Student? ?? 
              MockData().getStudents().first;
          return CalendarScreen(
            student: student,
            events: mockCalendarEvents,
          );
        },
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/subject_detail') {
          final subject = settings.arguments as Subject;
          return MaterialPageRoute(
            builder: (context) => SubjectDetailScreen(subject: subject),
          );
        } else if (settings.name == '/eclass_course_detail') {
          final course = settings.arguments as EClassCourse;
          return MaterialPageRoute(
            builder: (context) => EClassCourseDetailScreen(course: course),
          );
        }
        return null;
      },
    );
  }
}
