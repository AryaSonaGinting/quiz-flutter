import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/question.dart';
import 'screens/home_screen.dart';
import 'state/quiz_session.dart';

class QuizNovaApp extends StatefulWidget {
  const QuizNovaApp({super.key});

  @override
  State<QuizNovaApp> createState() => _QuizNovaAppState();
}

class _QuizNovaAppState extends State<QuizNovaApp> {
  ThemeMode _themeMode = ThemeMode.light;
  late final QuizSession _session;

  @override
  void initState() {
    super.initState();
    _session = QuizSession(questions: sampleQuestions);
  }

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.light
          ? ThemeMode.dark
          : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    final baseTextTheme = GoogleFonts.nunitoTextTheme();
    return MaterialApp(
      title: 'Quiz Nova',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7657F6),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F6FC),
        textTheme: GoogleFonts.nunitoTextTheme(
          ThemeData.light().textTheme,
        ).apply(bodyColor: const Color(0xFF24213A), displayColor: const Color(0xFF24213A)),
        cardTheme: const CardThemeData(
          elevation: 0,
          color: Colors.white,
          margin: EdgeInsets.zero,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF9B87FF),
          brightness: Brightness.dark,
        ),
        textTheme: baseTextTheme.apply(
          bodyColor: const Color(0xFFF5F2FF),
          displayColor: const Color(0xFFF5F2FF),
        ),
        scaffoldBackgroundColor: const Color(0xFF151322),
        cardTheme: const CardThemeData(
          elevation: 0,
          color: Color(0xFF211E33),
          margin: EdgeInsets.zero,
        ),
      ),
      home: HomeScreen(
        session: _session,
        isDark: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}
