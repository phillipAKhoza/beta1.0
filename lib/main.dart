import 'package:flutter/material.dart';
import './screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UAFC APP',
      theme: ThemeData(
        primaryColor: Colors.grey[400],
        appBarTheme: const AppBarTheme(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/app': (context) => const MainApp(),
        '/login': (context) => const LoginScreen(),
        '/login_page': (context) => const LoginPage(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/chat': (context) => const HomeScreen(),
        '/liveStream': (context) => const HomeScreen(),
        '/serve': (context) => const HomeScreen(),
        '/more': (context) => const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/technical': (context) => const TechnicalScreen(),
        '/foundation': (context) => const FoundationScreen(),
        '/notifications': (context) => const NoticationScreen(),
        '/location': (context) => const LocationScreen(),
      },
    );
  }
}
