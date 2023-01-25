import 'package:flutter/material.dart';
import './screens.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "WESTSIDE",
          style: TextStyle(fontSize: 10),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.location_pin),
            tooltip: 'location Icon',
            onPressed: () => {
              Navigator.of(context).push(
                  MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                return const LocationScreen();
              }))
            },
          ), //IconButton
          IconButton(
            icon: const Icon(Icons.notifications),
            tooltip: 'nitifications Icon',
            onPressed: () => {
              Navigator.of(context).push(
                  MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                return const NoticationScreen();
              }))
            },
          ), //IconButton
        ], //<Widget>[]
        backgroundColor: Colors.white,
        elevation: 0.3,
        leading: Transform.scale(
          scale: 1,
          child: IconButton(
            icon: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
            ),
            tooltip: 'Menu Icon',
            onPressed: () {},
          ),
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50.0),
            child: AppBar(
              bottom: const TabBar(
                indicatorColor: Colors.black,
                tabs: [
                  Tab(
                    text: 'My Feed',
                  ),
                  Tab(
                    text: 'My Journey',
                  ),
                ],
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              Myfeed(),
              Center(child: Text('JOURNEY')),
            ],
          ),
        ),
      ),
    );
  }
}

class Myfeed extends StatelessWidget {
  const Myfeed({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
            child: InkWell(
              child: const Card(
                child: ListTile(
                  leading: Icon(Icons.calendar_month_outlined),
                  title: Text(
                    'Church Events',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                  return const EventsScreen();
                }));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
            child: InkWell(
              child: const Card(
                child: ListTile(
                  leading: Icon(Icons.book_sharp),
                  title: Text(
                    'Ministries',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right),
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                  return const Ministryscreen();
                }));
              },
            ),
          ),
          const Text(
            'YOUR FEED',
            style: TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(48.0),
            child: Center(child: Text('AWAITING DATA....')),
          )
        ],
      ),
    ));
  }
}
