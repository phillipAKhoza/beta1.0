import 'package:flutter/material.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Church Events'),
        automaticallyImplyLeading: false,
      ),
      body: const Center(
        child: Text("No EVENTS AT THE MOMENT"),
      ),
    );
  }
}
