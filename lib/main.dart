import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'modules/menu/splash_screen.dart';
import 'package:examen_oscar_barrios/modules/auth/screens/login_true.dart';
import 'modules/auth/screens/register.dart';
import './navigation/navigation.dart';
import './navigation/home.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Asegura la inicialización completa

  // Inicialización de Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp()); // Ejecuta la aplicación principal
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Oculta la etiqueta de modo debug
      initialRoute: '/login', // Ruta inicial
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginTrue(),
        '/register': (context) => const Register(),
        '/menu': (context) => const Navigation(),
        '/home': (context) => const Home()
      },
    );
  }
}
