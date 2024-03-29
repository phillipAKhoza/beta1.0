import 'package:flutter/material.dart';
import './screens.dart';
import '../services/auth.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 1000,
              child: MoreItems(),
            )
          ],
        ),
      ),
    );
  }
}

class MoreItems extends StatefulWidget {
  const MoreItems({super.key});

  @override
  State<MoreItems> createState() => _MoreItemsState();
}

class _MoreItemsState extends State<MoreItems> {
  final List<String> items = <String>[
    'Profile',
    'UAFC Foundations',
    'Technical Support',
    'SignOut',
    'Privacy Policy',
    'Terms Of Use',
    'Admin'
  ];
  final List<String> path = <String>[
    '/profile',
    '/foundation',
    '/technical',
    '/login',
    '/policy',
    '/terms',
    '/admin'
  ];
  bool? isAdmin = CurrentUser.getAdminStatus();

  @override
  void initState() {
    super.initState();
    isAdmin = CurrentUser.getAdminStatus();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('More'),
          automaticallyImplyLeading: false,
        ),
        body: ListView(
          padding: const EdgeInsets.all(8),
          children: <Widget>[
            Card(
                child: ListTile(
              // leading: Icon(Icons.${icon[index]}),
              title: const Text("Profile"),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                  return const ProfileScreen();
                }));
              },
            )),
            Card(
                child: ListTile(
              // leading: Icon(Icons.${icon[index]}),
              title: const Text("UAFC Foundations"),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                  return const FoundationScreen();
                }));
              },
            )),
            Card(
                child: ListTile(
              // leading: Icon(Icons.${icon[index]}),
              title: const Text("Technical Support"),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                  return const TechnicalScreen();
                }));
              },
            )),
            Card(
                child: ListTile(
              // leading: Icon(Icons.${icon[index]}),
              title: const Text("Privacy Policy"),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                  return const PrivacyPolicy();
                }));
              },
            )),
            Card(
                child: ListTile(
              // leading: Icon(Icons.${icon[index]}),
              title: const Text("Terms Of Use"),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                  return const TermsOfUseScreen();
                }));
              },
            )),
            if(isAdmin == true)...[
              Card(
                  child: ListTile(
                    // leading: Icon(Icons.${icon[index]}),
                    title: const Text("Admin"),
                    trailing: const Icon(Icons.keyboard_arrow_right),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute<dynamic>(builder: (BuildContext context) {
                            return const AdminScreen();
                          }));
                    },
                  )),
            ],
            Card(
                child: ListTile(
              // leading: Icon(Icons.${icon[index]}),
              title: const Text("SignOut"),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {
                Authentication().signOut().then((value) => Navigator.of(context)
                        .push(MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) {
                      return const LoginScreen();
                    })));
              },
            )),
          ],
        ));
  }
}
