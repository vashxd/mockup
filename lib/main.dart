import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/report_card_screen.dart';
import 'screens/subject_detail_screen.dart';
import 'screens/documents_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/eclass_screen.dart';
import 'screens/eclass_course_detail_screen.dart';
import 'screens/activities_screen.dart';
import 'screens/calendar_screen.dart';
import 'screens/profile_screen.dart';
import 'data/mock_data.dart';
import 'models/student.dart';
import 'models/subject.dart';
import 'models/eclass_course.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Definir a orientação do aplicativo para retrato apenas
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  // Definir a cor da barra de status
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF003366),
      statusBarIconBrightness: Brightness.light,
    ));
  }
  
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
    
    return Platform.isIOS
        ? CupertinoApp(
            title: 'Escola App',
            debugShowCheckedModeBanner: false,
            theme: const CupertinoThemeData(
              primaryColor: Color(0xFF003366),
              primaryContrastingColor: Colors.white,
              barBackgroundColor: Color(0xFF003366),
              scaffoldBackgroundColor: Colors.white,
              textTheme: CupertinoTextThemeData(
                primaryColor: Color(0xFF003366),
              ),
            ),
            home: const LoginScreen(),
            routes: {
              '/home': (context) {
                final student = ModalRoute.of(context)!.settings.arguments as Student;
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
              },
              '/activities': (context) {
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
          )
        : MaterialApp(
            title: 'Escola App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: const Color(0xFF003366),
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF003366),
                primary: const Color(0xFF003366),
              ),
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF003366),
                foregroundColor: Colors.white,
                elevation: 0,
              ),
            ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) {
          final student = ModalRoute.of(context)!.settings.arguments as Student;
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
        },
        '/activities': (context) {
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
