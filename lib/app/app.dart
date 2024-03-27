import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:memestorm/themes.dart';
import 'package:memestorm/view/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MemeStorm',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: Mythemes.lightColorScheme,
        fontFamily: GoogleFonts.dmSans().fontFamily,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: Mythemes.darkColorScheme,
        fontFamily: GoogleFonts.dmSans().fontFamily,
      ),
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      home: HomeView(),
    );
  }
}