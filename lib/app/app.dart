import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:student_flow/app/router.dart';
import 'package:student_flow/app/theme.dart';

class StudentFlowApp extends StatefulWidget {
  const StudentFlowApp({super.key});

  @override
  State<StudentFlowApp> createState() => _StudentFlowAppState();
}

class _StudentFlowAppState extends State<StudentFlowApp> {
  final _router = buildAppRouter();

  @override
  void dispose() {
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'StudentFlow',
      debugShowCheckedModeBanner: false,
      theme: buildStudentFlowTheme(),
      routerConfig: _router,
      locale: const Locale('en', 'CA'),
      supportedLocales: const [Locale('en', 'CA')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
