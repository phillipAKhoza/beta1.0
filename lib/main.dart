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
        '/app': (context) => const MainApp(isAdmin: false),
        '/login': (context) => const LoginScreen(),
        '/login_page': (context) => const LoginPage(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) =>   const HomeScreen(isAdmin: false),
        '/chat': (context) =>  const HomeScreen(isAdmin: false),
        '/liveStream': (context) =>  const HomeScreen(isAdmin: false),
        '/serve': (context) =>  const HomeScreen(isAdmin: false),
        '/more': (context) =>  const HomeScreen(isAdmin: false),
        '/profile': (context) => const ProfileScreen(),
        '/technical': (context) => const TechnicalScreen(),
        '/foundation': (context) => const FoundationScreen(),
        '/notifications': (context) => const NotificationScreen(),
        '/location': (context) => const LocationScreen(),
      },
    );
  }
}
