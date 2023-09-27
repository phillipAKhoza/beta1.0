import 'package:flutter/material.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: AdminItems(),
    );
  }
}
class AdminItems extends StatefulWidget {
  const AdminItems({super.key});

  @override
  State<AdminItems> createState() => _AdminItemsState();
}

class _AdminItemsState extends State<AdminItems> {
  final List<String> items = <String>[
    'Feeds',
    'Events',
    'Notifications',
    'Stream',
    'Salvation Journey',
    'Foundations',
    'Location',
    'Kids',
    'Men',
    'Women',
    'Youth',
  ];
  final List<String> path = <String>[
    '/admin_Feeds',
    '/admin_Events',
    '/admin_Notifications',
    '/admin_Stream',
    '/admin_Salvation_Journey',
    '/admin_Foundations',
    '/admin_Location',
    '/admin_Kids',
    '/admin_Men',
    '/admin_Women',
    '/admin_Youth',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Admin'),
        ),
        body: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Card(
                child: ListTile(
                  // leading: Icon(Icons.${icon[index]}),
                  title: const Text("Feeds"),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                          return const SecondRoute();
                        }));
                  },
                )),
            Card(
                child: ListTile(
                  // leading: Icon(Icons.${icon[index]}),
                  title: const Text("Events"),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                          return const SecondRoute();
                        }));
                  },
                )),
            Card(
                child: ListTile(
                  // leading: Icon(Icons.${icon[index]}),
                  title: const Text("Notifications"),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                          return const SecondRoute();
                        }));
                  },
                )),
            Card(
                child: ListTile(
                  // leading: Icon(Icons.${icon[index]}),
                  title: const Text("Stream"),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                          return const SecondRoute();
                        }));
                  },
                )),
            Card(
                child: ListTile(
                  // leading: Icon(Icons.${icon[index]}),
                  title: const Text("Salvation Journey"),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                          return const SecondRoute();
                        }));
                  },
                )),
            Card(
                child: ListTile(
                  // leading: Icon(Icons.${icon[index]}),
                  title: const Text("Foundations"),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                          return const SecondRoute();
                        }));
                  },
                )),
            Card(
                child: ListTile(
                  // leading: Icon(Icons.${icon[index]}),
                  title: const Text("Location"),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                          return const SecondRoute();
                        }));
                  },
                )),
            Card(
                child: ListTile(
                  // leading: Icon(Icons.${icon[index]}),
                  title: const Text("Kids"),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                          return const SecondRoute();
                        }));
                  },
                )),
            Card(
                child: ListTile(
                  // leading: Icon(Icons.${icon[index]}),
                  title: const Text("Men"),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                          return const SecondRoute();
                        }));
                  },
                )),
            Card(
                child: ListTile(
                  // leading: Icon(Icons.${icon[index]}),
                  title: const Text("Women"),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                          return const SecondRoute();
                        }));
                  },
                )),
            Card(
                child: ListTile(
                  // leading: Icon(Icons.${icon[index]}),
                  title: const Text("Youth"),
                  trailing: const Icon(Icons.keyboard_arrow_right),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                          return const SecondRoute();
                        }));
                  },
                )),
          ],
        ));
  }
}

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Route'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}

