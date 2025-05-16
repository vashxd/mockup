import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/home_screen.dart';
import 'screens/report_card_screen.dart';
import 'screens/subject_detail_screen.dart';
import 'data/mock_data.dart';
import 'models/subject.dart';

void main() {
  // Definir a orientação do aplicativo para retrato apenas
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
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
    return MaterialApp(
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
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(student: mockStudent),
        '/report_card': (context) => ReportCardScreen(
              student: mockStudent,
              subjects: mockSubjects,
              totalAbsences: getTotalAbsences(),
              totalFrequency: getAverageFrequency(),
            ),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/subject_detail') {
          final subject = settings.arguments as Subject;
          return MaterialPageRoute(
            builder: (context) => SubjectDetailScreen(subject: subject),
          );
        }
        return null;
      },
    );
  }
}
