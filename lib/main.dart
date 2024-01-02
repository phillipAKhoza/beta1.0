import 'package:flutter/material.dart';
import './screens/screens.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
        '/home': (context) =>   const HomeScreen(),
        '/chat': (context) =>  const HomeScreen(),
        '/liveStream': (context) =>  const HomeScreen(),
        '/serve': (context) =>  const HomeScreen(),
        '/more': (context) =>  const HomeScreen(),
        '/profile': (context) => const ProfileScreen(),
        '/technical': (context) => const TechnicalScreen(),
        '/foundation': (context) => const FoundationScreen(),
        '/notifications': (context) => const NotificationScreen(),
        '/location': (context) => const LocationScreen(),
      },
    );
  }
}
