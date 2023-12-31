import 'package:flutter/material.dart';
import './screens.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key, required this.isAdmin});
  final bool isAdmin;
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  late List<dynamic> screens;
  late bool isAdmin;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isAdmin = widget.isAdmin;
     screens = [
       HomeScreen(isAdmin:isAdmin),
      const ChatScreen(),
      const StreamScreen(),
      const DonateScreen(),
       MoreScreen(isAdmin),
    ];
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: 'Stream',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Donate',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'More',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 0, 0, 0),
        onTap: _onItemTapped,
      ),
    );
  }
}
