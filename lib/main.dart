import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:note_app/di/service_locator.dart';
import 'package:note_app/providers/note_provider.dart';
import 'package:note_app/ui/note_list_screen.dart';

void main() {
  setupLocator(); // Set up our dependencies
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NoteProvider()..fetchNotes(), // Create and fetch initial data
      child: MaterialApp(
        title: 'Sqflite Note Saver',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        darkTheme: ThemeData.dark().copyWith(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
            brightness: Brightness.dark,
          ),
        ),
        themeMode: ThemeMode.system,
        home: const NoteListScreen(),
      ),
    );
  }
}