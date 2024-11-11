import 'package:flutter/material.dart';
import 'package:my_simple_note/screens/home_screen.dart';
import 'package:my_simple_note/services/note_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => NoteProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Simple Note',
      home: const HomeScreen(),
    );
  }
}

