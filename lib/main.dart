import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'app/router.dart';
import 'splash/splash_screen.dart';
import 'features/todo/controller/todo_controller.dart'; // ✅ Import your controller

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Initialize Firebase
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoController(),
      child: MaterialApp(
        title: 'ToDo App',
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: AppRouter.generateRoute,
        home: const SplashScreen(), // ✅ Splash will push to /login
      ),
    );
  }
}
