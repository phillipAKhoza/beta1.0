import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.house),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.message),
          label: 'Chat',
        ),
        BottomNavigationBarItem(
          // selectedIcon: Icon(Icons.wallet),
          icon: Icon(Icons.wallet_outlined),
          label: 'Give',
        ),
        BottomNavigationBarItem(
          // selectedIcon: Icon(Icons.favorite),
          icon: Icon(Icons.favorite),
          label: 'Serve',
        ),
        BottomNavigationBarItem(
          // selectedIcon: Icon(Icons.list),
          icon: Icon(Icons.list),
          label: 'More',
        ),
      ],
      // fixedColor: Colors.da[200],
      onTap: (int idx) {
        switch (idx) {
          case 0:
            // do nothing
            break;
          case 1:
            Navigator.pushNamed(context, '/chat');
            break;
          case 2:
            Navigator.pushNamed(context, '/liveStream');
            break;
          case 3:
            Navigator.pushNamed(context, '/serve');
            break;
          case 4:
            Navigator.pushNamed(context, '/more');
            break;
        }
      },
    );
  }
}
