import 'dart:io';
import 'package:flutter/material.dart';
import 'package:staff_face/presentation/home/views/home.dart';
import 'package:window_manager/window_manager.dart';

import 'presentation/home/views/welcomepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bigeye',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          textTheme: const TextTheme(
            displayLarge: TextStyle(fontFamily: 'serif'),
          )),
      home: WelcomePage(),
    );
  }
}
